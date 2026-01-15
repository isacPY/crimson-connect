import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/card.dart';

class DonorProfilePage extends StatelessWidget {
  final String id;
  const DonorProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock Data
    final donor = {
      "name": "Michael Chen",
      "location": "New York, NY",
      "bloodGroup": "O+",
      "status": "Available",
      "donations": 12,
      "verified": true,
      "bio": "Regular donor for the past 5 years. Committed to helping my community.",
      "badges": ["Hero Donor", "Rapid Responder"]
    };

    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 672), // max-w-2xl
                  child: MissionCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        // Cover
                        Container(height: 128, color: theme.colorScheme.primary.withOpacity(0.1)),
                        // Avatar
                        Transform.translate(
                          offset: const Offset(0, -64),
                          child: Container(
                            width: 128, height: 128,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                              image: DecorationImage(image: NetworkImage("https://api.dicebear.com/7.x/avataaars/png?seed=$id")),
                            ),
                          ),
                        ),
                        // Info
                        Transform.translate(
                           offset: const Offset(0, -40),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(donor['name'] as String, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                   if (donor['verified'] as bool) ...[
                                     const SizedBox(width: 8),
                                     const Icon(LucideIcons.shieldCheck, size: 20, color: Colors.blue),
                                   ]
                                 ],
                               ),
                               const SizedBox(height: 8),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                                   const SizedBox(width: 4),
                                   Text(donor['location'] as String, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                                 ],
                               ),
                               const SizedBox(height: 24),
                               
                               // Badges
                               Wrap(
                                 spacing: 8,
                                 children: (donor['badges'] as List<String>).map((b) => Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                   decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.amber.shade200)),
                                   child: Text(b, style: TextStyle(color: Colors.amber.shade900, fontSize: 12, fontWeight: FontWeight.w500)),
                                 )).toList(),
                               ),
                               
                               const SizedBox(height: 24),
                               
                               // Stats Grid
                               Container(
                                 decoration: BoxDecoration(
                                   border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade200)),
                                   color: Colors.grey.shade50,
                                 ),
                                 padding: const EdgeInsets.symmetric(vertical: 24),
                                 child: Row(
                                   children: [
                                     Expanded(child: _Stat(label: "Blood Type", value: donor['bloodGroup'] as String, color: theme.colorScheme.primary)),
                                     Container(width: 1, height: 40, color: Colors.grey.shade300),
                                     Expanded(child: _Stat(label: "Lives Saved", value: "${donor['donations']}", color: theme.colorScheme.primary)),
                                     Container(width: 1, height: 40, color: Colors.grey.shade300),
                                     Expanded(child: Column(
                                       children: [
                                         Container(
                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                           decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                                           child: Text(donor['status'] as String, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold, fontSize: 12)),
                                         ),
                                         const SizedBox(height: 4),
                                         const Text("Status", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                       ],
                                     )),
                                   ],
                                 ),
                               ),
                               
                               const SizedBox(height: 24),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 32),
                                 child: Text('"${donor['bio']}"', textAlign: TextAlign.center, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                               ),
                               
                               const SizedBox(height: 32),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 32),
                                 child: Column(
                                   children: [
                                     MissionButton(
                                       label: "Contact Donor",
                                       fullWidth: true,
                                       size: ButtonSize.lg,
                                       icon: const Icon(LucideIcons.messageCircle),
                                       onPressed: () => context.go('/contact-donor/$id'),
                                     ),
                                     const SizedBox(height: 12),
                                     const Text("Protected by BloodLink Safety Guarantee.", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                   ],
                                 ),
                               )
                             ],
                           ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
