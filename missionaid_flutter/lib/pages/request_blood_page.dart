import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/input.dart';
import '../components/ui/select.dart';
import '../components/ui/card.dart';
import '../components/ui/toast.dart';

class RequestBloodPage extends StatefulWidget {
  const RequestBloodPage({super.key});

  @override
  State<RequestBloodPage> createState() => _RequestBloodPageState();
}

class _RequestBloodPageState extends State<RequestBloodPage> {
  bool isSubmitting = false;
  String urgency = "normal";

  void _handleSubmit() async {
    setState(() => isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => isSubmitting = false);
      MissionToast.success(context, 
        title: "Request Submitted", 
        description: "Your blood request has been broadcasted to nearby donors and blood banks."
      );
    }
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
                constraints: const BoxConstraints(maxWidth: 768), // max-w-3xl
                child: Column(
                  children: [
                    const Text("Request Blood", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text("Submit a request for blood. We will notify nearby donors and blood banks immediately.", 
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 32),

                    MissionCard(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              border: Border(bottom: BorderSide(color: Colors.red.shade100)),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.alertCircle, color: Colors.red),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Urgent Request", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text("Please provide accurate information to avoid delays.", style: TextStyle(color: Colors.red.shade800, fontSize: 13)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Patient Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 24),
                                
                                // Fields
                                Wrap(
                                  spacing: 24, runSpacing: 24,
                                  children: [
                                    _Field(label: "Patient Name", placeholder: "Full Name"),
                                    _Field(label: "Patient Age", placeholder: "Age", type: TextInputType.number),
                                    _SelectField(label: "Blood Group Required", items: const ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]),
                                    _Field(label: "Units Required", placeholder: "Number of units", type: TextInputType.number),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                
                                const Text("Urgency Level", style: TextStyle(fontWeight: FontWeight.w500)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _RadioOption(label: "Critical (Within hours)", value: "critical", groupValue: urgency, onChanged: (v) => setState(() => urgency=v), color: Colors.red),
                                    const SizedBox(width: 16),
                                    _RadioOption(label: "Urgent (24h)", value: "urgent", groupValue: urgency, onChanged: (v) => setState(() => urgency=v)),
                                    const SizedBox(width: 16),
                                    _RadioOption(label: "Normal", value: "normal", groupValue: urgency, onChanged: (v) => setState(() => urgency=v)),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                Wrap(
                                  spacing: 24, runSpacing: 24,
                                  children: [
                                     _Field(label: "Hospital Name", placeholder: "Hospital Name"),
                                     _Field(label: "Contact Number", placeholder: "Primary Contact", type: TextInputType.phone),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                const MissionInput(label: "Hospital Address / Location", placeholder: "Full address...", maxLines: 3),
                                const SizedBox(height: 16),
                                const MissionInput(label: "Additional Note", placeholder: "Specific instructions...", maxLines: 3),
                                const SizedBox(height: 32),

                                MissionButton(
                                  label: isSubmitting ? "Submitting..." : "Submit Blood Request",
                                  fullWidth: true,
                                  size: ButtonSize.lg,
                                  onPressed: isSubmitting ? null : _handleSubmit,
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600, foregroundColor: Colors.white),
                                ),
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
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label, placeholder;
  final TextInputType? type;
  const _Field({required this.label, required this.placeholder, this.type});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 320, child: MissionInput(label: label, placeholder: placeholder, keyboardType: type));
  }
}

class _SelectField extends StatelessWidget {
  final String label;
  final List<String> items;
  const _SelectField({required this.label, required this.items});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: MissionSelect<String>(
        label: label,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) {},
        placeholder: "Select",
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label, value, groupValue;
  final ValueChanged<String> onChanged;
  final Color? color;
  const _RadioOption({required this.label, required this.value, required this.groupValue, required this.onChanged, this.color});

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(selected ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: selected ? (color ?? Theme.of(context).primaryColor) : Colors.grey, size: 20),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: selected ? (color ?? Colors.black) : Colors.black, fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
