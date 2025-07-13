// File: lib/core/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Navigation Keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String main = '/main';
  static const String home = '/home';
  static const String shop = '/shop';
  static const String social = '/social';
  static const String profile = '/profile';
  static const String productDetail = '/product/:id';
  static const String productList = '/products';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String orderDetail = '/order/:orderId';
  static const String search = '/search';
  static const String categories = '/categories';
  static const String categoryDetail = '/category/:categoryId';
  static const String wishlist = '/wishlist';
  static const String settings = '/settings';
  static const String accountSettings = '/settings/account';
  static const String privacySettings = '/settings/privacy';
  static const String notifications = '/notifications';
  static const String error = '/error';

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splash,
    debugLogDiagnostics: true,

    // Error handling
    // errorBuilder: (context, state) => ErrorScreen(
    //   error: state.error.toString(),
    //   onRetry: () => context.go(home),
    // ),

    // Redirect logic for authentication
    // redirect: (context, state) {
    //   final isLoggedIn = _isUserLoggedIn(); // Implement your auth logic
    //   final isGoingToAuth = state.location.startsWith('/login') ||
    //                        state.location.startsWith('/register') ||
    //                        state.location.startsWith('/forgot-password');
    //   final isGoingToOnboarding = state.location == onboarding;
    //   final isGoingToSplash = state.location == splash;

    //   // Show onboarding if first time user
    //   if (!_hasSeenOnboarding() && !isGoingToOnboarding && !isGoingToSplash) {
    //     return onboarding;
    //   }

    //   // Redirect to login if not authenticated
    //   if (!isLoggedIn && !isGoingToAuth && !isGoingToOnboarding && !isGoingToSplash) {
    //     return login;
    //   }

    //   // Redirect to home if already logged in and going to auth
    //   if (isLoggedIn && isGoingToAuth) {
    //     return home;
    //   }

    //   return null;
    // },
    routes: [
      // Splash Screen
      // GoRoute(
      //   path: splash,
      //   builder: (context, state) => const SplashScreen(),
      // ),

      // // Onboarding
      // GoRoute(
      //   path: onboarding,
      //   builder: (context, state) => const OnboardingScreen(),
      // ),

      // // Authentication Routes
      // GoRoute(
      //   path: login,
      //   builder: (context, state) => const LoginScreen(),
      // ),
      // GoRoute(
      //   path: register,
      //   builder: (context, state) => const RegisterScreen(),
      // ),
      // GoRoute(
      //   path: forgotPassword,
      //   builder: (context, state) => const ForgotPasswordScreen(),
      // ),

      // Main App Shell with Bottom Navigation
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return MainScreen(child: child);
      //   },
      //   routes: [
      //     // Home Tab
      //     GoRoute(
      //       path: home,
      //       builder: (context, state) => const HomeScreen(),
      //       routes: [
      //         GoRoute(
      //           path: 'search',
      //           builder: (context, state) => SearchScreen(
      //             query: state.queryParameters['q'] ?? '',
      //           ),
      //         ),
      //         GoRoute(
      //           path: 'categories',
      //           builder: (context, state) => const CategoriesScreen(),
      //           routes: [
      //             GoRoute(
      //               path: ':categoryId',
      //               builder: (context, state) => CategoryDetailScreen(
      //                 categoryId: state.params['categoryId']!,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),

      //     // Shop Tab
      //     GoRoute(
      //       path: shop,
      //       builder: (context, state) => const ShopScreen(),
      //       routes: [
      //         GoRoute(
      //           path: 'products',
      //           builder: (context, state) => ProductListScreen(
      //             category: state.queryParameters['category'],
      //             sortBy: state.queryParameters['sort'],
      //           ),
      //         ),
      //       ],
      //     ),

      //     // Social Tab
      //     GoRoute(
      //       path: social,
      //       builder: (context, state) => const SocialScreen(),
      //     ),

      //     // Profile Tab
      //     GoRoute(
      //       path: profile,
      //       builder: (context, state) => const ProfileScreen(),
      //       routes: [
      //         GoRoute(
      //           path: 'orders',
      //           builder: (context, state) => const OrdersScreen(),
      //           routes: [
      //             GoRoute(
      //               path: ':orderId',
      //               builder: (context, state) => OrderDetailScreen(
      //                 orderId: state.params['orderId']!,
      //               ),
      //             ),
      //           ],
      //         ),
      //         GoRoute(
      //           path: 'wishlist',
      //           builder: (context, state) => const WishlistScreen(),
      //         ),
      //         GoRoute(
      //           path: 'settings',
      //           builder: (context, state) => const SettingsScreen(),
      //           routes: [
      //             GoRoute(
      //               path: 'account',
      //               builder: (context, state) => const AccountSettingsScreen(),
      //             ),
      //             GoRoute(
      //               path: 'privacy',
      //               builder: (context, state) => const PrivacySettingsScreen(),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

      // // Full Screen Routes (outside shell)
      // GoRoute(
      //   path: '/product/:id',
      //   builder: (context, state) => ProductDetailScreen(
      //     productId: state.params['id']!,
      //   ),
      // ),

      // GoRoute(
      //   path: cart,
      //   builder: (context, state) => const CartScreen(),
      // ),

      // GoRoute(
      //   path: checkout,
      //   builder: (context, state) => CheckoutScreen(
      //     items: state.extra as List<dynamic>?,
      //   ),
      // ),

      // GoRoute(
      //   path: notifications,
      //   builder: (context, state) => const NotificationsScreen(),
      // ),
    ],
  );

  // Helper methods (implement based on your auth logic)
  static bool _isUserLoggedIn() {
    // Implement your authentication check logic
    // For example: return AuthService.instance.isLoggedIn;
    return false; // Placeholder
  }

  static bool _hasSeenOnboarding() {
    // Implement your onboarding check logic
    // For example: return PreferencesService.instance.hasSeenOnboarding;
    return false; // Placeholder
  }
}

