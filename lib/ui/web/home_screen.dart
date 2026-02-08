import 'package:flutter/material.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Home'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('About'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Contact'),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.web, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Web UI',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'This UI is optimized for larger screens and desktop interaction.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Explore Features'),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
