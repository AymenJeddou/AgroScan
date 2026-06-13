import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

class CropBadge extends StatelessWidget {
  final String cropType;
  final bool isLarge;

  const CropBadge({
    super.key,
    required this.cropType,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final crop = cropType.toLowerCase().trim();

    final _CropStyle style = _styleFor(crop, locale);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 12 : 8,
        vertical: isLarge ? 6 : 3,
      ),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(style.emoji, style: TextStyle(fontSize: isLarge ? 13 : 10)),
          const SizedBox(width: 4),
          Text(
            style.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: style.fg,
              fontWeight: FontWeight.bold,
              fontSize: isLarge ? 12 : 10,
            ),
          ),
        ],
      ),
    );
  }

  static _CropStyle _styleFor(String crop, String locale) {
    final isFr = locale == 'fr';
    final isAr = locale == 'ar';

    switch (crop) {
      // ── Legacy keys (kept for backward compatibility with saved history) ──
      case 'tomato':
      case 'tomate':
        return _CropStyle(
          emoji: '🍅',
          label: isAr ? 'طماطم' : (isFr ? 'Tomate' : 'Tomato'),
          bg: const Color(0xFFFFEBEE),
          fg: const Color(0xFFC62828),
        );
      case 'pepper':
        return _CropStyle(
          emoji: '🌶️',
          label: isAr ? 'فلفل' : (isFr ? 'Poivron' : 'Pepper'),
          bg: const Color(0xFFE8F5E9),
          fg: const Color(0xFF2E7D32),
        );
      case 'olive':
      case 'olivier':
        return _CropStyle(
          emoji: '🫒',
          label: isAr ? 'زيتون' : (isFr ? 'Olivier' : 'Olive trees'),
          bg: const Color(0xFFF1F8E9),
          fg: const Color(0xFF558B2F),
        );
      case 'palm':
      case 'palmier':
        return _CropStyle(
          emoji: '🌴',
          label: isAr ? 'نخيل التمر' : (isFr ? 'Palmier dattier' : 'Date Palm'),
          bg: const Color(0xFFFFF8E1),
          fg: const Color(0xFFE65100),
        );
      case 'citrus':
      case 'agrumes':
        return _CropStyle(
          emoji: '🍊',
          label: isAr ? 'حمضيات' : (isFr ? 'Agrumes' : 'Citrus'),
          bg: const Color(0xFFFFF3E0),
          fg: const Color(0xFFF57C00),
        );
      case 'vine':
      case 'vigne':
        return _CropStyle(
          emoji: '🍇',
          label: isAr ? 'عنب' : (isFr ? 'Vigne' : 'Vine'),
          bg: const Color(0xFFF3E5F5),
          fg: const Color(0xFF7B1FA2),
        );
      case 'cereal':
      case 'cereales':
        return _CropStyle(
          emoji: '🌾',
          label: isAr ? 'حبوب' : (isFr ? 'Céréales' : 'Cereals'),
          bg: const Color(0xFFFFF9C4),
          fg: const Color(0xFFF9A825),
        );
      // ── New culture keys ────────────────────────────────────────────────
      case 'pomme_de_terre':
        return _CropStyle(
          emoji: '🥔',
          label: isAr ? 'بطاطا' : (isFr ? 'Pomme de terre' : 'Potato'),
          bg: const Color(0xFFFBE9E7),
          fg: const Color(0xFFBF360C),
        );
      case 'maraichage':
        return _CropStyle(
          emoji: '🥬',
          label: isAr ? 'خضروات' : (isFr ? 'Maraîchage' : 'Horticulture'),
          bg: const Color(0xFFE8F5E9),
          fg: const Color(0xFF2E7D32),
        );
      case 'arboriculture':
        return _CropStyle(
          emoji: '🍎',
          label: isAr ? 'الأشجار المثمرة' : (isFr ? 'Arboriculture' : 'Orchards'),
          bg: const Color(0xFFFFEBEE),
          fg: const Color(0xFFAD1457),
        );
      case 'betterave':
        return _CropStyle(
          emoji: '🫜',
          label: isAr ? 'شمندر' : (isFr ? 'Betterave' : 'Beetroot'),
          bg: const Color(0xFFF3E5F5),
          fg: const Color(0xFF8E24AA),
        );
      case 'oignon':
        return _CropStyle(
          emoji: '🧅',
          label: isAr ? 'بصل' : (isFr ? 'Oignon' : 'Onion'),
          bg: const Color(0xFFFFF3E0),
          fg: const Color(0xFFEF6C00),
        );
      case 'figuier_de_barbarie':
        return _CropStyle(
          emoji: '🌵',
          label: isAr
              ? 'صبار التين'
              : (isFr ? 'Figuier de Barbarie' : 'Prickly pear'),
          bg: const Color(0xFFE8F5E9),
          fg: const Color(0xFF388E3C),
        );
      case 'ornement':
        return _CropStyle(
          emoji: '🌸',
          label: isAr ? 'نباتات الزينة' : (isFr ? 'Ornement' : 'Ornamental'),
          bg: const Color(0xFFFCE4EC),
          fg: const Color(0xFFC2185B),
        );
      case 'polyphage':
        return _CropStyle(
          emoji: '🌍',
          label: isAr ? 'متعدد العوائل' : (isFr ? 'Polyphage' : 'Polyphagous'),
          bg: const Color(0xFFE3F2FD),
          fg: const Color(0xFF1565C0),
        );
      case 'unknown':
      case 'general':
        return _CropStyle(
          emoji: '🔍',
          label: isAr ? 'غير محدد' : (isFr ? 'Général' : 'General'),
          bg: AppTheme.secondaryColor,
          fg: AppTheme.primaryColor,
        );
      default:
        return _CropStyle(
          emoji: '🌿',
          label: isAr ? 'أخرى' : (isFr ? 'Autre' : 'Other'),
          bg: AppTheme.secondaryColor,
          fg: AppTheme.primaryColor,
        );
    }
  }
}

class _CropStyle {
  final String emoji;
  final String label;
  final Color bg;
  final Color fg;
  const _CropStyle({
    required this.emoji,
    required this.label,
    required this.bg,
    required this.fg,
  });
}
