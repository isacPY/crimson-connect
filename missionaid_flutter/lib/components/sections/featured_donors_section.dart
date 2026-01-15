import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../ui/button.dart';
import '../ui/card.dart';

class FeaturedDonorsSection extends StatelessWidget {
  const FeaturedDonorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
           // Header Row
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Recent Hero Donors", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     const Text("Meet some of the selfless individuals who have recently joined our community to save lives.", style: TextStyle(fontSize: 16, color: Colors.black54)),
                   ],
                 ),
               ),
               if (MediaQuery.of(context).size.width >= 768)
                 MissionButton(
                   label: "View All Donors",
                   variant: ButtonVariant.outline,
                   onPressed: () => context.go('/donors'),
                   icon: const Icon(LucideIcons.arrowRight),
                 ),
             ],
           ),
           
           const SizedBox(height: 32),

           // Grid
           LayoutBuilder(
             builder: (context, constraints) {
               int cols = constraints.maxWidth >= 1024 ? 4 : (constraints.maxWidth >= 768 ? 2 : 1);
               double spacing = 24.0;
               double width = (constraints.maxWidth - (cols - 1) * spacing) / cols;

               final donors = [
                 _Donor(name: "Michael Chen", type: "O+", loc: "New York, NY", time: "2 months ago", status: "Available"),
                 _Donor(name: "Sarah Johnson", type: "A-", loc: "Brooklyn, NY", time: "1 month ago", status: "Available"),
                 _Donor(name: "Emily Davis", type: "AB+", loc: "Manhattan, NY", time: "4 months ago", status: "Available"),
                 _Donor(name: "James Wilson", type: "O-", loc: "Jersey City, NJ", time: "1 week ago", status: "Available"),
               ];

               return Wrap(
                 spacing: spacing,
                 runSpacing: spacing,
                 children: donors.map((d) => _DonorCard(width: width, donor: d)).toList(),
               );
             },
           )
        ],
      ),
    );
  }
}

class _Donor {
  final String name, type, loc, time, status;
  _Donor({required this.name, required this.type, required this.loc, required this.time, required this.status});
}

class _DonorCard extends StatelessWidget {
  final double width;
  final _Donor donor;

  const _DonorCard({required this.width, required this.donor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNegative = donor.type.contains("-");

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
           Padding(
             padding: const EdgeInsets.all(16),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(donor.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                         const SizedBox(height: 4),
                         Row(children: [
                           const Icon(LucideIcons.mapPin, size: 12, color: Colors.grey),
                           const SizedBox(width: 4),
                           Text(donor.loc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                         ]),
                       ],
                     ),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                       decoration: BoxDecoration(
                         color: isNegative ? theme.colorScheme.secondary : theme.colorScheme.primary,
                         borderRadius: BorderRadius.circular(999),
                       ),
                       child: Text(
                         donor.type,
                         style: TextStyle(
                           color: isNegative ? theme.colorScheme.onSecondary : theme.colorScheme.onPrimary,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 12),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Text("Last Donation: ${donor.time}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                   ],
                 ),
                 const SizedBox(height: 8),
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                   decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                   child: Text(donor.status, style: TextStyle(color: Colors.green.shade800, fontSize: 10, fontWeight: FontWeight.w600)),
                 ),
               ],
             ),
           ),
           const Divider(height: 1),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: MissionButton(
               label: "View Profile",
               variant: ButtonVariant.ghost,
               fullWidth: true,
               size: ButtonSize.sm,
               onPressed: () {},
             ),
           ),
        ],
      ),
    );
  }
}
