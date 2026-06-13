import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';

import '../../features/dashboard/presentation/views/dashboard_screen.dart';
import '../../features/library/presentation/views/library_screen.dart';
import '../../features/scanning/presentation/views/scan_screen.dart';
import '../../features/history/presentation/views/history_screen.dart';
import '../../features/chatbot/presentation/views/chatbot_screen.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(navigationIndexProvider);
    final l10n = AppLocalizations.of(context);

    const screens = [
      DashboardScreen(),
      LibraryScreen(),
      ScanScreen(),
      ChatbotScreen(),
      HistoryScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: activeIndex,
        children: List.generate(screens.length, (index) {
          final isActive = index == activeIndex;
          return AnimatedSlide(
            offset: isActive ? Offset.zero : const Offset(0.02, 0),
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeOutCubic,
            child: AnimatedOpacity(
              opacity: isActive ? 1 : 0,
              duration: const Duration(milliseconds: 420),
              child: screens[index],
            ),
          );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: context.appNavGradient,
          boxShadow: [
            BoxShadow(
              color: context.appTextColor.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: activeIndex,
            onDestinationSelected: (index) {
              ref.read(navigationIndexProvider.notifier).state = index;
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            height: 80,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.dashboard_outlined),
                selectedIcon: const Icon(Icons.dashboard),
                label: l10n.navDashboard,
              ),
              NavigationDestination(
                icon: const Icon(Icons.auto_stories_outlined),
                selectedIcon: const Icon(Icons.auto_stories),
                label: l10n.navLibrary,
              ),
              NavigationDestination(
                icon: const Icon(Icons.camera_alt_outlined),
                selectedIcon: const Icon(Icons.camera_alt),
                label: l10n.navScan,
              ),
              const NavigationDestination(
                icon: Icon(Icons.smart_toy_outlined),
                selectedIcon: Icon(Icons.smart_toy),
                label: 'AgriBot',
              ),
              NavigationDestination(
                icon: const Icon(Icons.history_outlined),
                selectedIcon: const Icon(Icons.history),
                label: l10n.navHistory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
