import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_theme.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
           // Header
           Column(
             children: [
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                 decoration: BoxDecoration(color: const Color(0xFFFEECEE), borderRadius: BorderRadius.circular(999)),
                 child: const Text("How It Works", style: TextStyle(color: Color(0xFF8B1A28), fontWeight: FontWeight.w500, fontSize: 13)),
               ),
               const SizedBox(height: 16),
               RichText(
                 textAlign: TextAlign.center,
                 text: TextSpan(
                   style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                   children: [
                     const TextSpan(text: "Simple Steps to "),
                     TextSpan(text: "Save Lives", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                   ],
                 ),
               ),
               const SizedBox(height: 16),
               const Text(
                 "Our streamlined process makes blood donation easy and accessible for everyone.",
                 textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 18, color: Colors.black54),
               ),
             ],
           ),
           const SizedBox(height: 64),

           // Steps
           Stack(
             children: [
               // Connection Line (Desktop Only)
               if (MediaQuery.of(context).size.width >= 1024)
                 Positioned(
                   top: 40, 
                   left: MediaQuery.of(context).size.width * 0.125,
                   right: MediaQuery.of(context).size.width * 0.125,
                   child: Container(
                     height: 2,
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [
                           Theme.of(context).colorScheme.primary.withOpacity(0.2),
                           Theme.of(context).colorScheme.primary,
                           Theme.of(context).colorScheme.primary.withOpacity(0.2),
                         ],
                       ),
                     ),
                   ),
                 ),

               LayoutBuilder(
                 builder: (context, constraints) {
                   int cols = constraints.maxWidth >= 1024 ? 4 : (constraints.maxWidth >= 768 ? 2 : 1);
                   double spacing = 32.0;
                   double width = (constraints.maxWidth - (cols - 1) * spacing) / cols;
                   
                   final steps = [
                     _Step(icon: LucideIcons.userPlus, idx: "01", title: "Create Your Profile", desc: "Sign up and complete your profile. It only takes 2 minutes."),
                     _Step(icon: LucideIcons.search, idx: "02", title: "Get Matched", desc: "Our smart system connects donors with patients based on compatibility."),
                     _Step(icon: LucideIcons.calendar, idx: "03", title: "Schedule Donation", desc: "Choose a convenient time and location. We'll send you reminders."),
                     _Step(icon: LucideIcons.heart, idx: "04", title: "Save a Life", desc: "Complete your donation and track the impact you've made."),
                   ];

                   return Wrap(
                     spacing: spacing,
                     runSpacing: spacing,
                     alignment: WrapAlignment.center,
                     children: steps.map((s) => _StepCard(width: width, step: s)).toList(),
                   );
                 },
               ),
             ],
           )
        ],
      ),
    );
  }
}

class _Step {
  final IconData icon;
  final String idx, title, desc;
  _Step({required this.icon, required this.idx, required this.title, required this.desc});
}

class _StepCard extends StatelessWidget {
  final double width;
  final _Step step;
  
  const _StepCard({required this.width, required this.step});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: width,
      child: Column(
        children: [
           // Icon Circle
           SizedBox(
             width: 80, height: 80,
             child: Stack(
               clipBehavior: Clip.none,
               children: [
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.7)]),
                     boxShadow: [BoxShadow(color: theme.colorScheme.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                   ),
                   child: Center(child: Icon(step.icon, color: Colors.white, size: 36)),
                 ),
                 Positioned(
                   top: -8, right: -8,
                   child: Container(
                     width: 32, height: 32,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: Colors.white,
                       border: Border.all(color: theme.colorScheme.primary, width: 2),
                     ),
                     child: Center(
                       child: Text(step.idx, style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                     ),
                   ),
                 ),
               ],
             ),
           ),
           const SizedBox(height: 24),
           Text(step.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
           const SizedBox(height: 12),
           Text(step.desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54, height: 1.5)),
        ],
      ),
    );
  }
}
