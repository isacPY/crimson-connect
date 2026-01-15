import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/input.dart';
import '../components/ui/select.dart';
import '../components/ui/card.dart';

// Dummy Data
class _Donor {
  final int id;
  final String name, bloodType, location, lastDonation, status;
  _Donor({required this.id, required this.name, required this.bloodType, required this.location, required this.lastDonation, required this.status});
}

final List<_Donor> DUMMY_DONORS = [
  _Donor(id: 1, name: "Michael Chen", bloodType: "O+", location: "New York, NY", lastDonation: "2 months ago", status: "Available"),
  _Donor(id: 2, name: "Sarah Johnson", bloodType: "A-", location: "Brooklyn, NY", lastDonation: "1 month ago", status: "Available"),
  _Donor(id: 3, name: "David Kim", bloodType: "B+", location: "Queens, NY", lastDonation: "3 weeks ago", status: "Unavailable"),
  _Donor(id: 4, name: "Emily Davis", bloodType: "AB+", location: "Manhattan, NY", lastDonation: "4 months ago", status: "Available"),
  _Donor(id: 5, name: "James Wilson", bloodType: "O-", location: "Jersey City, NJ", lastDonation: "1 week ago", status: "Available"),
  _Donor(id: 6, name: "Linda Martinez", bloodType: "A+", location: "New York, NY", lastDonation: "5 months ago", status: "Unavailable"),
  _Donor(id: 7, name: "Robert Taylor", bloodType: "B-", location: "Bronx, NY", lastDonation: "2 months ago", status: "Available"),
  _Donor(id: 8, name: "Patricia White", bloodType: "AB-", location: "Staten Island, NY", lastDonation: "6 months ago", status: "Available"),
];

class FindDonorsPage extends StatefulWidget {
  const FindDonorsPage({super.key});

  @override
  State<FindDonorsPage> createState() => _FindDonorsPageState();
}

class _FindDonorsPageState extends State<FindDonorsPage> {
  String searchTerm = "";
  String bloodTypeFilter = "All Types";

  List<_Donor> get filteredDonors {
    return DUMMY_DONORS.where((donor) {
      final matchesSearch = donor.location.toLowerCase().contains(searchTerm.toLowerCase()) ||
          donor.name.toLowerCase().contains(searchTerm.toLowerCase());
      final matchesBlood = bloodTypeFilter == "All Types" || donor.bloodType == bloodTypeFilter;
      return matchesSearch && matchesBlood;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16), // py-24 approx
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280), // container mx-auto matches
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Text("Find Blood Donors", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Search for available donors near you.", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                    const SizedBox(height: 32),

                    // Filters
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.colorScheme.outline),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
                      ),
                      child: Flex(
                        direction: MediaQuery.of(context).size.width >= 768 ? Axis.horizontal : Axis.vertical,
                        gap: 16,
                        children: [
                          Expanded(
                            child: MissionInput(
                               placeholder: "Search by location or name...",
                               onChanged: (v) => setState(() => searchTerm = v),
                               // Icon would need input decoration update or stacking
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width >= 768 ? 200 : double.infinity,
                            child: MissionSelect<String>(
                              value: bloodTypeFilter,
                              items: ["All Types", "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => setState(() => bloodTypeFilter = v!),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width >= 768 ? 140 : double.infinity,
                            child: MissionButton(
                              label: "More Filters",
                              variant: ButtonVariant.outline,
                              icon: const Icon(LucideIcons.filter, size: 16),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Grid
                    if (filteredDonors.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(child: Text("No donors found matching your criteria.", style: TextStyle(color: Colors.grey))),
                      )
                    else
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int cols = constraints.maxWidth >= 1024 ? 4 : (constraints.maxWidth >= 768 ? 2 : 1);
                          double spacing = 24.0;
                          double width = (constraints.maxWidth - (cols - 1) * spacing) / cols;

                          return Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            children: filteredDonors.map((donor) => _DonorResultCard(width: width, donor: donor)).toList(),
                          );
                        },
                      )
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

class _DonorResultCard extends StatelessWidget {
  final double width;
  final _Donor donor;

  const _DonorResultCard({required this.width, required this.donor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNegative = donor.bloodType.contains("-");

    return MissionCard(
      // We wrap MissionCard or just use Card directly if structure differs slightly
      // Reusing MissionCard composition
      child: Container(
        width: width,
        // Card styling handled by parent Card widget in MissionCard but we need width constraint
        child: Column(
          children: [
             MissionCardHeader(
               title: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(donor.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                   Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isNegative ? theme.colorScheme.secondary : theme.colorScheme.primary, // using primary as 'default' variant
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(donor.bloodType, style: TextStyle(
                        color: isNegative ? theme.colorScheme.onSecondary : theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold, fontSize: 14)),
                   )
                 ],
               ).padded(), // We'll just pass widget
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Row(children: [
                      const Icon(LucideIcons.mapPin, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(donor.location, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Text("Last Donation: ", style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(donor.lastDonation, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ]),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: donor.status == "Available" ? Colors.green.shade100 : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(donor.status, style: TextStyle(
                        color: donor.status == "Available" ? Colors.green.shade800 : Colors.red.shade800,
                        fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 24),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
               child: MissionButton(
                 label: "Contact Donor",
                 variant: ButtonVariant.outline,
                 fullWidth: true,
                 icon: const Icon(LucideIcons.phone, size: 16),
                 onPressed: () => context.go('/contact-donor/${donor.id}'),
               ),
             )
          ],
        ),
      ),
    );
  }
}

extension on Widget {
  Widget padded() => this; // Dummy extension if needed, but we passed direct widget
}
