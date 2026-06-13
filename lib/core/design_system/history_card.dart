import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/history/domain/models/scan.dart';
import '../../app/theme/app_theme.dart';
import 'crop_badge.dart';

class HistoryCard extends StatelessWidget {
  final Scan scan;
  final VoidCallback onTap;

  const HistoryCard({super.key, required this.scan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    // Format timestamp
    final dateStr = DateFormat.yMMMd(locale).add_Hm().format(scan.createdAt);

    // Status visual mapping
    IconData syncIcon;
    Color syncColor;
    String syncTooltip;

    switch (scan.syncStatus) {
      case SyncStatus.synced:
        syncIcon = Icons.cloud_done_outlined;
        syncColor = AppTheme.dangerLow;
        syncTooltip = locale == 'ar'
            ? 'متزامن مع السحابة'
            : (locale == 'fr'
                  ? 'Synchronisé avec le cloud'
                  : 'Synced to cloud');
        break;
      case SyncStatus.pendingInsert:
      case SyncStatus.pendingDelete:
        syncIcon = Icons.cloud_queue_outlined;
        syncColor = AppTheme.dangerMedium;
        syncTooltip = locale == 'ar'
            ? 'في انتظار المزامنة'
            : (locale == 'fr'
                  ? 'En attente de synchronisation'
                  : 'Pending sync');
        break;
    }

    final isHealthy = scan.pestId == null || scan.pestId!.isEmpty;
    final pestDisplay = isHealthy
        ? (locale == 'ar'
              ? 'نبات سليم'
              : (locale == 'fr' ? 'Plante Saine' : 'Healthy Plant'))
        : (scan.notes ??
              (locale == 'ar'
                  ? 'آفة مكتشفة'
                  : (locale == 'fr' ? 'Ravageur détecté' : 'Pest detected')));

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 0,
      color: AppTheme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppTheme.strokeColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Visual preview: Local image file, remote fallback, or icon
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Builder(
                    builder: (context) {
                      final file = File(scan.imageLocalPath);
                      if (file.existsSync()) {
                        return Image.file(file, fit: BoxFit.cover);
                      } else if (scan.imageRemoteUrl != null &&
                          scan.imageRemoteUrl!.isNotEmpty) {
                        return Image.network(
                          scan.imageRemoteUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _placeholderIcon(),
                        );
                      }
                      return _placeholderIcon();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Meta details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Crop Badge
                        CropBadge(cropType: scan.cropType),
                        // Sync Status Indicator
                        Tooltip(
                          message: syncTooltip,
                          child: Icon(syncIcon, size: 18, color: syncColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Pest Name or Healthy tag
                    Text(
                      pestDisplay,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isHealthy
                            ? AppTheme.dangerLow
                            : AppTheme.textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    // Confidence Score (e.g. 92%)
                    if (!isHealthy)
                      Text(
                        '${(scan.confidenceScore * 100).toStringAsFixed(0)}% ${locale == 'ar' ? 'نسبة التأكد' : (locale == 'fr' ? 'de confiance' : 'confidence')}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 6),
                    // Date
                    Text(
                      dateStr,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.mutedTextColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderIcon() {
    return Container(
      color: AppTheme.secondaryColor,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppTheme.primaryColor,
          size: 24,
        ),
      ),
    );
  }
}
