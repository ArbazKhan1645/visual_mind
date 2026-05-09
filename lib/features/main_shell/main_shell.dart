import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:visualmind/app_theme.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: child,
      bottomNavigationBar: _BottomNav(currentPath: location),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final String currentPath;
  const _BottomNav({required this.currentPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg1,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.grid_view_rounded,
                label: 'Memories',
                isActive: currentPath == '/home',
                onTap: () => context.go('/home'),
              ),
              _NavItem(
                icon: Icons.search_rounded,
                label: 'Search',
                isActive: currentPath == '/search',
                onTap: () => context.go('/search'),
              ),
              _CaptureButton(onTap: () => context.pushNamed('capture')),
              _NavItem(
                icon: Icons.auto_awesome_rounded,
                label: 'Insights',
                isActive: false,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.settings_rounded,
                label: 'Settings',
                isActive: currentPath == '/settings',
                onTap: () => context.go('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accentLight : AppColors.textTertiary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CaptureButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.accent, AppColors.accentLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
