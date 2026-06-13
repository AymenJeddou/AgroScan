import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';

import 'app/splash_screen.dart';
import 'app/theme/app_theme.dart';
import 'core/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
    if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    }
  } catch (e) {
    debugPrint('Supabase initialization bypassed or failed: $e');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(libraryRepositoryProvider).seedOrUpdateCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeLocale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'AgroScan',
      debugShowCheckedModeBanner: false,

      // Both themes — Flutter picks automatically based on themeMode
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Prevents a black flash before the widget tree renders on Android
      color: AppTheme.primaryColor,

      locale: activeLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: const SplashScreen(),
    );
  }
}
