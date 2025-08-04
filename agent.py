from langchain_ollama import OllamaLLM
from langchain_core.messages import HumanMessage, AIMessage, SystemMessage
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)
from flask import Flask, request, jsonify
import re
app = Flask(__name__)

# Load LLM
llm = OllamaLLM(model="mistral", temperature=0.5)

# Convert history to LangChain messages
def convert_gradio_history(gradio_history, code_only=True):
    system_prompt = (
        "You are an expert software engineer. Only return the code block in response, without any explanations or comments. Do not write anything other than code."
        if code_only else
        "You are an expert software engineer. Generate clean, well-documented code based on user requirements."
    )
    messages = [SystemMessage(content=system_prompt)]
    for msg in gradio_history:
        if msg["role"] == "user":
            messages.append(HumanMessage(content=msg["content"]))
        elif msg["role"] == "assistant":
            messages.append(AIMessage(content=msg["content"]))
    return messages

# Stream response
def generate_response(messages):
    for chunk in llm.stream(messages):
        yield chunk

@app.route("/", methods=["GET"])
def health_check():
    return jsonify({"status": "ok", "message": "TarunBot is running 🚀"})

@app.route("/test-llm", methods=["GET"])
def test_llm():
    try:
        from langchain_core.messages import HumanMessage, SystemMessage

        messages = [
            SystemMessage(content="You are a helpful assistant."),
            HumanMessage(content="Say Hello"),
        ]

        response = ""
        for chunk in llm.stream(messages):
            response += chunk

        return jsonify({"llm_response": response})

    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({"error": "LLM call failed", "details": str(e)}), 500

@app.route("/chat", methods=["POST"])
def chat():
    if not request.is_json:
        return jsonify({"error": "Invalid or missing JSON in request"}), 400
    
    data = request.json

    # Validate history
    history = data.get("history")
    if not history or not isinstance(history, list):
        return jsonify({"error": "Missing or invalid 'history' field. It should be a list of messages."}), 400

     # Validate message format
    for msg in history:
        if not isinstance(msg, dict) or "role" not in msg or "content" not in msg:
            return jsonify({"error": "Each history item must be a dict with 'role' and 'content' keys."}), 400

     # Optional flag
    code_only = data.get("code_only", True)

    # Generate LangChain messages
    messages = convert_gradio_history(data["history"], code_only=code_only)
    full_response = ""
    for chunk in generate_response(messages):
        full_response += chunk

    # Clean up markdown
    if code_only:
        match = re.search(r"```(?:\w+)?\n(.*?)```", full_response, re.DOTALL)
        if match:
            full_response = match.group(1).strip()

    return jsonify({"content": full_response})

# CLI loop
def chat_loop():
    history = []
    print("🧠 CodeGen Agent Ready. Type your prompt:")
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

# Entry point
if __name__ == "__main__":
    app.run(port=5000, debug=True)