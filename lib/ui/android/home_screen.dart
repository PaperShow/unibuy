import 'package:flutter/material.dart';

class AndroidHomeScreen extends StatelessWidget {
  const AndroidHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.android, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Welcome to Android UI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {},
              child: const Text('Material 3 Action'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
