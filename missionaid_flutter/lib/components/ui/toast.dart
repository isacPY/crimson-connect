import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// Since Shadcn's toast is hook-based `useToast`, but specifically used as `toast.success()`,
// we will provide a static helper class `MissionToast` to mimic this API.
// We must initialize ToastificationWrapper in the root of the app.

class MissionToast {
  static void success(BuildContext context, {required String title, String? description}) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      description: description != null ? Text(description, style: const TextStyle(fontSize: 12)) : null,
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
    );
  }

  static void error(BuildContext context, {required String title, String? description}) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      description: description != null ? Text(description, style: const TextStyle(fontSize: 12)) : null,
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: false,
      backgroundColor: Colors.white, // In dark mode this needs Theme reference
      borderSide: BorderSide(color: Colors.red.withOpacity(0.2)),
    );
  }
}

// Wrapper widget to be placed in main.dart
class MissionToastWrapper extends StatelessWidget {
  final Widget child;
  const MissionToastWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(child: child);
  }
}
