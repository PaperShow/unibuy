import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';
import 'package:unibuy/core/providers/firestore_provider.dart';

class AndroidUserDetailsScreen extends ConsumerStatefulWidget {
  const AndroidUserDetailsScreen({super.key});

  @override
  ConsumerState<AndroidUserDetailsScreen> createState() =>
      _AndroidUserDetailsScreenState();
}

class _AndroidUserDetailsScreenState
    extends ConsumerState<AndroidUserDetailsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill if available
    final user = ref.read(authServiceProvider).currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _saveDetails() async {
    setState(() => _isLoading = true);
    try {
      final user = ref.read(authServiceProvider).currentUser;
      if (user != null) {
        await ref.read(firestoreServiceProvider).saveUserDetails(
          user: user,
          name: _nameController.text.trim(),
          // Don't override email if it's already verified/from provider unless empty
          // But here we might just save additional data
          additionalData: {
             if (_emailController.text.isNotEmpty) 'contactEmail': _emailController.text.trim(),
          }
        );
      }
      if (mounted) context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving details: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _skip() {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
        actions: [
          TextButton(
            onPressed: _skip,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Tell us a bit about yourself',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address (Optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _isLoading ? null : _saveDetails,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save & Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
