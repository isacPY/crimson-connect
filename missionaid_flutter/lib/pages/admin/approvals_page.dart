import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/ui/card.dart';
import '../../components/ui/button.dart';
import '../../components/ui/badge.dart';
import '../../components/ui/toast.dart';

class AdminApprovalsPage extends StatefulWidget {
  const AdminApprovalsPage({super.key});

  @override
  State<AdminApprovalsPage> createState() => _AdminApprovalsPageState();
}

class _AdminApprovalsPageState extends State<AdminApprovalsPage> {
  // Mock Data
  List<Map<String, dynamic>> approvals = [
    {
      "id": 1,
      "name": "John Doe",
      "type": "Donor",
      "submitted": "2 hours ago",
      "details": {
        "age": 28, "gender": "Male", "bloodGroup": "O+", "weight": "72kg",
        "vitals": {"hemoglobin": "14.5 g/dL", "bp": "120/80", "pulse": "72 bpm"},
        "history": [
           {"q": "Chronic Illnesses?", "a": "None", "flag": false},
           {"q": "Travel History?", "a": "Brazil (3 months ago)", "flag": true},
        ]
      }
    },
    {
      "id": 2,
      "name": "Red Cross Center",
      "type": "Blood Bank",
      "submitted": "1 day ago",
      "details": {
         "license": "LIC-2024-001", "address": "123 Health Ave, Brooklyn, NY",
         "capacity": "5000 Units", "facilities": ["Cold Storage", "Mobile Van"]
      }
    }
  ];

  void _handleApprove(int id) {
    setState(() => approvals.removeWhere((x) => x['id'] == id));
    MissionToast.success(context, title: "Registration Approved");
  }

  void _handleReject(int id) {
    setState(() => approvals.removeWhere((x) => x['id'] == id));
    MissionToast.error(context, title: "Registration Rejected");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pending Approvals", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Text("Review and verify registration requests.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),

          if (approvals.isEmpty)
             Container(
               padding: const EdgeInsets.all(48),
               alignment: Alignment.center,
               decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid), borderRadius: BorderRadius.circular(8)),
               child: Column(children: const [
                 Icon(LucideIcons.checkCircle, size: 48, color: Colors.green),
                 SizedBox(height: 16),
                 Text("All caught up!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               ]),
             )
          else
            LayoutBuilder(builder: (context, constraints) {
               return Wrap(
                 spacing: 24, runSpacing: 24,
                 children: approvals.map((item) => SizedBox(
                   width: constraints.maxWidth >= 1024 ? (constraints.maxWidth - 24)/2 : constraints.maxWidth,
                   child: _ApprovalCard(item: item, onApprove: ()=>_handleApprove(item['id']), onReject: ()=>_handleReject(item['id'])),
                 )).toList(),
               );
            })
        ],
      ),
    );
  }
}

class _ApprovalCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onApprove, onReject;

  const _ApprovalCard({required this.item, required this.onApprove, required this.onReject});

  @override
  Widget build(BuildContext context) {
    final details = item['details'] as Map<String, dynamic>;
    final isDonor = item['type'] == "Donor";

    return MissionCard(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.amber, width: 4))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(item['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                           Text("Request for ${item['type']} • Submitted ${item['submitted']}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      if (isDonor) const MissionBadge(label: "Medical Review", variant: BadgeVariant.secondary),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  if (isDonor) ...[
                    // Donor Details
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Age: ${details['age']}", style: const TextStyle(color: Colors.grey)),
                         Text("Weight: ${details['weight']}", style: const TextStyle(color: Colors.grey)),
                         Text("Group: ${details['bloodGroup']}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                       ],
                    ),
                    const Divider(height: 32),
                    const Text("Vitals", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.grey.shade50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text("Hb: ${details['vitals']['hemoglobin']}"),
                           Text("BP: ${details['vitals']['bp']}"),
                           Text("HR: ${details['vitals']['pulse']}"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: (details['history'] as List).map<Widget>((h) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(h['q'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
                            Row(children: [
                              if (h['flag']) const Icon(LucideIcons.alertTriangle, size: 12, color: Colors.amber),
                              Text(h['a'], style: TextStyle(color: h['flag'] ? Colors.amber.shade800 : Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                            ]),
                          ],
                        ),
                      )).toList(),
                    )
                  ] else ...[
                    // Bank Details
                    _RowLabel("License No", details['license']),
                    _RowLabel("Address", details['address']),
                    _RowLabel("Capacity", details['capacity']),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: (details['facilities'] as List).map<Widget>((f) => MissionBadge(label: f, variant: BadgeVariant.outline)).toList(),
                    )
                  ],

                ],
              ),
            ),
            Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   MissionButton(label: "Reject", variant: ButtonVariant.destructive, size: ButtonSize.sm, onPressed: onReject),
                   const SizedBox(width: 12),
                   MissionButton(label: "Approve", size: ButtonSize.sm, onPressed: onApprove),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RowLabel extends StatelessWidget {
  final String label, value;
  const _RowLabel(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
