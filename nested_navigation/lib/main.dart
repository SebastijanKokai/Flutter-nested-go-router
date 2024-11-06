import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _profileScreenNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _transactionNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _settingsNavigatorKey =
    GlobalKey<NavigatorState>();

/// The route configuration.
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
        navigatorKey: _mainNavigatorKey,
        builder: (context, state, child) {
          return MainNavigationScreen(child);
        },
        routes: [
          ShellRoute(
              navigatorKey: _transactionNavigatorKey,
              builder: (context, state, child) =>
                  CenterScreen(const TransactionsScreen(), child),
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SizedBox.shrink();
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'details',
                      name: 'details',
                      builder: (BuildContext context, GoRouterState state) {
                        return const DetailsScreen();
                      },
                    ),
                    GoRoute(
                        path: 'comment',
                        builder: (BuildContext context, GoRouterState state) {
                          return const CommentScreen();
                        })
                  ],
                ),
              ]),
          ShellRoute(
              navigatorKey: _profileScreenNavigatorKey,
              builder: (context, state, child) =>
                  CenterScreen(const ProfileScreen(), child),
              routes: [
                GoRoute(
                    path: '/profile',
                    builder: (context, state) {
                      return const SizedBox.shrink();
                    }),
              ]),
          ShellRoute(
              navigatorKey: _settingsNavigatorKey,
              builder: (context, state, child) =>
                  CenterScreen(const SettingsScreen(), child),
              routes: [
                GoRoute(
                    path: '/settings',
                    builder: (context, state) {
                      return const SizedBox.shrink();
                    }),
              ]),
        ])
  ],
);

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen(this.child, {super.key});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 56,
            color: Colors.blue,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        ListTile(
                            title: const Text('Home'),
                            onTap: () {
                              context.go('/home');
                            }),
                        ListTile(
                            title: const Text('Profile'),
                            onTap: () {
                              context.go('/profile');
                            }),
                        ListTile(
                            title: const Text('Settings'),
                            onTap: () {
                              context.go('/settings');
                            }),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: child,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CenterScreen extends StatelessWidget {
  const CenterScreen(this.centerChild, this.rightChild, {super.key});

  final Widget centerChild;
  final Widget? rightChild;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: centerChild,
        ),
        Expanded(
          flex: 1,
          child: SidePanelWrapper(rightChild),
        )
      ],
    );
  }
}

class SidePanelWrapper extends StatelessWidget {
  const SidePanelWrapper(this.child, {super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: child,
      ),
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.go('/home/details'),
        child: const Text('Go to the Details screen'),
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Colors.yellow);
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Details Screen')),
    //   body: Align(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ElevatedButton(
    //           onPressed: () => context.go('/'),
    //           child: const Text('Go back to the Home screen'),
    //         ),
    //         const SizedBox(
    //           height: 16,
    //         ),
    //         ElevatedButton(
    //           onPressed: () => context.go('/comment'),
    //           child: const Text('Go to comment screen'),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class CommentScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comment Screen')),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to the Home screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hello I am a settings screen.'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Hello, I am a profile screen"),
    );
  }
}
