import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unibuy/core/utils/theme.dart';
import 'package:unibuy/presentation/routes/app_routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Unibuy',
      theme: SocialECommerceTheme.lightTheme,
      darkTheme: SocialECommerceTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
