import 'package:flutter/material.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/design_system/animated_entry.dart';

class PestCategoriesScreen extends StatelessWidget {
  const PestCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = context.isDark;
    final theme = Theme.of(context);

    final categories = [
      _Category(
        name: l10n.dashboardCatLepidopteraName,
        desc: l10n.dashboardCatLepidopteraDesc,
        color: const Color(0xFFE8720C),
      ),
      _Category(
        name: l10n.dashboardCatDipteraName,
        desc: l10n.dashboardCatDipteraDesc,
        color: const Color(0xFF2563EB),
      ),
      _Category(
        name: l10n.dashboardCatHemipteraName,
        desc: l10n.dashboardCatHemipteraDesc,
        color: const Color(0xFF0D9488),
      ),
      _Category(
        name: l10n.dashboardCatColeopteraName,
        desc: l10n.dashboardCatColeopteraDesc,
        color: const Color(0xFF92400E),
      ),
      _Category(
        name: l10n.dashboardCatThysanopteraName,
        desc: l10n.dashboardCatThysanopteraDesc,
        color: const Color(0xFF7C3AED),
      ),
      _Category(
        name: l10n.dashboardCatAcariName,
        desc: l10n.dashboardCatAcariDesc,
        color: const Color(0xFFDC2626),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardPestSectionTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: context.appTextColor,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: context.appHeroGradient),
            ),
          ),
          ListView(
            padding: EdgeInsets.fromLTRB(
              20,
              8,
              20,
              MediaQuery.paddingOf(context).bottom + 24,
            ),
            children: [
              // ── Header banner ────────────────────────────────────────────
              RevealOnLoad(
                delay: const Duration(milliseconds: 60),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF1B3328), const Color(0xFF243D2E)]
                          : [
                              const Color(0xFF1F5A3C),
                              const Color(0xFF2E7A52)
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor
                            .withValues(alpha: isDark ? 0.20 : 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.dashboardPestSectionTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.dashboardPestCategoriesSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.80),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Intro text ───────────────────────────────────────────────
              RevealOnLoad(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: context.appCardGradient,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: context.appStrokeColor),
                    boxShadow: [
                      BoxShadow(
                        color: context.appTextColor.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    l10n.pestCategoriesIntro,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.appTextColor,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Category cards ───────────────────────────────────────────
              ...categories.asMap().entries.map((entry) {
                final i = entry.key;
                final cat = entry.value;
                return RevealOnLoad(
                  delay: Duration(milliseconds: 120 + i * 60),
                  child: _CategoryCard(
                    name: cat.name,
                    description: cat.desc,
                    accentColor: cat.color,
                    index: i + 1,
                    total: categories.length,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────

class _Category {
  final String name;
  final String desc;
  final Color color;
  const _Category({
    required this.name,
    required this.desc,
    required this.color,
  });
}

// ── Category card ─────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final Color accentColor;
  final int index;
  final int total;

  const _CategoryCard({
    required this.name,
    required this.description,
    required this.accentColor,
    required this.index,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
            decoration: BoxDecoration(
              gradient: context.appCardGradient,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: context.appStrokeColor),
              boxShadow: [
                BoxShadow(
                  color: context.appTextColor.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.appTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$index/$total',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.appMutedColor,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
