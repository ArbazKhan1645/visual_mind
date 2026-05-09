import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/features/capture/capture_screen.dart';
import 'package:visualmind/features/home/home_screen.dart';
import 'package:visualmind/features/main_shell/main_shell.dart';
import 'package:visualmind/features/memory/memory_detail_screen.dart';
import 'package:visualmind/features/search/search_screen.dart';
import 'package:visualmind/features/settings/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: false,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: AppRoutes.home,
            pageBuilder: (ctx, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/search',
            name: AppRoutes.search,
            pageBuilder: (ctx, state) =>
                const NoTransitionPage(child: SearchScreen()),
          ),
          GoRoute(
            path: '/settings',
            name: AppRoutes.settings,
            pageBuilder: (ctx, state) =>
                const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/capture',
        name: AppRoutes.capture,
        pageBuilder: (ctx, state) =>
            MaterialPage(fullscreenDialog: true, child: const CaptureScreen()),
      ),
      GoRoute(
        path: '/memory/:id',
        name: AppRoutes.memoryDetail,
        pageBuilder: (ctx, state) {
          final memory = state.extra as MemoryEntity?;
          final id = state.pathParameters['id']!;
          return MaterialPage(
            child: MemoryDetailScreen(memoryId: id, memory: memory),
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
});

abstract class AppRoutes {
  static const home = 'home';
  static const search = 'search';
  static const capture = 'capture';
  static const memoryDetail = 'memory-detail';
  static const settings = 'settings';
}
