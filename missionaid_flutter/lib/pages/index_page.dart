import 'package:flutter/material.dart';
import '../components/layout/header.dart';
import '../components/layout/footer.dart';
import '../components/sections/hero_section.dart';
import '../components/sections/roles_section.dart';
import '../components/sections/stats_section.dart';
import '../components/sections/how_it_works_section.dart';
import '../components/sections/blood_types_section.dart';
import '../components/sections/featured_donors_section.dart';
import '../components/sections/cta_section.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true, // For Hero gradient background under header
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            RolesSection(),
            StatsSection(),
            FeaturedDonorsSection(),
            HowItWorksSection(),
            BloodTypesSection(),
            CTASection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
