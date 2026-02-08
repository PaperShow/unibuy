import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class AndroidOtpVerificationScreen extends ConsumerStatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const AndroidOtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  ConsumerState<AndroidOtpVerificationScreen> createState() =>
      _AndroidOtpVerificationScreenState();
}

class _AndroidOtpVerificationScreenState
    extends ConsumerState<AndroidOtpVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) return; // Basic check

    setState(() => _isLoading = true);
    try {
      // Create credential using the verification ID from previous screen
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      // Check if user is already signed in (Social Auth linking case)
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Link credential
        await user.linkWithCredential(credential);
      } else {
        // Sign in with credential
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
      
      // Navigation is handled by router listening to auth state or manual push
      // But typically router handles it.
      // However, for Linking, the auth state technically doesn't change from "signed in" to "signed in",
      // so we might need manual navigation if already signed in.
      if (user != null && mounted) {
         context.go('/user-details');
      }

    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification Failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the 6-digit code sent to ${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counterText: "",
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
