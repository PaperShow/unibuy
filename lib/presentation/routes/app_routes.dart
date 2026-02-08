import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/ui/android/home_screen.dart';
import 'package:unibuy/ui/ios/home_screen.dart';
import 'package:unibuy/ui/web/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const String home = '/';

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) {
          if (kIsWeb) {
            return const WebHomeScreen();
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return const IOSHomeScreen();
          } else {
            // Default to Android/Material for others (Android, Windows, Linux, macOS)
            // Or add more specific checks if needed
            return const AndroidHomeScreen();
          }
        },
      ),
    ],
  );
}
