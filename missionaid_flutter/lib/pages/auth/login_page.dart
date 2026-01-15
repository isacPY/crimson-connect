import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/ui/button.dart';
import '../../components/ui/card.dart';
import '../../components/ui/input.dart';
import '../../components/ui/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  void _handleLogin() async {
    setState(() => isLoading = true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    if (mounted) {
      setState(() => isLoading = false);
      MissionToast.success(context, 
        title: "Welcome back!", 
        description: "You have successfully logged in."
      );
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50, // slate-50 equivalent
      body: Stack(
        children: [
          // Background decoration (simplified from CSS grid/gradients to standard Flutter decoration)
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(color: Colors.grey.withOpacity(0.05)),
            ),
          ),
          
          Center(
            child: SingleChildScrollView(
               padding: const EdgeInsets.all(16),
               child: ConstrainedBox(
                 constraints: const BoxConstraints(maxWidth: 448), // max-w-md
                 child: MissionCard(
                   child: Padding(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         // Header
                         Container(
                           width: 48, height: 48,
                           margin: const EdgeInsets.only(bottom: 16),
                           decoration: BoxDecoration(
                             color: theme.colorScheme.primaryContainer,
                             borderRadius: BorderRadius.circular(12),
                           ),
                           child: Icon(LucideIcons.droplet, color: theme.colorScheme.primary), // Placeholder logo
                         ),
                         Text("Welcome back", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                         const SizedBox(height: 8),
                         Text("Enter your credentials to access your account", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey), textAlign: TextAlign.center),
                         const SizedBox(height: 24),

                         // Form
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const MissionInput(label: "Email", placeholder: "john@example.com", keyboardType: TextInputType.emailAddress),
                             const SizedBox(height: 16),
                             const MissionInput(label: "Password", placeholder: "••••••••", obscureText: true),
                             const SizedBox(height: 24),
                             MissionButton(
                               label: isLoading ? "Signing in..." : "Sign In",
                               fullWidth: true,
                               onPressed: isLoading ? null : _handleLogin,
                             ),
                           ],
                         ),

                         const SizedBox(height: 24),
                         
                         // Footer Links
                         TextButton(
                           onPressed: () {}, 
                           child: const Text("Forgot your password?", style: TextStyle(fontSize: 14))
                         ),
                         const SizedBox(height: 4),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text("Don't have an account? ", style: TextStyle(fontSize: 14)),
                             GestureDetector(
                               onTap: () => context.go('/auth/signup'),
                               child: Text("Sign up", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
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
