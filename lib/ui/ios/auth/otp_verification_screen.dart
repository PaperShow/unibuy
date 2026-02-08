import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class IOSOtpVerificationScreen extends ConsumerStatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const IOSOtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  ConsumerState<IOSOtpVerificationScreen> createState() =>
      _IOSOtpVerificationScreenState();
}

class _IOSOtpVerificationScreenState
    extends ConsumerState<IOSOtpVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) return; // Basic check

    setState(() => _isLoading = true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.linkWithCredential(credential);
      } else {
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
      
      if (user != null && mounted) {
         context.go('/user-details');
      }

    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text("Verification Failed"),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Verify OTP')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter the 6-digit code sent to ${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16, 
                  color: CupertinoColors.label,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 24),
              CupertinoTextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 8, color: CupertinoColors.label),
                placeholder: '000000',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _isLoading ? null : _verifyOtp,
                  child: _isLoading
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white)
                      : const Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
