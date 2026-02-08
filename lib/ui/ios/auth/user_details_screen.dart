import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';
import 'package:unibuy/core/providers/firestore_provider.dart';

class IOSUserDetailsScreen extends ConsumerStatefulWidget {
  const IOSUserDetailsScreen({super.key});

  @override
  ConsumerState<IOSUserDetailsScreen> createState() =>
      _IOSUserDetailsScreenState();
}

class _IOSUserDetailsScreenState extends ConsumerState<IOSUserDetailsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
          additionalData: {
             if (_emailController.text.isNotEmpty) 'contactEmail': _emailController.text.trim(),
          }
        );
      }
      if (mounted) context.go('/');
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

  void _skip() {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Complete Profile'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _skip,
          child: const Text('Skip'),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
               const Text(
                'Tell us a bit about yourself',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                   decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 24),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Full Name',
                padding: const EdgeInsets.all(16),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.person),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email Address (Optional)',
                padding: const EdgeInsets.all(16),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.mail),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _isLoading ? null : _saveDetails,
                  child: _isLoading
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white)
                      : const Text('Save & Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
