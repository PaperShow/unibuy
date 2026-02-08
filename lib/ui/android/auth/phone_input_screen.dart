import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class AndroidPhoneInputScreen extends ConsumerStatefulWidget {
  const AndroidPhoneInputScreen({super.key});

  @override
  ConsumerState<AndroidPhoneInputScreen> createState() =>
      _AndroidPhoneInputScreenState();
}

class _AndroidPhoneInputScreenState extends ConsumerState<AndroidPhoneInputScreen> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyPhone() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProvider).verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-resolution on Android (instant verification)
          await FirebaseAuth.instance.signInWithCredential(credential);
          // Router handles navigation
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification Failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          // Navigate to OTP Screen
          context.push('/verify-otp', extra: {
            'verificationId': verificationId,
            'phoneNumber': phone,
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enter your mobile number to verify your account.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number (e.g., +1555010999)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _isLoading ? null : _verifyPhone,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Send Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
