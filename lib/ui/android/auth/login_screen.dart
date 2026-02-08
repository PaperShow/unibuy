import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';

class AndroidLoginScreen extends ConsumerStatefulWidget {
  const AndroidLoginScreen({super.key});

  @override
  ConsumerState<AndroidLoginScreen> createState() => _AndroidLoginScreenState();
}

class _AndroidLoginScreenState extends ConsumerState<AndroidLoginScreen> {
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
      } else {
        // Router will redirect to home
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag, size: 80, color: Colors.green),
              const SizedBox(height: 32),
              Text(
                'Welcome to Unibuy',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 48),
              if (_isLoading)
                const CircularProgressIndicator()
              else ...[
                _buildSocialButton(
                  label: 'Sign in with Google',
                  icon: Icons.g_mobiledata,
                  color: Colors.red,
                  onPressed: () => _handleSocialSignIn(
                      () => ref.read(authServiceProvider).signInWithGoogle()),
                ),
                const SizedBox(height: 16),
                _buildSocialButton(
                  label: 'Sign in with Apple',
                  icon: Icons.apple,
                  color: Colors.black,
                  onPressed: () => _handleSocialSignIn(
                      () => ref.read(authServiceProvider).signInWithApple()),
                ),
                const SizedBox(height: 16),
                _buildSocialButton(
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
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
        ),
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Icon(icon, color: color, size: 28),
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
