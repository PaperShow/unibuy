import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class IOSLoginScreen extends ConsumerStatefulWidget {
  const IOSLoginScreen({super.key});

  @override
  ConsumerState<IOSLoginScreen> createState() => _IOSLoginScreenState();
}

class _IOSLoginScreenState extends ConsumerState<IOSLoginScreen> {
  bool _isLoading = false;

  Future<void> _handleSocialSignIn(Future<void> Function() signInMethod) async {
    setState(() => _isLoading = true);
    try {
      await signInMethod();
      // Check if phone number is verified/linked
      final user = ref.read(authServiceProvider).currentUser;
      if (user != null && user.phoneNumber == null) {
        if (mounted) context.push('/verify-phone');
      }
    } catch (e) {
      if (mounted) {
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
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Unibuy'),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.cart_fill,
                    size: 80, color: CupertinoColors.activeGreen),
                const SizedBox(height: 32),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.label,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 48),
                if (_isLoading)
                  const CupertinoActivityIndicator()
                else ...[
                  _buildSocialButton(
                    label: 'Sign in with Google',
                    icon: Icons.g_mobiledata, // Material Icon
                    color: CupertinoColors.systemRed,
                    onPressed: () => _handleSocialSignIn(
                        () => ref.read(authServiceProvider).signInWithGoogle()),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    label: 'Sign in with Apple',
                    icon: Icons.apple, // Material Icon
                    color: CupertinoColors.black,
                    onPressed: () => _handleSocialSignIn(
                        () => ref.read(authServiceProvider).signInWithApple()),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    label: 'Sign in with Phone',
                    icon: CupertinoIcons.phone_fill,
                    color: CupertinoColors.activeBlue,
                    onPressed: () => context.push('/verify-phone'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: CupertinoColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
