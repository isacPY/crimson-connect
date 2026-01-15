import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../ui/button.dart';
import '../../core/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 768;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Gradient (gradient-subtle)
        Container(
          height: isDesktop ? size.height : null,
          minHeight: size.height, // min-h-screen
          decoration: BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
               colors: [
                 const Color(0xFFFCFCFC), // 0 0% 99%
                 const Color(0xFFF5F5F5), // 0 15% 96%
               ],
             ),
          ),
        ),

        // Floating Decorations (Absolute Positioned)
        // Top Left primary/10
        Positioned(
          top: size.height * 0.25,
          left: 40,
          child: Container(
            width: 80, height: 80,
            decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colorScheme.primary.withOpacity(0.1)),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .moveY(duration: 6.seconds, begin: 0, end: -20, curve: Curves.easeInOut),
        ),
        
        // Top Right primary/5
        const Positioned(
          top: 150,
          right: 80,
          child: _FloatingCircle(size: 128, opacity: 0.05, delay: 2),
        ),
        
        // Bottom Left Accent
         Positioned(
          bottom: size.height * 0.25,
          left: size.width * 0.25,
          child: Container(
            width: 64, height: 64,
            decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFEECEE)), // accent
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .moveY(duration: 6.seconds, begin: 0, end: -20, curve: Curves.easeInOut),
        ),

        // Droplets SVG Decoration
        Positioned(
          top: 160,
          right: size.width * 0.15,
          child: Icon(LucideIcons.droplets, size: 160, color: theme.colorScheme.primary.withOpacity(0.1))
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(duration: 6.seconds, begin: 0, end: -20, curve: Curves.easeInOut),
        ),

        // Main Content
        Padding(
          padding: const EdgeInsets.only(top: 80), // pt-20
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80), // Spacer for header overlap
                
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEECEE), // accent
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.heart, size: 16, color: theme.colorScheme.primary), // accent-foreground
                      const SizedBox(width: 8),
                      Text(
                        "Saving lives, one donation at a time",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: const Color(0xFF8B1A28), // accent-foreground
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).animate().fade().moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOut),

                const SizedBox(height: 32),

                // Headline
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: theme.textTheme.displaySmall?.copyWith( // text-4xl -> displaySmall/Medium
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 64 : 36, // md:text-5xl lg:text-6xl
                      height: 1.1,
                      color: theme.colorScheme.onSurface,
                    ),
                    children: [
                      const TextSpan(text: "Your Blood Can Be\n"),
                      WidgetSpan(
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [AppTheme.primary, AppTheme.primaryGlow], // gradient-hero
                          ).createShader(bounds),
                          child: Text(
                            "Someone's Lifeline",
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isDesktop ? 64 : 36,
                              height: 1.1,
                              color: Colors.white, // Masked
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fade().moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOut),

                const SizedBox(height: 24),

                // Subheadline
                 Text(
                   "Connect with donors and patients in your area. Join our community of \nlife-savers and make a difference today.",
                   textAlign: TextAlign.center,
                   style: theme.textTheme.titleMedium?.copyWith(
                     fontSize: isDesktop ? 20 : 18,
                     color: theme.colorScheme.onSurface.withOpacity(0.6), // muted-foreground
                   ),
                 ).animate().fade(delay: 200.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOut),

                 const SizedBox(height: 40),

                 // CTA Buttons
                 Flex(
                   direction: isDesktop ? Axis.horizontal : Axis.vertical,
                   mainAxisAlignment: MainAxisAlignment.center,
                   gap: 16,
                   children: [
                     SizedBox(
                       width: isDesktop ? 200 : double.infinity,
                       height: 56, // size=xl
                       child: ElevatedButton(
                         onPressed: () => context.go('/donate'),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: theme.colorScheme.primary,
                           foregroundColor: Colors.white,
                           elevation: 8, // shadow-card roughly
                           shadowColor: theme.colorScheme.primary.withOpacity(0.5),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: const [
                             Text("Donate Blood", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                             SizedBox(width: 8),
                             Icon(LucideIcons.arrowRight, size: 20),
                           ],
                         ),
                       ),
                     ),
                     SizedBox(
                       width: isDesktop ? 200 : double.infinity,
                       height: 56,
                       child: OutlinedButton(
                         onPressed: () => context.go('/donors'),
                         style: OutlinedButton.styleFrom(
                           side: BorderSide(color: theme.colorScheme.primary, width: 2),
                           foregroundColor: theme.colorScheme.primary,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         ),
                         child: const Text("Find a Donor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                       ),
                     ),
                   ],
                 ).animate().fade(delay: 200.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOut),

                 const SizedBox(height: 64),
                 const Divider(),
                 const SizedBox(height: 32),

                 // Trust Indicators
                 Text("Trusted by healthcare organizations worldwide", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                 const SizedBox(height: 24),
                 Wrap(
                   spacing: isDesktop ? 48 : 24,
                   runSpacing: 16,
                   alignment: WrapAlignment.center,
                   children: const [
                     _TrustBadge(label: "Red Cross"),
                     _TrustBadge(label: "WHO Certified"),
                     _TrustBadge(label: "500+ Hospitals"),
                     _TrustBadge(label: "HIPAA Compliant"),
                   ],
                 ).animate().fade(delay: 200.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOut),

                 const SizedBox(height: 120), // Bottom padding
              ],
            ),
          ),
        ),

        // Bottom Wave (SVG Path)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomPaint(
            size: Size(size.width, 60), // reduced height
            painter: WavePainter(color: theme.scaffoldBackgroundColor),
          ),
        ),
      ],
    );
  }
}

class _FloatingCircle extends StatelessWidget {
  final double size;
  final double opacity;
  final int delay;

  const _FloatingCircle({required this.size, required this.opacity, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary.withOpacity(opacity)),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .moveY(duration: 6.seconds, delay: Duration(seconds: delay), begin: 0, end: -20, curve: Curves.easeInOut);
  }
}

class _TrustBadge extends StatelessWidget {
  final String label;
  const _TrustBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: 0.6,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: theme.colorScheme.secondary, borderRadius: BorderRadius.circular(4)),
            child: Icon(LucideIcons.heart, size: 14, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }
}

// Custom Painter for the Wave SVG
class WavePainter extends CustomPainter {
  final Color color;
  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color..style = PaintingStyle.fill;
    var path = Path();
    // Simplified wave approximation of the SVG
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(size.width * 0.25, size.height - 30, size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(size.width * 0.75, size.height - 0, size.width, size.height - 20);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
