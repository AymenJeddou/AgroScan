import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/design_system/history_card.dart';
import '../../../../core/design_system/skeletal_loader.dart';
import '../../../../core/providers.dart';
import '../../../../core/design_system/animated_entry.dart';
import '../../../library/presentation/views/pest_detail_screen.dart';
import '../../domain/models/scan.dart';
import '../controllers/history_controller.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final scansAsync = ref.watch(scanHistoryProvider);
    final isSyncing = ref.watch(historyActionsProvider);
    final actions = ref.read(historyActionsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (isSyncing)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.primaryColor,
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.sync, color: AppTheme.primaryColor),
              tooltip: l10n.historySyncTrigger,
              onPressed: () => actions.syncWithCloud(),
            ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
            ),
          ),
          RefreshIndicator(
            onRefresh: () => actions.syncWithCloud(),
            color: AppTheme.primaryColor,
            child: scansAsync.when(
              data: (scans) {
                if (scans.isEmpty) {
                  return _buildEmptyState(context, l10n);
                }

                // Check if there are unsynced items to display a subtle indicator banner
                final hasUnsynced = scans.any(
                  (s) => s.syncStatus != SyncStatus.synced,
                );

                return Column(
                  children: [
                    _HistoryStatsCard(scans: scans, l10n: l10n),
                    if (hasUnsynced)
                      RevealOnLoad(
                        delay: const Duration(milliseconds: 120),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.strokeColor),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.cloud_off,
                                size: 16,
                                color: AppTheme.dangerMedium,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  l10n.historyUnsyncedBanner, // Example key
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: scans.length,
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        itemBuilder: (context, index) {
                          final scan = scans[index];
                          return Dismissible(
                            key: Key(scan.id),
                            direction: DismissDirection.endToStart,
                            resizeDuration: const Duration(milliseconds: 120),
                            background: Container(
                              color: AppTheme.dangerHigh,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (_) async {
                              actions.removeScan(scan.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.historyScanRemovedSnackbar),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return true;
                            },
                            child: HistoryCard(
                              scan: scan,
                              onTap: () async {
                                final pestId = scan.pestId;
                                if (pestId != null && pestId.isNotEmpty) {
                                  final libraryRepo = ref.read(
                                    libraryRepositoryProvider,
                                  );
                                  final pest = await libraryRepo.getPestById(
                                    pestId,
                                  );
                                  if (pest != null && context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PestDetailScreen(pest: pest),
                                      ),
                                    );
                                  }
                                } else {
                                  // Crop is healthy
                                  _showHealthyDetailDialog(context, scan, l10n);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const SkeletalListLoader(),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Error: $err'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history_toggle_off_outlined,
                size: 64,
                color: AppTheme.textColor.withValues(alpha: 0.15),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.historyNoScans,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textColor.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showHealthyDetailDialog(
    BuildContext context,
    Scan scan,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), //
          ),
          title: Text(
            l10n.scanDetailsTitle, // Example key
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppTheme.dangerLow,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.scanResultHealthy,
                style: const TextStyle(
                  color: AppTheme.dangerLow,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.libraryAffectedCrops,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    scan.cropType.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.close, // Example key
                style: const TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── History Stats Card ─────────────────────────────────────────────────────

class _HistoryStatsCard extends StatelessWidget {
  final List<Scan> scans;
  final AppLocalizations l10n;

  const _HistoryStatsCard({required this.scans, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = scans.length;
    final healthy = scans.where((s) => s.pestId == null || s.pestId!.isEmpty).length;
    final infested = total - healthy;

    // Top 3 pests by frequency
    final pestCounts = <String, int>{};
    final pestNames = <String, String>{};
    for (final s in scans) {
      if (s.pestId != null && s.pestId!.isNotEmpty) {
        pestCounts[s.pestId!] = (pestCounts[s.pestId!] ?? 0) + 1;
        if (s.notes != null && s.notes!.isNotEmpty) {
          pestNames[s.pestId!] = s.notes!;
        }
      }
    }
    final topPests = pestCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top3 = topPests.take(3).toList();

    return RevealOnLoad(
      delay: const Duration(milliseconds: 60),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appCardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: context.appStrokeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + counters row
            Row(
              children: [
                Text(
                  l10n.historyStatsTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const Spacer(),
                _StatPill(
                  icon: Icons.bar_chart_rounded,
                  value: '$total',
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                _StatPill(
                  icon: Icons.check_circle_outline,
                  value: '$healthy',
                  color: AppTheme.dangerLow,
                ),
                const SizedBox(width: 8),
                _StatPill(
                  icon: Icons.warning_amber_rounded,
                  value: '$infested',
                  color: AppTheme.dangerHigh,
                ),
              ],
            ),
            if (top3.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                l10n.historyTopPests,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.appMutedColor,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 8),
              ...top3.map((entry) {
                final name = pestNames[entry.key] ?? entry.key;
                final shortName = name.contains('—')
                    ? name.split('—').last.trim()
                    : name;
                final ratio = entry.value / infested.clamp(1, infested);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          shortName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: context.appTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ratio.clamp(0.0, 1.0),
                            minHeight: 6,
                            backgroundColor:
                                context.appStrokeColor.withValues(alpha: 0.6),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${entry.value}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  const _StatPill({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
