import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../ui/button.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64); // h-16

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 768; // md breakpoint

    return AppBar(
      backgroundColor: theme.colorScheme.background.withOpacity(0.8),
      surfaceTintColor: Colors.transparent, // Disable Material 3 tint
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: theme.colorScheme.outline.withOpacity(0.2), height: 1),
      ),
      flexibleSpace: ClipRect(
        child: Container(
          // In web/macos this creates blur, on mobile it's transparent
          // Using a basic approximation for now as BackdropFilter can be expensive
        ),
      ),
      titleSpacing: 0,
      automaticallyImplyLeading: false, // We handle the menu button manually
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // Logo
            InkWell(
              onTap: () => context.go('/'),
              child: Row(
                children: [
                  // Placeholder for Image
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(LucideIcons.droplet, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "Blood", style: TextStyle(color: theme.colorScheme.onSurface)),
                        TextSpan(text: "Link", style: TextStyle(color: theme.colorScheme.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),

            // Desktop Nav
            if (isDesktop) ...[
              _NavLink(label: "Find Donors", route: "/donors"),
              _NavLink(label: "Donate Blood", route: "/donate"),
              _NavLink(label: "Request Blood", route: "/request-blood"),
              _NavLink(label: "Blood Banks", route: "/banks"),
              const SizedBox(width: 24),
              // Theme Toggle Placeholder
              IconButton(onPressed: () {}, icon: const Icon(LucideIcons.sun)), 
              const SizedBox(width: 12),
              MissionButton(
                label: "Sign In",
                variant: ButtonVariant.ghost,
                size: ButtonSize.sm,
                onPressed: () => context.go('/auth/login'),
              ),
              const SizedBox(width: 8),
              MissionButton(
                label: "Get Started",
                variant: ButtonVariant.defaultVariant,
                size: ButtonSize.sm,
                onPressed: () => context.go('/get-started'),
              ),
            ] else ...[
              // Mobile Menu Button
              IconButton(onPressed: () {}, icon: const Icon(LucideIcons.sun)),
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(LucideIcons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  
  const _NavLink({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: () => context.go(route),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
