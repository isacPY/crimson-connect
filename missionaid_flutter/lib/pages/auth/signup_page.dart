import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/ui/button.dart';
import '../../components/ui/card.dart';
import '../../components/ui/input.dart';
import '../../components/ui/toast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

  void _handleSignup() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    if (mounted) {
      setState(() => isLoading = false);
      MissionToast.success(context, 
        title: "Account created!", 
        description: "Welcome to BloodLink."
      );
      context.go('/get-started');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(color: Colors.grey.withOpacity(0.05)),
            ),
          ),
          
          Center(
             child: SingleChildScrollView(
               padding: const EdgeInsets.all(16),
               child: ConstrainedBox(
                 constraints: const BoxConstraints(maxWidth: 448),
                 child: MissionCard(
                   child: Padding(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Container(
                           width: 48, height: 48,
                           margin: const EdgeInsets.only(bottom: 16),
                           decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
                           child: Icon(LucideIcons.droplet, color: theme.colorScheme.primary),
                         ),
                         Text("Create an account", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                         const SizedBox(height: 8),
                         Text("Enter your details to get started", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey), textAlign: TextAlign.center),
                         const SizedBox(height: 24),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: const [
                                 Expanded(child: MissionInput(label: "First Name", placeholder: "John")),
                                 SizedBox(width: 16),
                                 Expanded(child: MissionInput(label: "Last Name", placeholder: "Doe")),
                               ],
                             ),
                             const SizedBox(height: 16),
                             const MissionInput(label: "Email", placeholder: "john@example.com", keyboardType: TextInputType.emailAddress),
                             const SizedBox(height: 16),
                             const MissionInput(label: "Password", placeholder: "••••••••", obscureText: true),
                             const SizedBox(height: 24),
                             MissionButton(
                               label: isLoading ? "Creating account..." : "Sign Up",
                               fullWidth: true,
                               onPressed: isLoading ? null : _handleSignup,
                             ),
                           ],
                         ),

                         const SizedBox(height: 24),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text("Already have an account? ", style: TextStyle(fontSize: 14)),
                             GestureDetector(
                               onTap: () => context.go('/auth/login'),
                               child: Text("Sign in", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 1;
    const step = 24.0;
    for (double i = 0; i < size.width; i += step) canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    for (double i = 0; i < size.height; i += step) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
