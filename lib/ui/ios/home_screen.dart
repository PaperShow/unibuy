import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSHomeScreen extends StatelessWidget {
  const IOSHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('iOS Home'),
        trailing: Icon(CupertinoIcons.add),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.device_phone_portrait,
                size: 64, color: CupertinoColors.activeBlue),
            const SizedBox(height: 16),
            const Text(
              'Welcome to iOS UI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: CupertinoColors.label,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoButton.filled(
              onPressed: () {},
              child: const Text('Cupertino Action'),
            ),
          ],
        ),
      ),
    );
  }
}
