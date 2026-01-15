import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/card.dart';
import '../components/ui/input.dart';
import '../components/ui/toast.dart';

class BloodBankDetailsPage extends StatefulWidget {
  final String id;
  const BloodBankDetailsPage({super.key, required this.id});

  @override
  State<BloodBankDetailsPage> createState() => _BloodBankDetailsPageState();
}

class _BloodBankDetailsPageState extends State<BloodBankDetailsPage> {
  String? selectedType;
  bool isRequesting = false;

  // Mock Data
  final bank = {
    "name": "City General Blood Bank",
    "location": "123 Medical Center Dr, New York, NY 10001",
    "contact": "+1 222-333-4444",
    "hours": "8:00 AM - 8:00 PM",
    "status": "Open",
    "type": "Public",
    "stock": {
      "A+": "High", "A-": "Low", "B+": "Medium", "B-": "Critical",
      "O+": "High", "O-": "Medium", "AB+": "Low", "AB-": "Critical"
    }
  };

  void showRequestDialog(BuildContext context, String bloodType) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Request $bloodType Blood"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Share your details directly with ${bank['name']} to request $bloodType units."),
            const SizedBox(height: 16),
            const MissionInput(label: "Patient Information", placeholder: "John Doe (You)", enabled: false),
            const SizedBox(height: 16),
            const MissionInput(label: "Contact Number", placeholder: "+1 234 567 890", enabled: false),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Checkbox(value: true, onChanged: null),
                 const Expanded(child: Text("I consent to sharing my medical need and contact details with this blood bank for immediate processing.", style: TextStyle(fontSize: 12))),
              ],
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              setState(() => isRequesting = true); // Only visual within dialog context if stateful, but here simple mock
              Navigator.pop(ctx);
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                 MissionToast.success(context, title: "Request Sent Successfully", description: "We have notified ${bank['name']} about your need.");
              }
            },
            child: const Text("Send Request"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stock = bank['stock'] as Map<String, String>;

    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => context.go('/banks'),
                      icon: const Icon(LucideIcons.arrowLeft, size: 16),
                      label: const Text("Back to Directory"),
                      style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Layout
                     LayoutBuilder(
                       builder: (context, constraints) {
                         final isDesktop = constraints.maxWidth >= 1024;
                         return Flex(
                           direction: isDesktop ? Axis.horizontal : Axis.vertical,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             // Main Info
                             Expanded(
                               flex: isDesktop ? 2 : 0,
                               child: Column(
                                 children: [
                                   MissionCard(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Container(
                                           height: 192,
                                           color: Colors.grey.shade200,
                                           child: const Center(child: Text("Map Placeholder", style: TextStyle(color: Colors.grey))),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(24),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Row(children: [
                                                     const Icon(LucideIcons.building, color: Colors.red),
                                                     const SizedBox(width: 8),
                                                     Text(bank['name'] as String, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                                   ]),
                                                   Container(
                                                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                     decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                                                     child: Text(bank['type'] as String),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(height: 4),
                                               Row(children: [
                                                 const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                                                 const SizedBox(width: 4),
                                                 Text(bank['location'] as String, style: const TextStyle(color: Colors.grey)),
                                               ]),
                                               const SizedBox(height: 24),
                                               Wrap(
                                                 spacing: 24, runSpacing: 12,
                                                 children: [
                                                   _InfoItem(icon: LucideIcons.phone, label: "Phone", value: bank['contact'] as String),
                                                   _InfoItem(icon: LucideIcons.clock, label: "Hours", value: bank['hours'] as String, sub: "${bank['status']} Now"),
                                                 ],
                                               ),
                                               const SizedBox(height: 24),
                                               const Text("About Us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                               const SizedBox(height: 8),
                                               const Text("Committed to providing safe and reliable blood services to the community. We operate 24/7 for emergency requests.", style: TextStyle(color: Colors.grey)),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 32),
                                   
                                   // Stock
                                   MissionCard(
                                     child: Padding(
                                       padding: const EdgeInsets.all(24),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           const Text("Current Blood Availability", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                           const Text("Click on a blood type to request it instantly.", style: TextStyle(fontSize: 14, color: Colors.grey)),
                                           const SizedBox(height: 24),
                                           Wrap(
                                             spacing: 16, runSpacing: 16,
                                             children: stock.entries.map((e) => InkWell(
                                               onTap: () => showRequestDialog(context, e.key),
                                               child: Container(
                                                 width: 100,
                                                 padding: const EdgeInsets.all(16),
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(8),
                                                   border: Border.all(color: Colors.grey.shade300),
                                                 ),
                                                 child: Column(
                                                   children: [
                                                     Text(e.key, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                                                     const SizedBox(height: 4),
                                                     Container(
                                                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                       decoration: BoxDecoration(
                                                         color: e.value == "Critical" ? Colors.red.shade100 : (e.value == "Low" ? Colors.grey.shade200 : Colors.green.shade100),
                                                         borderRadius: BorderRadius.circular(4),
                                                       ),
                                                       child: Text(e.value, style: TextStyle(
                                                         fontSize: 10, fontWeight: FontWeight.bold,
                                                         color: e.value == "Critical" ? Colors.red : (e.value == "Low" ? Colors.black54 : Colors.green),
                                                       )),
                                                     )
                                                   ],
                                                 ),
                                               ),
                                             )).toList(),
                                           )
                                         ],
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             if (isDesktop) const SizedBox(width: 32),
                             
                             // Sidebar
                             SizedBox(
                               width: isDesktop ? 350 : double.infinity,
                               child: Column(
                                 children: [
                                   if (!isDesktop) const SizedBox(height: 32),
                                   MissionCard(
                                     child: Padding(
                                       padding: const EdgeInsets.all(24),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           const Text("Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                           const SizedBox(height: 16),
                                           MissionButton(label: "Call Now", fullWidth: true, icon: const Icon(LucideIcons.phone, size: 16), onPressed: (){}),
                                           const SizedBox(height: 12),
                                           MissionButton(label: "Get Directions", variant: ButtonVariant.outline, fullWidth: true, icon: const Icon(LucideIcons.navigation, size: 16), onPressed: (){}),
                                           const SizedBox(height: 12),
                                           MissionButton(label: "Share", variant: ButtonVariant.outline, fullWidth: true, icon: const Icon(LucideIcons.share2, size: 16), onPressed: (){}),
                                         ],
                                       ),
                                     ),
                                   ),
                                   const SizedBox(height: 24),
                                   Container(
                                     padding: const EdgeInsets.all(24),
                                     decoration: BoxDecoration(
                                       color: Colors.red.shade50,
                                       border: Border.all(color: Colors.red.shade100),
                                       borderRadius: BorderRadius.circular(12),
                                     ),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Row(children: [
                                           Icon(LucideIcons.alertCircle, color: theme.colorScheme.primary),
                                           const SizedBox(width: 8),
                                           Text("Urgent Needs", style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                                         ]),
                                         const SizedBox(height: 8),
                                         Text("We are currently facing a critical shortage of O- and B- blood types.", style: TextStyle(color: theme.colorScheme.primary)),
                                         const SizedBox(height: 16),
                                         MissionButton(
                                           label: "Donate Now",
                                           variant: ButtonVariant.defaultBtn, // using default
                                           fullWidth: true,
                                           onPressed: () => context.go('/donate'),
                                         )
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                             )
                           ],
                         );
                       },
                     ),
                  ],
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

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final String? sub;
  const _InfoItem({required this.icon, required this.label, required this.value, this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            if (sub != null) Text(sub!, style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
