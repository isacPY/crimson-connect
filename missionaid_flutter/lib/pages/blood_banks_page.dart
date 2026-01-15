import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/input.dart';
import '../components/ui/card.dart';

// Dummy Data
class _Bank {
  final int id;
  final String name, location, contact, status, type;
  _Bank({required this.id, required this.name, required this.location, required this.contact, required this.status, required this.type});
}

final List<_Bank> BLOOD_BANKS = [
  _Bank(id: 1, name: "City General Blood Bank", location: "New York, NY", contact: "+1 222-333-4444", status: "Open", type: "Public"),
  _Bank(id: 2, name: "Red Cross Donation Center", location: "Brooklyn, NY", contact: "+1 222-333-5555", status: "Open", type: "Non-Profit"),
  _Bank(id: 3, name: "Community Life Bank", location: "Queens, NY", contact: "+1 222-333-6666", status: "Closed", type: "Private"),
  _Bank(id: 4, name: "Mercy Health Blood Center", location: "Manhattan, NY", contact: "+1 222-333-7777", status: "Open", type: "Public"),
  _Bank(id: 5, name: "St. Mary's Blood Services", location: "Jersey City, NJ", contact: "+1 222-333-8888", status: "Open", type: "Public"),
];

class BloodBanksPage extends StatefulWidget {
  const BloodBanksPage({super.key});

  @override
  State<BloodBanksPage> createState() => _BloodBanksPageState();
}

class _BloodBanksPageState extends State<BloodBanksPage> {
  String searchTerm = "";

  List<_Bank> get filteredBanks {
    return BLOOD_BANKS.where((bank) {
      return bank.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
             bank.location.toLowerCase().contains(searchTerm.toLowerCase());
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
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Text("Blood Banks Directory", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Find blood banks and donation centers near you.", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                    const SizedBox(height: 32),

                    // Search
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.colorScheme.outline),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
                      ),
                      child: MissionInput(
                          placeholder: "Search by name or location...",
                          onChanged: (v) => setState(() => searchTerm = v),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Grid
                    LayoutBuilder(
                        builder: (context, constraints) {
                          int cols = constraints.maxWidth >= 1024 ? 3 : (constraints.maxWidth >= 768 ? 2 : 1);
                          double spacing = 24.0;
                          double width = (constraints.maxWidth - (cols - 1) * spacing) / cols;

                          return Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            children: filteredBanks.map((bank) => _BankCard(width: width, bank: bank)).toList(),
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

class _BankCard extends StatelessWidget {
  final double width;
  final _Bank bank;

  const _BankCard({required this.width, required this.bank});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MissionCard(
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(LucideIcons.building, color: Colors.red, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bank.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.colorScheme.outline),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(bank.type, style: const TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(children: [
                    Icon(LucideIcons.mapPin, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(bank.location, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ]),
                  const SizedBox(height: 8),
                   Row(children: [
                    Icon(LucideIcons.phone, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(bank.contact, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ]),
                   const SizedBox(height: 8),
                   Row(children: [
                    Icon(LucideIcons.clock, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(bank.status, style: TextStyle(
                      color: bank.status == "Open" ? Colors.green.shade600 : Colors.red.shade600, 
                      fontSize: 14, fontWeight: FontWeight.w600)),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: MissionButton(
                label: "View Details",
                variant: ButtonVariant.outline,
                fullWidth: true,
                onPressed: () => context.go('/banks/${bank.id}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
