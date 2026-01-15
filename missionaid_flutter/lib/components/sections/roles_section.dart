import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../ui/button.dart';

class RolesSection extends StatelessWidget {
  const RolesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16), // py-20
      child: Column(
        children: [
          // Header
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEECEE), // accent
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  "Choose Your Role",
                  style: TextStyle(color: Color(0xFF8B1A28), fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  children: [
                    const TextSpan(text: "Join Our "),
                    TextSpan(
                      text: "Community",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Whether you're giving or receiving, we make the process simple, secure, and meaningful.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ).animate().fade().moveY(begin: 20, end: 0, duration: 600.ms),

          const SizedBox(height: 64),

          // Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 768;
              final isBg = constraints.maxWidth >= 1024;
              
              int crossAxisCount = isBg ? 3 : (isDesktop ? 2 : 1);
              double width = (constraints.maxWidth - (crossAxisCount - 1) * 32) / crossAxisCount;

              return Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  _RoleCard(
                    width: width,
                    title: "Donor",
                    description: "Register as a blood donor and receive notifications when someone nearby needs your blood type.",
                    features: const ["Donation tracking", "Location-based alerts", "Health reminders", "Reward badges"],
                    icon: LucideIcons.heart,
                    gradientColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.8)],
                  ),
                  _RoleCard(
                    width: width,
                    title: "Patient / Caretaker",
                    description: "Post blood requirements for yourself or loved ones. Get matched with compatible donors in your area.",
                    features: const ["Emergency requests", "Donor matching", "Hospital integration", "Real-time updates"],
                    icon: LucideIcons.users,
                    gradientColors: [const Color(0xFF8B1A28), Theme.of(context).colorScheme.primary], // accent-foreground to primary
                  ),
                  _RoleCard(
                    width: width,
                    title: "Receiver",
                    description: "Healthcare facilities and blood banks can register to receive blood donations. Manage inventory efficiently.",
                    features: const ["Inventory management", "Donor coordination", "Scheduled pickups", "Analytics dashboard"],
                    icon: LucideIcons.heartHandshake,
                    gradientColors: [Theme.of(context).colorScheme.primary.withOpacity(0.8), Theme.of(context).colorScheme.primary],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final double width;
  final String title;
  final String description;
  final List<String> features;
  final IconData icon;
  final List<Color> gradientColors;

  const _RoleCard({
    required this.width,
    required this.title,
    required this.description,
    required this.features,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradientColors),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 24),
          
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          Text(description, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
          const SizedBox(height: 24),
          
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colorScheme.primary)),
                const SizedBox(width: 8),
                Text(f, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
              ],
            ),
          )),
          
          const SizedBox(height: 32),
          
          MissionButton(
            label: "Get Started",
            variant: ButtonVariant.outline,
            fullWidth: true,
            icon: const Icon(LucideIcons.arrowRight),
            onPressed: () {},
          )
        ],
      ),
    ); // We can animate this individually in the parent loop or here
  }
}
