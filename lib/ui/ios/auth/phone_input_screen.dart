import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class IOSPhoneInputScreen extends ConsumerStatefulWidget {
  const IOSPhoneInputScreen({super.key});

  @override
  ConsumerState<IOSPhoneInputScreen> createState() =>
      _IOSPhoneInputScreenState();
}

class _IOSPhoneInputScreenState extends ConsumerState<IOSPhoneInputScreen> {
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
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
              title: const Text("Verification Failed"),
              content: Text(e.message ?? "Unknown error"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          context.push('/verify-otp', extra: {
            'verificationId': verificationId,
            'phoneNumber': phone,
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text("Error"),
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
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Enter Phone Number'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Text(
                'Please enter your mobile number to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.label,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 24),
              CupertinoTextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                placeholder: 'Phone Number (e.g., +1555010999)',
                padding: const EdgeInsets.all(16),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.phone),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _isLoading ? null : _verifyPhone,
                  child: _isLoading
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white)
                      : const Text('Send Code'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
