import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_theme.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      color: const Color(0xFFFBFBFB), // gradient-subtle approximation
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
          Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFFEECEE), borderRadius: BorderRadius.circular(999)),
                    child: const Text("Our Impact", style: TextStyle(color: Color(0xFF8B1A28), fontWeight: FontWeight.w500, fontSize: 13)),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                      children: [
                        const TextSpan(text: "Making a "),
                        TextSpan(text: "Difference", style: TextStyle(color: theme.colorScheme.primary)),
                      ],
                    ),
                  ),
                   const SizedBox(height: 16),
                  const Text(
                    "Every number represents a life touched, a family helped, and hope renewed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
          ),
          const SizedBox(height: 64),
          
          LayoutBuilder(
            builder: (context, constraints) {
               // grid-cols-2 lg:grid-cols-4
               int cols = constraints.maxWidth >= 1024 ? 4 : 2;
               double spacing = 24.0;
               double width = (constraints.maxWidth - (cols - 1) * spacing) / cols;
               // Fix for mobile where 2 cols might be too tight, simpler 1 col on very small
               if (constraints.maxWidth < 600) { cols = 2; width = (constraints.maxWidth - spacing) / 2; }

               return Wrap(
                 spacing: spacing,
                 runSpacing: spacing,
                 alignment: WrapAlignment.center,
                 children: [
                   _StatCard(width: width, icon: LucideIcons.heart, value: "50K+", label: "Lives Saved", desc: "Through our network"),
                   _StatCard(width: width, icon: LucideIcons.users, value: "120K+", label: "Active Donors", desc: "Ready to help anytime"),
                   _StatCard(width: width, icon: LucideIcons.mapPin, value: "500+", label: "Cities Covered", desc: "Across the country"),
                   _StatCard(width: width, icon: LucideIcons.clock, value: "< 2hrs", label: "Average Response", desc: "For emergency requests"),
                 ],
               );
            },
          )
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String value;
  final String label;
  final String desc;

  const _StatCard({required this.width, required this.icon, required this.value, required this.label, required this.desc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
        // shadow-soft
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFFEECEE), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(height: 16),
          Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6))),
        ],
      ),
    );
  }
}
