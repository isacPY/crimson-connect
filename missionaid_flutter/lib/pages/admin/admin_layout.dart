import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminLayout extends StatelessWidget {
  final Widget child; // The 'Outlet' logic

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            const _AdminSidebar(width: 250),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Admin Panel"),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(LucideIcons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
        drawer: const _AdminSidebar(width: 250), // Drawer on mobile
        body: child,
      );
    }
  }
}

class _AdminSidebar extends StatelessWidget {
  final double width;
  const _AdminSidebar({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outline)),
      ),
      child: Column(
        children: [
          Container(
            height: 64,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text("BloodLink Admin", style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            )),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _AdminNavItem(label: "Dashboard", icon: LucideIcons.layoutDashboard, route: "/admin"),
                _AdminNavItem(label: "User Management", icon: LucideIcons.users, route: "/admin/users"),
                _AdminNavItem(label: "Approvals", icon: LucideIcons.userCheck, route: "/admin/approvals"),
                _AdminNavItem(label: "Donations", icon: LucideIcons.heart, route: "/admin/donations"),
                _AdminNavItem(label: "Settings", icon: LucideIcons.settings, route: "/admin/settings"),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.logOut, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () => context.go('/'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AdminNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;

  const _AdminNavItem({required this.label, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    // We need to check if active. In GoRouter we can get location string.
    final String location = GoRouterState.of(context).uri.toString();
    // Logic: exact match or starts with if not root admin
    final bool isActive = location == route || (route != '/admin' && location.startsWith(route));

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: isActive ? colorScheme.secondary : null,
        leading: Icon(
          icon,
          color: isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.6),
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.6),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () => context.go(route),
      ),
    );
  }
}
