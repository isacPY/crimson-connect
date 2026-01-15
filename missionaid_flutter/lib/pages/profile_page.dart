import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/card.dart';
import '../components/ui/badge.dart';
import '../components/ui/avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock User Data
    final user = {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "role": "Donor",
      "bloodGroup": "O+",
      "location": "New York, NY",
      "joined": "January 2024",
      "donations": "3",
      "lastDonation": "15th March 2024"
    };

    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 896), // max-w-4xl
                child: Column(
                  children: [
                    // Header Card
                    MissionCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Container(
                            height: 128,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.red, Colors.redAccent]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: Column(
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, -48),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const MissionAvatar(size: 96, fallbackText: "JD", imageUrl: "https://github.com/shadcn.png"),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(user['name']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  const Icon(LucideIcons.mapPin, size: 14, color: Colors.grey),
                                                  const SizedBox(width: 4),
                                                  Text("${user['location']} • Joined ${user['joined']}", style: const TextStyle(color: Colors.grey)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: MissionButton(
                                          label: "Edit Profile",
                                          variant: ButtonVariant.outline,
                                          size: ButtonSize.sm,
                                          icon: const Icon(LucideIcons.edit, size: 14),
                                          onPressed: (){},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isDesktop = constraints.maxWidth >= 768;
                        return Flex(
                          direction: isDesktop ? Axis.horizontal : Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sidebar
                            SizedBox(
                              width: isDesktop ? 280 : double.infinity,
                              child: MissionCard(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Personal Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 16),
                                      _ProfileStat(icon: LucideIcons.droplet, label: "Blood Group", value: user['bloodGroup']!, isBadge: true),
                                      const Divider(height: 24),
                                      _ProfileStat(icon: LucideIcons.user, label: "Role", value: user['role']!),
                                      const Divider(height: 24),
                                      _ProfileStat(icon: LucideIcons.clock, label: "Last Donation", value: user['lastDonation']!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (isDesktop) const SizedBox(width: 24) else const SizedBox(height: 24),

                            // Main Content (Tabs)
                            Expanded(
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                                      child: const TabBar(
                                        indicatorColor: Colors.black,
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.grey,
                                        tabs: [
                                          Tab(text: "Donation History"),
                                          Tab(text: "My Requests"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 300, // Fixed height for now
                                      child: TabBarView(
                                        children: [
                                          _HistoryList(),
                                          const Center(child: Text("No requests found", style: TextStyle(color: Colors.grey))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
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

class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool isBadge;
  const _ProfileStat({required this.icon, required this.label, required this.value, this.isBadge = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
           Icon(icon, size: 16, color: Colors.grey),
           const SizedBox(width: 8),
           Text(label, style: const TextStyle(color: Colors.grey)),
        ]),
        isBadge 
          ? MissionBadge(label: value, variant: BadgeVariant.secondary)
          : Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MissionCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.green.shade100, shape: BoxShape.circle),
                child: const Icon(LucideIcons.history, color: Colors.green, size: 20),
              ),
              title: const Text("Donation at City Hospital", style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("15th March 2024", style: TextStyle(color: Colors.grey)),
              trailing: const MissionBadge(label: "Completed", variant: BadgeVariant.defaultBadge), // Should be green actually, but default is fine or customize
            ),
          ),
        );
      },
    );
  }
}