// File: lib/core/routing/navigation_extensions.dart
extension NavigationExtensions on BuildContext {
  // Navigation helpers
  void goToHome() => go(AppRouter.home);
  void goToLogin() => go(AppRouter.login);
  void goToRegister() => go(AppRouter.register);
  void goToProfile() => go(AppRouter.profile);
  void goToCart() => go(AppRouter.cart);
  void goToSearch({String? query}) =>
      go('${AppRouter.home}/search${query != null ? '?q=$query' : ''}');
  void goToNotifications() => go(AppRouter.notifications);
  void goToSettings() => go('${AppRouter.profile}/settings');
  void goToOrders() => go('${AppRouter.profile}/orders');
  void goToWishlist() => go('${AppRouter.profile}/wishlist');

  // Product navigation
  void goToProduct(String productId) => go('/product/$productId');
  void goToProductList({String? category, String? sortBy}) {
    String path = '${AppRouter.shop}/products';
    List<String> params = [];
    if (category != null) params.add('category=$category');
    if (sortBy != null) params.add('sort=$sortBy');
    if (params.isNotEmpty) path += '?${params.join('&')}';
    go(path);
  }

  // Category navigation
  void goToCategories() => go('${AppRouter.home}/categories');
  void goToCategory(String categoryId) =>
      go('${AppRouter.home}/categories/$categoryId');

  // Order navigation
  void goToOrderDetail(String orderId) =>
      go('${AppRouter.profile}/orders/$orderId');

  // Checkout navigation
  void goToCheckout({List<dynamic>? items}) =>
      go(AppRouter.checkout, extra: items);

  // Modal navigation
  void showProductModal(String productId) => push('/product/$productId');
  void showCartModal() => push(AppRouter.cart);
}

// File: lib/core/routing/route_observer.dart
class AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation('POP', route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation('REPLACE', newRoute, oldRoute);
  }

  void _logNavigation(String action, Route? route, Route? previousRoute) {
    print(
      '🚀 Navigation $action: ${route?.settings.name} <- ${previousRoute?.settings.name}',
    );
  }
}

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
      route: AppRouter.home,
    ),
    NavigationItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Shop',
      route: AppRouter.shop,
    ),
    NavigationItem(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: 'Social',
      route: AppRouter.social,
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
      route: AppRouter.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(_navigationItems[index].route);
        },
        type: BottomNavigationBarType.fixed,
        items: _navigationItems.map((item) {
          final isActive = _navigationItems.indexOf(item) == _currentIndex;
          return BottomNavigationBarItem(
            icon: Icon(isActive ? item.activeIcon : item.icon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}

// File: lib/main.dart - Updated to use routing
// import 'package:flutter/material.dart';
// import 'core/routing/app_router.dart';
// import 'core/routing/route_observer.dart';
// import 'theme/social_ecommerce_theme.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Social E-commerce',
//       theme: SocialECommerceTheme.lightTheme,
//       darkTheme: SocialECommerceTheme.darkTheme,
//       themeMode: ThemeMode.system,
//       routerConfig: AppRouter.router,
      
//       navigatorObservers: [AppRouteObserver()],
//     );
//   }
// }

