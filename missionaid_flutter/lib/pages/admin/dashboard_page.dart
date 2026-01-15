import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/ui/card.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Stats
    final stats = [
      {"title": "Total Users", "value": "2,345", "icon": LucideIcons.users, "color": Colors.blue, "bg": Colors.blue.shade100},
      {"title": "Blood Units", "value": "450", "icon": LucideIcons.droplet, "color": Colors.red, "bg": Colors.red.shade100},
      {"title": "Blood Banks", "value": "12", "icon": LucideIcons.building2, "color": Colors.green, "bg": Colors.green.shade100},
      {"title": "Active Requests", "value": "34", "icon": LucideIcons.activity, "color": Colors.orange, "bg": Colors.orange.shade100},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Dashboard", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Text("Overview of system activity and statistics.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),

          // Stats Grid
          LayoutBuilder(builder: (context, constraints) {
             int cols = constraints.maxWidth >= 1024 ? 4 : (constraints.maxWidth >= 768 ? 2 : 1);
             double spacing = 16.0;
             double width = (constraints.maxWidth - (cols-1)*spacing) / cols;
             
             return Wrap(
                spacing: spacing, runSpacing: spacing,
                children: stats.map((s) => _StatCard(width: width, data: s)).toList(),
             );
          }),
          
          const SizedBox(height: 32),

          // Activity & Approvals
          LayoutBuilder(builder: (context, constraints) {
             final isDesktop = constraints.maxWidth >= 1024;
             return Flex(
               direction: isDesktop ? Axis.horizontal : Axis.vertical,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   flex: isDesktop ? 4 : 0,
                   child: MissionCard(
                     child: Padding(
                       padding: const EdgeInsets.all(24),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                           const SizedBox(height: 24),
                           ...List.generate(3, (i) => _ActivityItem()),
                         ],
                       ),
                     ),
                   ),
                 ),
                 if (isDesktop) const SizedBox(width: 16) else const SizedBox(height: 16),
                 Expanded(
                    flex: isDesktop ? 3 : 0,
                    child: MissionCard(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Pending Approvals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 24),
                             ...List.generate(2, (i) => _ApprovalItem()),
                          ],
                        ),
                      ),
                    ),
                 ),
               ],
             );
          }),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final double width;
  final Map<String, dynamic> data;
  const _StatCard({required this.width, required this.data});

  @override
  Widget build(BuildContext context) {
    return MissionCard(
      // We need to constrain width somehow, MissionCard expands usually.
      // So we wrap content in sized box? No, MissionCard is Card->Container.
      // We can wrap MissionCard in SizedBox
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data['title'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: data['bg'], shape: BoxShape.circle),
                    child: Icon(data['icon'], size: 16, color: data['color']),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(data['value'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("+20.1% from last month", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      )
    );
  }
}

class _ActivityItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
          const SizedBox(width: 16),
          Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: const [
               Text("New donor registered: John Doe", style: TextStyle(fontWeight: FontWeight.w500)),
               Text("2 MINUTES AGO", style: TextStyle(fontSize: 10, color: Colors.grey)),
             ],
          )
        ],
      ),
    );
  }
}

class _ApprovalItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.only(bottom: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: const [
               Text("Blood Bank: Saint Hops", style: TextStyle(fontWeight: FontWeight.w500)),
               Text("Kyoto, JP", style: TextStyle(fontSize: 10, color: Colors.grey)),
             ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(4)),
            child: Text("Pending", style: TextStyle(color: Colors.amber.shade900, fontSize: 10, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
