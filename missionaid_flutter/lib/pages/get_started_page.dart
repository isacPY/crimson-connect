import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/card.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
               child: Column(
                 children: [
                   const Text("Welcome to BloodLink", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 16),
                   const Text("Thank you for joining our community. How would you like to proceed today?", style: TextStyle(fontSize: 18, color: Colors.grey)),
                   const SizedBox(height: 48),

                   LayoutBuilder(
                     builder: (context, constraints) {
                       int cols = constraints.maxWidth >= 768 ? 3 : 1;
                       double width = (constraints.maxWidth - (cols-1)*32) / cols;
                       if (width > 350) width = 350; // Max width cap
                       
                       return Wrap(
                         spacing: 32, runSpacing: 32,
                         alignment: WrapAlignment.center,
                         children: [
                           _ActionCard(
                             width: width,
                             title: "Donate Blood",
                             desc: "Register as a donor and save lives.",
                             icon: LucideIcons.heart,
                             color: Colors.red,
                             btnLabel: "Register as Donor",
                             onTap: () => context.go('/donate'),
                           ),
                           _ActionCard(
                             width: width,
                             title: "Request Blood", // Mapped to donate page tab for now or specific route if we split
                             desc: "Find donors for yourself or a patient.",
                             icon: LucideIcons.users,
                             color: Colors.blue,
                             btnLabel: "Request Blood",
                             btnVariant: ButtonVariant.outline,
                             onTap: () => context.go('/donate'), // Using donate page which has Tabs
                           ),
                           _ActionCard(
                             width: width,
                             title: "Find Donors",
                             desc: "Browse our database of available donors.",
                             icon: LucideIcons.search,
                             color: Colors.green,
                             btnLabel: "Search Donors",
                             btnVariant: ButtonVariant.ghost,
                             onTap: () => context.go('/donors'),
                           ),
                         ],
                       );
                     },
                   )

                 ],
               ),
             ),
             const Footer(), // Gets pushed down
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final double width;
  final String title, desc, btnLabel;
  final IconData icon;
  final Color color;
  final ButtonVariant btnVariant;
  final VoidCallback onTap;

  const _ActionCard({required this.width, required this.title, required this.desc, required this.icon, required this.color, required this.btnLabel, required this.onTap, this.btnVariant = ButtonVariant.defaultBtn});

  @override
  Widget build(BuildContext context) {
    return MissionCard(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
                MissionButton(label: btnLabel, variant: btnVariant, fullWidth: true, onPressed: onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
