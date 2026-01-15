import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'components/ui/toast.dart';
import 'routes.dart';

void main() {
  runApp(const MissionAidApp());
}

class MissionAidApp extends StatelessWidget {
  const MissionAidApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using ChangeNotifierProvider for ThemeMode if we implement toggling
    // For now, mirroring the "class" based approach by defaulting to system
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      // We must wrap the app in the Toast wrapper
      child: MissionToastWrapper(
        child: const _AppRoot(),
      ),
    );
  }
}

class _AppRoot extends StatelessWidget {
  const _AppRoot();

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    
    return MaterialApp.router(
      title: 'BloodLink',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      routerConfig: appRouter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
    );
  }
}

// Simple controller to manage ThemeMode, mirroring the Next-Themes provider
class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
