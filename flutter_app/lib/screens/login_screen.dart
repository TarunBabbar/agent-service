import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Krishna Pharmacy Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Mobile Number')),
            const SizedBox(height: 12),
            TextField(controller: _otpController, decoration: const InputDecoration(labelText: 'OTP')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => appState.loginWithOtp(_phoneController.text, _otpController.text),
              child: const Text('Login with OTP'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: appState.loginWithGmail,
              child: const Text('Continue with Gmail'),
            ),
          ],
        ),
      ),
    );
  }
}
