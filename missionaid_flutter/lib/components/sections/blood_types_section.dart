import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BloodTypesSection extends StatelessWidget {
  const BloodTypesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFBFBFB),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
          // Header
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFFEECEE), borderRadius: BorderRadius.circular(999)),
                child: const Text("Blood Compatibility", style: TextStyle(color: Color(0xFF8B1A28), fontWeight: FontWeight.w500, fontSize: 13)),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  children: [
                    const TextSpan(text: "Know Your "),
                    TextSpan(text: "Blood Type", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Understanding blood type compatibility is crucial for safe transfusions. Find out who you can help.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 64),

          // Grid
          LayoutBuilder(
            builder: (context, constraints) {
               int cols = constraints.maxWidth >= 768 ? 4 : 2;
               double spacing = 24.0;
               double width = (constraints.maxWidth - (cols - 1) * spacing) / cols;

               final types = [
                 _Type("A+", ["A+", "AB+"], ["A+", "A-", "O+", "O-"], "35.7%", null),
                 _Type("A-", ["A+", "A-", "AB+", "AB-"], ["A-", "O-"], "6.3%", null),
                 _Type("B+", ["B+", "AB+"], ["B+", "B-", "O+", "O-"], "8.5%", null),
                 _Type("B-", ["B+", "B-", "AB+", "AB-"], ["B-", "O-"], "1.5%", null),
                 _Type("AB+", ["AB+"], ["All Types"], "3.4%", "Universal Receiver"),
                 _Type("AB-", ["AB+", "AB-"], ["A-", "B-", "AB-", "O-"], "0.6%", null),
                 _Type("O+", ["A+", "B+", "AB+", "O+"], ["O+", "O-"], "37.4%", null),
                 _Type("O-", ["All Types"], ["O-"], "6.6%", "Universal Donor"),
               ];

               return Wrap(
                 spacing: spacing,
                 runSpacing: spacing,
                 children: types.map((t) => _TypeCard(width: width, type: t)).toList(),
               );
            },
          ),
        ],
      ),
    );
  }
}

class _Type {
  final String label, pop, universal;
  final List<String> give, receive;
  _Type(this.label, this.give, this.receive, this.pop, String? uni) : universal = uni ?? "";
}

class _TypeCard extends StatelessWidget {
  final double width;
  final _Type type;

  const _TypeCard({required this.width, required this.type});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: width,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outline),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Column(
            children: [
              // Icon
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(color: const Color(0xFFFEECEE), borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(type.label, style: TextStyle(color: theme.colorScheme.primary, fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Population", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(type.pop, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              
              // Give
              const Align(alignment: Alignment.centerLeft, child: Text("Can donate to:", style: TextStyle(fontSize: 10, color: Colors.grey))),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4, runSpacing: 4,
                children: type.give.map((s) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                  child: Text(s, style: TextStyle(color: theme.colorScheme.primary, fontSize: 10, fontWeight: FontWeight.bold)),
                )).toList(),
              ),

              const SizedBox(height: 12),

              // Receive
              const Align(alignment: Alignment.centerLeft, child: Text("Can receive from:", style: TextStyle(fontSize: 10, color: Colors.grey))),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4, runSpacing: 4,
                children: type.receive.map((s) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFFEECEE), borderRadius: BorderRadius.circular(4)),
                  child: Text(s, style: const TextStyle(color: Color(0xFF8B1A28), fontSize: 10, fontWeight: FontWeight.bold)),
                )).toList(),
              ),
            ],
          ),
        ),

        if (type.universal.isNotEmpty)
          Positioned(
            top: -12,
            left: 0, right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.8)]),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(type.universal, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
      ],
    );
  }
}
