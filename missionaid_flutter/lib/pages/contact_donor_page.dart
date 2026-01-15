import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/card.dart';
import '../components/ui/input.dart';
import '../components/ui/toast.dart';

class ContactDonorPage extends StatefulWidget {
  final String id;
  const ContactDonorPage({super.key, required this.id});

  @override
  State<ContactDonorPage> createState() => _ContactDonorPageState();
}

class _ContactDonorPageState extends State<ContactDonorPage> {
  bool isSubmitting = false;

  void _handleSubmit() async {
    setState(() => isSubmitting = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => isSubmitting = false);
      MissionToast.success(context, title: "Message Sent", description: "The donor has been notified.");
      context.go('/donors');
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
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 512), // max-w-lg
                  child: MissionCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.05),
                            border: Border(bottom: BorderSide(color: theme.colorScheme.primary.withOpacity(0.1))),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
                                child: Icon(LucideIcons.messageSquare, color: theme.colorScheme.primary),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Contact Donor", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text("Send a secure message to Donor #${widget.id}", style: const TextStyle(color: Colors.grey)),
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
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    const Icon(LucideIcons.shieldCheck, color: Colors.blue, size: 20),
                                    const SizedBox(width: 12),
                                    const Expanded(child: Text("Your contact details are shared securely. We do not reveal the donor's direct contact info.", style: TextStyle(color: Colors.blue, fontSize: 13))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              const MissionInput(label: "Reason for Contact", placeholder: "e.g., Urgent Blood Requirement"),
                              const SizedBox(height: 16),
                              const MissionInput(label: "Message", placeholder: "Describe urgency...", maxLines: 4),
                              const SizedBox(height: 16),
                              const Text("Share My Contact Info", style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                              Row(
                                children: const [
                                  Expanded(child: MissionInput(placeholder: "Your Name")),
                                  SizedBox(width: 16),
                                  Expanded(child: MissionInput(placeholder: "Your Phone")),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Checkbox(value: true, onChanged: null),
                                   const Expanded(child: Text("I agree to share my details with this donor and understand that BloodLink is a platform connector.", style: TextStyle(fontSize: 12))),
                                ],
                              ),
                              const SizedBox(height: 24),
                              MissionButton(
                                label: isSubmitting ? "Sending..." : "Send Message",
                                onPressed: isSubmitting ? null : _handleSubmit,
                                fullWidth: true,
                                size: ButtonSize.lg,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey.shade50, border: Border(top: BorderSide(color: Colors.grey.shade200))),
                          child: const Text("Messages are monitored for safety and compliance.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
                        )
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
