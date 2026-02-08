import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unibuy/core/providers/auth_provider.dart';
import 'package:unibuy/ui/android/auth/login_screen.dart';
import 'package:unibuy/ui/android/auth/otp_verification_screen.dart';
import 'package:unibuy/ui/android/auth/phone_input_screen.dart';
import 'package:unibuy/ui/android/auth/user_details_screen.dart';
import 'package:unibuy/ui/android/home_screen.dart';
import 'package:unibuy/ui/ios/auth/login_screen.dart';
import 'package:unibuy/ui/ios/auth/otp_verification_screen.dart';
import 'package:unibuy/ui/ios/auth/phone_input_screen.dart';
import 'package:unibuy/ui/ios/auth/user_details_screen.dart';
import 'package:unibuy/ui/ios/home_screen.dart';
import 'package:unibuy/ui/web/auth/login_screen.dart';
import 'package:unibuy/ui/web/auth/otp_verification_screen.dart';
import 'package:unibuy/ui/web/auth/phone_input_screen.dart';
import 'package:unibuy/ui/web/auth/user_details_screen.dart';
import 'package:unibuy/ui/web/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authService.authStateChanges),
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final path = state.uri.path;

      final isPublicRoute = path == '/login' ||
                            path == '/verify-phone' ||
                            path == '/verify-otp';

      if (!isLoggedIn && !isPublicRoute) return '/login';
      
      // If logged in and on login/verify pages, redirect to home? 
      // Maybe not verify pages if linking phone.
      if (isLoggedIn && path == '/login') return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          if (kIsWeb) {
            return const WebHomeScreen();
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return const IOSHomeScreen();
          } else {
            return const AndroidHomeScreen();
          }
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          if (kIsWeb) {
            return const WebLoginScreen();
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return const IOSLoginScreen();
          } else {
            return const AndroidLoginScreen();
          }
        },
      ),
      GoRoute(
        path: '/verify-phone',
        builder: (context, state) {
           if (kIsWeb) {
            return const WebPhoneInputScreen();
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return const IOSPhoneInputScreen();
          } else {
            return const AndroidPhoneInputScreen();
          }
        },
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          final verificationId = extras['verificationId'] as String;
          final phoneNumber = extras['phoneNumber'] as String;
          
          if (kIsWeb) {
            return WebOtpVerificationScreen(verificationId: verificationId, phoneNumber: phoneNumber);
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return IOSOtpVerificationScreen(verificationId: verificationId, phoneNumber: phoneNumber);
          } else {
            return AndroidOtpVerificationScreen(verificationId: verificationId, phoneNumber: phoneNumber);
          }
        },
      ),
      GoRoute(
        path: '/user-details',
        builder: (context, state) {
           if (kIsWeb) {
            return const WebUserDetailsScreen();
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return const IOSUserDetailsScreen();
          } else {
            return const AndroidUserDetailsScreen();
          }
        },
      ),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
