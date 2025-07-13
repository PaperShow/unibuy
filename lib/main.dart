import 'package:flutter/material.dart';
import 'package:unibuy/core/utils/theme.dart';
import 'package:unibuy/presentation/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UNibuy',
      theme: SocialECommerceTheme.lightTheme,
      darkTheme: SocialECommerceTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
