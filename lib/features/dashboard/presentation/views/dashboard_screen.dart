import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../../../../app/navigation/app_shell.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/settings/settings_screen.dart';
import '../../../../core/providers.dart';
import '../../../../core/design_system/animated_entry.dart';
import 'pest_categories_screen.dart';

// Dashboard stats provider
final dashboardStatsProvider = StreamProvider<Map<String, int>>((ref) {
  final scanRepo = ref.watch(scanRepositoryProvider);
  return scanRepo.watchScans().map((scans) {
    final total = scans.length;
    final healthy = scans.where((s) => s.pestId == null || s.pestId!.isEmpty).length;
    return {'total': total, 'healthy': healthy, 'infested': total - healthy};
  });
});

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final PageController _tipController = PageController();
  Timer? _tipTimer;
  int _currentTip = 0;

  @override
  void initState() {
    super.initState();
    _tipTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      final nextTip = (_currentTip + 1) % 5;
      _tipController.animateToPage(
        nextTip,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _tipTimer?.cancel();
    _tipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final statsAsync = ref.watch(dashboardStatsProvider);
    final isDark = context.isDark;

    final tips = <String>[
      l10n.dashboardTip1,
      l10n.dashboardTip2,
      l10n.dashboardTip3,
      l10n.dashboardTip4,
      l10n.dashboardTip5,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: context.appTextColor),
            tooltip: l10n.settingsTitle,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: context.appHeroGradient),
            ),
          ),
          // Decorative blobs
          Positioned(
            top: -70,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withValues(alpha: isDark ? 0.07 : 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            left: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: isDark ? 0.10 : 0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Main scroll content
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 4, 20, MediaQuery.paddingOf(context).bottom + 88),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero banner ──────────────────────────────────────────
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 60),
                    child: _HeroBanner(l10n: l10n, isDark: isDark),
                  ),
                  const SizedBox(height: 24),

                  // ── Stats heading ────────────────────────────────────────
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 140),
                    child: Text(
                      l10n.dashboardStats,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Stat cards ───────────────────────────────────────────
                  statsAsync.when(
                    data: (stats) => RevealOnLoad(
                      delay: const Duration(milliseconds: 180),
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              title: l10n.dashboardTotalScans,
                              value: '${stats['total']}',
                              color: AppTheme.primaryColor,
                              icon: Icons.analytics_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              title: l10n.dashboardHealthy,
                              value: '${stats['healthy']}',
                              color: AppTheme.dangerLow,
                              icon: Icons.check_circle_outline,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              title: l10n.dashboardInfested,
                              value: '${stats['infested']}',
                              color: AppTheme.dangerHigh,
                              icon: Icons.bug_report_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    loading: () => Row(
                      children: const [
                        Expanded(child: _StatCardSkeleton()),
                        SizedBox(width: 12),
                        Expanded(child: _StatCardSkeleton()),
                        SizedBox(width: 12),
                        Expanded(child: _StatCardSkeleton()),
                      ],
                    ),
                    error: (err, _) => Center(
                      child: Text('Error: $err',
                          style: TextStyle(color: context.appMutedColor)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Rotating tips ─────────────────────────────────────────
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 240),
                    child: _RotatingTipsCard(
                      tips: tips,
                      controller: _tipController,
                      currentTip: _currentTip,
                      onPageChanged: (i) => setState(() => _currentTip = i),
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Quick actions heading ─────────────────────────────────
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      l10n.dashboardQuickActions,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Action cards ─────────────────────────────────────────
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 340),
                    child: _ActionCard(
                      title: l10n.dashboardStartScan,
                      subtitle: l10n.scanPrompt,
                      icon: Icons.camera_alt_rounded,
                      accentColor: AppTheme.primaryColor,
                      onTap: () =>
                          ref.read(navigationIndexProvider.notifier).state = 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 380),
                    child: _ActionCard(
                      title: l10n.dashboardBrowseLibrary,
                      subtitle: l10n.librarySearchPlaceholder,
                      icon: Icons.auto_stories_rounded,
                      accentColor: AppTheme.accentColor,
                      onTap: () =>
                          ref.read(navigationIndexProvider.notifier).state = 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 420),
                    child: _ActionCard(
                      title: l10n.dashboardAgriBot,
                      subtitle: l10n.dashboardAgriBotSubtitle,
                      icon: Icons.smart_toy_rounded,
                      accentColor: AppTheme.agriBotColor,
                      onTap: () =>
                          ref.read(navigationIndexProvider.notifier).state = 3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RevealOnLoad(
                    delay: const Duration(milliseconds: 460),
                    child: _ActionCard(
                      title: l10n.dashboardPestSectionTitle,
                      subtitle: l10n.dashboardPestCategoriesSubtitle,
                      icon: Icons.eco_rounded,
                      accentColor: const Color(0xFFF59E0B),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PestCategoriesScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero banner widget ─────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isDark;

  const _HeroBanner({required this.l10n, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1B3328), const Color(0xFF243D2E)]
              : [const Color(0xFF1F5A3C), const Color(0xFF2E7A52)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: isDark ? 0.20 : 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dashboardWelcome,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.dashboardSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.80),
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.eco_rounded,
                          size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        'AgroScan',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Rotating tips card ─────────────────────────────────────────────────────

class _RotatingTipsCard extends StatelessWidget {
  final List<String> tips;
  final PageController controller;
  final int currentTip;
  final ValueChanged<int> onPageChanged;
  final bool isDark;

  const _RotatingTipsCard({
    required this.tips,
    required this.controller,
    required this.currentTip,
    required this.onPageChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: context.appCardGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.appStrokeColor),
        boxShadow: [
          BoxShadow(
            color: AppTheme.textColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: PageView.builder(
              controller: controller,
              itemCount: tips.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.tips_and_updates_rounded,
                          color: AppTheme.accentColor,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tips[index],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            height: 1.45,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tips.length, (i) {
                final active = i == currentTip;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active
                        ? AppTheme.primaryColor
                        : AppTheme.primaryColor.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat card ──────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: context.appCardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appStrokeColor),
        boxShadow: [
          BoxShadow(
            color: context.appTextColor.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: context.appTextColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.appMutedColor,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Action card ────────────────────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: context.appCardGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.appStrokeColor),
        boxShadow: [
          BoxShadow(
            color: context.appTextColor.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accentColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.appMutedColor,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: accentColor.withValues(alpha: 0.80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Stat card skeleton ─────────────────────────────────────────────────────

class _StatCardSkeleton extends StatelessWidget {
  const _StatCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.appCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appStrokeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: context.appStrokeColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 10),
          _Shimmer(width: 36, height: 22, context: context),
          const SizedBox(height: 6),
          _Shimmer(width: 52, height: 10, context: context),
        ],
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  final double width;
  final double height;
  final BuildContext context;
  const _Shimmer(
      {required this.width, required this.height, required this.context});

  @override
  Widget build(BuildContext _) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.appStrokeColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

