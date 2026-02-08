import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class WebLoginScreen extends ConsumerStatefulWidget {
  const WebLoginScreen({super.key});

  @override
  ConsumerState<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends ConsumerState<WebLoginScreen> {
  bool _isLoading = false;

  Future<void> _handleSocialSignIn(
      Future<void> Function() signInMethod) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.web, size: 64, color: Colors.blueAccent),
                const SizedBox(height: 24),
                Text(
                  'Welcome to Unibuy Web',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                if (_isLoading)
                  const CircularProgressIndicator()
                else ...[
                  _buildSocialButton(
                    context: context,
                    label: 'Sign in with Google',
                    icon: Icons.g_mobiledata,
                    color: Colors.red,
                    onPressed: () => _handleSocialSignIn(
                        () => ref.read(authServiceProvider).signInWithGoogle()),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    context: context,
                    label: 'Sign in with Apple',
                    icon: Icons.apple,
                    color: Colors.black,
                    onPressed: () => _handleSocialSignIn(
                        () => ref.read(authServiceProvider).signInWithApple()),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    context: context,
                    label: 'Sign in with Phone',
                    icon: Icons.phone,
                    color: Colors.blue,
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
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
        ),
        icon: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Icon(icon, color: color, size: 24),
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
