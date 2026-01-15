import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/ui/button.dart';
import '../components/ui/input.dart';
import '../components/ui/select.dart';
import '../components/ui/card.dart';
import '../components/ui/toast.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleSubmit(String type) async {
    setState(() => isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => isSubmitting = false);
      MissionToast.success(context, 
        title: "$type Registration Successful", 
        description: type == "Donor" 
          ? "Thank you for registering as a donor. We will contact you soon." 
          : "Your patient profile has been created."
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
                constraints: const BoxConstraints(maxWidth: 896), // max-w-4xl
                child: Column(
                  children: [
                     // Hero Text
                     Text("Join the Life Saving Community", 
                       style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                       textAlign: TextAlign.center,
                     ),
                     const SizedBox(height: 16),
                     Text(
                       "Whether you are here to donate blood or registering a patient, your participation helps save lives.",
                       style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6)),
                       textAlign: TextAlign.center,
                     ),
                     const SizedBox(height: 48),

                     // Tabs
                     Container(
                       height: 48,
                       decoration: BoxDecoration(
                         color: theme.colorScheme.surfaceVariant.withOpacity(0.5), // bg-muted
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: TabBar(
                         controller: _tabController,
                         indicator: BoxDecoration(
                           color: theme.colorScheme.surface,
                           borderRadius: BorderRadius.circular(6),
                           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                         ),
                         indicatorPadding: const EdgeInsets.all(4),
                         labelColor: theme.colorScheme.onSurface,
                         unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.6),
                         labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                         tabs: const [
                           Tab(text: "Register as Donor"),
                           Tab(text: "Register as Patient/Caretaker"),
                         ],
                       ),
                     ),
                     const SizedBox(height: 32),

                     // Content
                     AnimatedContainer(
                       duration: const Duration(milliseconds: 300),
                       child: SizedBox(
                         height: 900, // Fixed height or enough to fit form
                         child: TabBarView(
                           controller: _tabController,
                           children: [
                             _DonorForm(isSubmitting: isSubmitting, onSubmit: () => _handleSubmit("Donor")),
                             _PatientForm(isSubmitting: isSubmitting, onSubmit: () => _handleSubmit("Patient")),
                           ],
                         ),
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

class _DonorForm extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const _DonorForm({required this.isSubmitting, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return MissionCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Donor Registration", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Please fill out the details honestly to help us match you with those in need.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            
            // Form Grid
            Wrap(
              runSpacing: 24,
              spacing: 24,
              children: [
                _Field(label: "Full Name", placeholder: "John Doe"),
                _Field(label: "Date of Birth", placeholder: "YYYY-MM-DD", type: TextInputType.datetime), // Mock date
                _SelectField(label: "Blood Group", items: const ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]),
                _SelectField(label: "Gender", items: const ["Male", "Female", "Other"]),
                _Field(label: "Phone Number", placeholder: "+1 234 567 890", type: TextInputType.phone),
                _Field(label: "Weight (kg)", placeholder: "65", type: TextInputType.number),
              ],
            ),
            const SizedBox(height: 32),
            const Text("Medical History & Eligibility", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 16),
            
            // Checkboxes
            Wrap(
              spacing: 32, runSpacing: 16,
              children: const [
                _Checkbox(label: "Have you donated blood in the last 3 months?"),
                _Checkbox(label: "Do you have any chronic illnesses?"),
                _Checkbox(label: "Are you currently on any medication?"),
                _Checkbox(label: "Have you had any recent surgeries?"),
              ],
            ),
            const SizedBox(height: 32),
            const MissionInput(label: "Address", placeholder: "123 Main St, City, Country", maxLines: 3),
            const SizedBox(height: 32),
            
            MissionButton(
              label: isSubmitting ? "Registering..." : "Register as Donor",
              onPressed: isSubmitting ? null : onSubmit,
              fullWidth: true,
              size: ButtonSize.lg,
            )
          ],
        ),
      ),
    );
  }
}

class _PatientForm extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const _PatientForm({required this.isSubmitting, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return MissionCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Patient/Caretaker Registration", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Create a profile for the patient to request blood or find donors more easily.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            
            Wrap(
              runSpacing: 24,
              spacing: 24,
              children: [
                 _Field(label: "Patient Name", placeholder: "Jane Doe"),
                 _Field(label: "Caretaker Name (Optional)", placeholder: "John Doe"),
                 _Field(label: "Patient DOB", placeholder: "YYYY-MM-DD"),
                 _SelectField(label: "Blood Group Needed", items: const ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]),
                 _Field(label: "Current Hospital (Optional)", placeholder: "City General Hospital"),
                 _Field(label: "Contact Number", placeholder: "+1 234 567 890", type: TextInputType.phone),
              ],
            ),
            const SizedBox(height: 32),
            const MissionInput(label: "Medical Condition/Reason", placeholder: "Briefly describe the medical need...", maxLines: 3),
            const SizedBox(height: 24),
            const MissionInput(label: "Address", placeholder: "123 Main St, City, Country", maxLines: 3),
            const SizedBox(height: 32),
            
            MissionButton(
              label: isSubmitting ? "Creating Profile..." : "Create Patient Profile",
              onPressed: isSubmitting ? null : onSubmit,
              fullWidth: true,
              size: ButtonSize.lg,
            )
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
    return SizedBox(
      width: 380, // rough half width of lg container
      child: MissionInput(label: label, placeholder: placeholder, keyboardType: type),
    );
  }
}

class _SelectField extends StatelessWidget {
  final String label;
  final List<String> items;
  const _SelectField({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: MissionSelect<String>(
        label: label,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) {},
        placeholder: "Select",
      ),
    );
  }
}

class _Checkbox extends StatefulWidget {
  final String label;
  const _Checkbox({required this.label});

  @override
  State<_Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<_Checkbox> {
  bool val = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Row(
        children: [
          Checkbox(value: val, onChanged: (v) => setState(() => val = v!)),
          const SizedBox(width: 8),
          Expanded(child: Text(widget.label, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
