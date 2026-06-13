import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/library/domain/models/pest.dart';
import '../../app/theme/app_theme.dart';
import '../../core/providers.dart';
import 'crop_badge.dart';

class PestCard extends ConsumerWidget {
  final Pest pest;
  final VoidCallback onTap;

  const PestCard({super.key, required this.pest, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final favoriteIds = ref.watch(favoriteIdsProvider).valueOrNull ?? {};
    final isFav = favoriteIds.contains(pest.id);

    Color dangerBg;
    Color dangerFg;
    String dangerLabel;

    switch (pest.dangerLevel) {
      case DangerLevel.low:
        dangerBg = const Color(0xFFE8F5E9);
        dangerFg = AppTheme.dangerLow;
        dangerLabel =
            locale == 'ar' ? 'منخفض' : (locale == 'fr' ? 'Faible' : 'Low');
        break;
      case DangerLevel.medium:
        dangerBg = const Color(0xFFFFF3E0);
        dangerFg = AppTheme.dangerMedium;
        dangerLabel =
            locale == 'ar' ? 'متوسط' : (locale == 'fr' ? 'Moyen' : 'Medium');
        break;
      case DangerLevel.high:
        dangerBg = const Color(0xFFFFEBEE);
        dangerFg = AppTheme.dangerHigh;
        dangerLabel =
            locale == 'ar' ? 'مرتفع' : (locale == 'fr' ? 'Élevé' : 'High');
        break;
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: context.appCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: context.appStrokeColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ──────────────────────────────────────────────────
            Stack(
              children: [
                Hero(
                  tag: 'pest-img-${pest.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: pest.localImages.isNotEmpty
                          ? Image.asset(
                              pest.localImages.first,
                              fit: BoxFit.cover,
                              cacheWidth: 480,
                              errorBuilder: (_, _, _) => _PestImageFallback(),
                            )
                          : _PestImageFallback(),
                    ),
                  ),
                ),
                // Danger badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: dangerBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      dangerLabel,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: dangerFg,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                // Favorite heart button
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => ref
                        .read(favoritesRepositoryProvider)
                        .toggleFavorite(pest.id),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 16,
                        color: isFav ? Colors.red[300] : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Info ───────────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 8, 11, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pest.getName(locale),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                            color: context.appTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          pest.scientificName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: context.appMutedColor,
                            fontSize: 10.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      pest.getDescription(locale),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.appMutedColor,
                        height: 1.35,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: pest.affectedCrops
                          .take(2)
                          .map((c) => CropBadge(cropType: c))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PestImageFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appSecondaryColor,
      child: Center(
        child: Icon(
          Icons.eco_rounded,
          color: AppTheme.primaryColor.withValues(alpha: 0.4),
          size: 36,
        ),
      ),
    );
  }
}
