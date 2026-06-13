import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../../core/providers.dart';
import 'license_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: context.appHeroGradient),
            ),
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
            children: [
              // ── Language ─────────────────────────────────────────────
              _SectionHeader(label: l10n.settingsLanguage),
              const SizedBox(height: 8),
              _SettingsCard(
                children: [
                  _LangTile(
                    label: 'Français',
                    flag: '🇫🇷',
                    selected: locale.languageCode == 'fr',
                    onTap: () =>
                        ref.read(localeProvider.notifier).state =
                            const Locale('fr'),
                  ),
                  _Divider(),
                  _LangTile(
                    label: 'English',
                    flag: '🇬🇧',
                    selected: locale.languageCode == 'en',
                    onTap: () =>
                        ref.read(localeProvider.notifier).state =
                            const Locale('en'),
                  ),
                  _Divider(),
                  _LangTile(
                    label: 'العربية',
                    flag: '🇹🇳',
                    selected: locale.languageCode == 'ar',
                    onTap: () =>
                        ref.read(localeProvider.notifier).state =
                            const Locale('ar'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Appearance ────────────────────────────────────────────
              _SectionHeader(label: l10n.settingsAppearance),
              const SizedBox(height: 8),
              _SettingsCard(
                children: [
                  _ThemeTile(
                    label: l10n.settingsThemeLight,
                    icon: Icons.light_mode_outlined,
                    selected: themeMode == ThemeMode.light,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).state =
                            ThemeMode.light,
                  ),
                  _Divider(),
                  _ThemeTile(
                    label: l10n.settingsThemeDark,
                    icon: Icons.dark_mode_outlined,
                    selected: themeMode == ThemeMode.dark,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).state =
                            ThemeMode.dark,
                  ),
                  _Divider(),
                  _ThemeTile(
                    label: l10n.settingsThemeSystem,
                    icon: Icons.brightness_auto_outlined,
                    selected: themeMode == ThemeMode.system,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).state =
                            ThemeMode.system,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── About ─────────────────────────────────────────────────
              _SettingsCard(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            AppTheme.primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.eco_rounded,
                          color: AppTheme.primaryColor, size: 22),
                    ),
                    title: const Text(
                      'AgroScan',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '${l10n.settingsVersion} 1.0.0',
                      style: TextStyle(
                          color: context.appMutedColor, fontSize: 12),
                    ),
                  ),
                  _Divider(),
                  ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LicenseScreen(),
                      ),
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B61FF).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.balance_outlined,
                          color: Color(0xFF7B61FF), size: 22),
                    ),
                    title: Text(
                      l10n.settingsLicense,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded,
                        size: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: context.appMutedColor,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appStrokeColor),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  final String label;
  final String flag;
  final bool selected;
  final VoidCallback onTap;
  const _LangTile(
      {required this.label,
      required this.flag,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(flag, style: const TextStyle(fontSize: 22)),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppTheme.primaryColor : context.appTextColor,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle_rounded,
              color: AppTheme.primaryColor, size: 20)
          : null,
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _ThemeTile(
      {required this.label,
      required this.icon,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: selected ? AppTheme.primaryColor : context.appMutedColor,
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppTheme.primaryColor : context.appTextColor,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle_rounded,
              color: AppTheme.primaryColor, size: 20)
          : null,
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
        height: 1, thickness: 1, color: context.appStrokeColor, indent: 56);
  }
}
