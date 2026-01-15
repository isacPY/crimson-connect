import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../ui/button.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: [theme.colorScheme.primary, const Color(0xFFE11D48)]), // primary to primary-glow approx
           boxShadow: [
             BoxShadow(color: theme.colorScheme.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
           ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Blurs
            Positioned(top: -50, left: -50, child: Container(width: 200, height: 200, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)))),
            Positioned(bottom: -50, right: -50, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.05)))),

            // Floating Hearts
            Positioned(top: 40, right: 40, child: Icon(LucideIcons.heart, size: 60, color: Colors.white.withOpacity(0.2))
              .animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: -20, duration: 4.seconds)),
            Positioned(bottom: 40, left: 40, child: Icon(LucideIcons.heart, size: 80, color: Colors.white.withOpacity(0.1))
              .animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: -20, duration: 5.seconds, delay: 1.seconds)),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(999)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(LucideIcons.sparkles, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text("Join 120,000+ donors worldwide", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Ready to Make a Difference?",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Your single donation can save up to 3 lives. Join our community today and become a hero in someone's story.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.5),
                  ),
                  const SizedBox(height: 48),

                  // Buttons
                  Flex(
                    direction: MediaQuery.of(context).size.width >= 600 ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    gap: 16,
                    children: [
                       SizedBox(
                         width: MediaQuery.of(context).size.width >= 600 ? 200 : double.infinity,
                         height: 56,
                         child: ElevatedButton(
                           onPressed: () {},
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.white,
                             foregroundColor: theme.colorScheme.primary,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                               Text("Register as Donor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                               SizedBox(width: 8),
                               Icon(LucideIcons.arrowRight, size: 20),
                             ],
                           ),
                         ),
                       ),
                       SizedBox(
                         width: MediaQuery.of(context).size.width >= 600 ? 200 : double.infinity,
                         height: 56,
                         child: OutlinedButton(
                           onPressed: () {},
                           style: OutlinedButton.styleFrom(
                             side: BorderSide(color: Colors.white.withOpacity(0.5), width: 2),
                             foregroundColor: Colors.white,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                           ),
                           child: const Text("Request Blood", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                         ),
                       ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text("🔒 Your data is secure and HIPAA compliant", style: TextStyle(color: Colors.white60, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
