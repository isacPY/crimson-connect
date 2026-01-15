import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const MissionCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}

class MissionCardHeader extends StatelessWidget {
  final Widget? title;
  final Widget? description;
  final Widget? content; // Optional trailing or extra content in header

  const MissionCardHeader({
    super.key,
    this.title,
    this.description,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0), // p-6
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5, // tracking-tight
                height: 1.2,
              ),
              child: title!,
            ),
          ],
          if (description != null) ...[
            const SizedBox(height: 6), // space-y-1.5
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), // text-muted-foreground
              ),
              child: description!,
            ),
          ],
          if (content != null) ...[
             const SizedBox(height: 6),
             content!
          ]
        ],
      ),
    );
  }
}

class MissionCardContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const MissionCardContent({
    super.key,
    required this.child,
    // p-6 pt-0 is default in shadcn card content
    this.padding = const EdgeInsets.fromLTRB(24, 0, 24, 24), 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}

class MissionCardFooter extends StatelessWidget {
  final Widget child;
  
  const MissionCardFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), // p-6 pt-0
      child: child,
    );
  }
}
