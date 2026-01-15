import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.only(top: 64, bottom: 32, left: 16, right: 16),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 768;
            
            if (isDesktop) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _BrandSection()),
                      const SizedBox(width: 48),
                      Expanded(child: _LinkSection(title: "Quick Links", links: const ["Find Donors", "Request Blood", "Blood Banks", "Donate Blood", "FAQs"])),
                      Expanded(child: _LinkSection(title: "Resources", links: const ["Eligibility Guide", "Blood Type Chart", "Health Tips", "Success Stories", "Blog"])),
                      Expanded(child: _ContactSection()),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const Divider(),
                  const SizedBox(height: 32),
                  const _BottomBar(isDesktop: true),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BrandSection(),
                  const SizedBox(height: 48),
                  _LinkSection(title: "Quick Links", links: const ["Find Donors", "Request Blood", "Blood Banks", "Donate Blood", "FAQs"]),
                  const SizedBox(height: 32),
                  _LinkSection(title: "Resources", links: const ["Eligibility Guide", "Blood Type Chart", "Health Tips", "Success Stories", "Blog"]),
                  const SizedBox(height: 32),
                  _ContactSection(),
                  const SizedBox(height: 48),
                  const Divider(),
                  const SizedBox(height: 32),
                  const _BottomBar(isDesktop: false),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.droplet, color: Theme.of(context).colorScheme.primary),
             const SizedBox(width: 8),
            Text("BloodLink", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Connecting donors with those in need. Every drop counts in saving lives.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _SocialIcon(icon: LucideIcons.facebook),
            _SocialIcon(icon: LucideIcons.twitter),
            _SocialIcon(icon: LucideIcons.instagram),
            _SocialIcon(icon: LucideIcons.linkedin),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}

class _LinkSection extends StatelessWidget {
  final String title;
  final List<String> links;

  const _LinkSection({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...links.map((l) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            l,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        )),
      ],
    );
  }
}

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact Us", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _ContactItem(icon: LucideIcons.phone, text: "+1 (800) 555-LINK"),
        _ContactItem(icon: LucideIcons.mail, text: "contact@bloodlink.org"),
        _ContactItem(icon: LucideIcons.mapPin, text: "123 Medical Center Drive\nHealth City, HC 12345"),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool isDesktop;
  const _BottomBar({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final children = [
      Text(
        "© 2024 BloodLink. All rights reserved.",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
      ),
      if (!isDesktop) const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Privacy Policy"),
          SizedBox(width: 16),
          Text("Terms of Service"),
        ],
      ),
    ];

    if (isDesktop) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children);
    } else {
      return Column(children: children);
    }
  }
}
