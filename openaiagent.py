from flask import Flask, request, jsonify
from langchain_core.messages import HumanMessage, AIMessage, SystemMessage
import openai
import re
import warnings
import os

warnings.filterwarnings("ignore", category=DeprecationWarning)
app = Flask(__name__)

# 🔐 Set your OpenAI API key
openai.api_key = os.getenv("OPENAI_API_KEY") or "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"

# 🧠 Convert history to OpenAI-compatible messages
def convert_gradio_history(gradio_history, code_only=True):
    system_prompt = (
        "You are an expert software engineer. Only return the code block in response, without any explanations or comments. Do not write anything other than code."
        if code_only else
        "You are an expert software engineer. Generate clean, well-documented code based on user requirements."
    )
    messages = []
    for msg in gradio_history:
        if isinstance(msg, list) and len(msg) == 2:
            messages.append({"role": msg[0], "content": msg[1]})
        elif isinstance(msg, dict):
            messages.append(msg)
    return messages


# 🚀 Stream response from OpenAI
def generate_response(messages):
    response = openai.ChatCompletion.create(
        model="gpt-4o-mini",
        messages=messages,
        temperature=0.5,
        stream=True
    )
    for chunk in response:
        if "choices" in chunk and len(chunk["choices"]) > 0:
            delta = chunk["choices"][0]["delta"]
            if "content" in delta:
                yield delta["content"]

@app.route("/chat", methods=["POST"])
def chat():
    data = request.json
    code_only = data.get("code_only", True)
    messages = convert_gradio_history(data["history"], code_only=code_only)
    full_response = ""
    for chunk in generate_response(messages):
        full_response += chunk

    # 🧹 Clean up Markdown-style code blocks
    if code_only:
        match = re.search(r"```(?:\w+)?\n(.*?)```", full_response, re.DOTALL)
        if match:
            full_response = match.group(1).strip()

    return jsonify({"content": full_response})

# 🖥️ CLI loop
def chat_loop():
    history = []
    print("🧠 CodeGen Agent (OpenAI) Ready. Type your prompt:")
    while True:
        user_input = input("You: ")
        if user_input.lower() in ["exit", "quit"]:
            break
        history.append({"role": "user", "content": user_input})
        messages = convert_gradio_history(history)
        print("Agent:", end=" ", flush=True)
        full_response = ""
        for chunk in generate_response(messages):
            print(chunk, end="", flush=True)
            full_response += chunk
        print("\n")
        history.append({"role": "assistant", "content": full_response})

# 🏁 Entry point
if __name__ == "__main__":
    app.run(port=5000)