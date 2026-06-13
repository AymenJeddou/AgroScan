import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/design_system/pest_card.dart';
import '../../../../core/design_system/skeletal_loader.dart';
import '../../../../core/design_system/animated_entry.dart';
import '../../../../core/providers.dart';
import '../controllers/library_controller.dart';
import 'pest_detail_screen.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final state = ref.watch(libraryControllerProvider);
    final controller = ref.read(libraryControllerProvider.notifier);
    final favoriteIds = ref.watch(favoriteIdsProvider).valueOrNull ?? {};
    final filteredPests = controller.getFilteredPests(favoriteIds: favoriteIds);

    // ── Ordre options ────────────────────────────────────────────────────────
    final ordreOptions = <(String, String)>[
      ('', _s(locale, 'Tous les ordres', 'All orders', 'كل الرتب')),
      ('Lepidoptera', _s(locale, 'Lépidoptère', 'Lepidoptera', 'حرشفيات الأجنحة')),
      ('Hemiptera', _s(locale, 'Hémiptère', 'Hemiptera', 'نصفيات الأجنحة')),
      ('Coleoptera', _s(locale, 'Coléoptère', 'Coleoptera', 'غمديات الأجنحة')),
      ('Diptera', _s(locale, 'Diptère', 'Diptera', 'ثنائيات الأجنحة')),
      ('Thysanoptera', _s(locale, 'Thysanoptère', 'Thysanoptera', 'هدبيات الأجنحة')),
      ('Acari', _s(locale, 'Acarien', 'Mites (Acari)', 'عث (حلم)')),
    ];

    // ── Milieu options ───────────────────────────────────────────────────────
    final milieuOptions = <(String, String)>[
      ('', _s(locale, 'Tous milieux', 'All', 'كل البيئات')),
      ('plein_champ', _s(locale, 'Plein champ', 'Open field', 'الحقل المكشوف')),
      ('sous_serre', _s(locale, 'Sous serre', 'Greenhouse', 'البيت المحمي')),
    ];

    // ── Statut options ───────────────────────────────────────────────────────
    final statutOptions = <(String, String)>[
      ('', _s(locale, 'Tous statuts', 'All', 'كل الحالات')),
      ('favorites', '♥  ${l10n.libraryFavorites}'),
      ('quarantaine', _s(locale, 'Quarantaine', 'Quarantine', 'حجر صحي')),
      ('polyphage', _s(locale, 'Polyphage', 'Polyphagous', 'متعدد العوائل')),
    ];

    // ── Culture pills ────────────────────────────────────────────────────────
    final cultureOptions = <(String, String)>[
      ('olivier', l10n.libraryCropFilterOlive),
      ('agrumes', l10n.libraryCropFilterCitrus),
      ('tomate', l10n.libraryCropFilterTomato),
      ('pomme_de_terre', l10n.libraryCropFilterPommeDeTerre),
      ('cereales', l10n.libraryCropFilterCereal),
      ('palmier', l10n.libraryCropFilterPalm),
      ('vigne', l10n.libraryCropFilterVine),
      ('maraichage', l10n.libraryCropFilterMaraichage),
      ('arboriculture', l10n.libraryCropFilterArboriculture),
      ('betterave', l10n.libraryCropFilterBetterave),
      ('oignon', l10n.libraryCropFilterOignon),
      ('figuier_de_barbarie', l10n.libraryCropFilterFiguierBarbarie),
      ('ornement', l10n.libraryCropFilterOrnement),
      ('polyphage', l10n.libraryCropFilterPolyphage),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navLibrary)),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: context.appHeroGradient),
            ),
          ),
          Column(
            children: [
              // ── Search bar ─────────────────────────────────────────────
              RevealOnLoad(
                delay: const Duration(milliseconds: 80),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => controller.setSearchQuery(val),
                    decoration: InputDecoration(
                      hintText: l10n.librarySearchPlaceholder,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppTheme.primaryColor,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                controller.setSearchQuery('');
                              },
                            )
                          : null,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              // ── Ordre + Milieu dropdowns ───────────────────────────────
              RevealOnLoad(
                delay: const Duration(milliseconds: 120),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: _FilterDropdown(
                          value: state.ordreFilter,
                          options: ordreOptions,
                          onChanged: controller.setOrdreFilter,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _FilterDropdown(
                          value: state.milieuFilter,
                          options: milieuOptions,
                          onChanged: controller.setMilieuFilter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Culture pills ──────────────────────────────────────────
              RevealOnLoad(
                delay: const Duration(milliseconds: 160),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: cultureOptions
                          .map(
                            (c) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _FilterChip(
                                label: c.$2,
                                value: c.$1,
                                activeValue: state.cultureFilter,
                                onTap: () => controller.setCultureFilter(
                                  state.cultureFilter == c.$1 ? '' : c.$1,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),

              // ── Statut dropdown + result count ─────────────────────────
              RevealOnLoad(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: _FilterDropdown(
                          value: state.statutFilter,
                          options: statutOptions,
                          onChanged: controller.setStatutFilter,
                        ),
                      ),
                      const SizedBox(width: 10),
                      state.pests.when(
                        data: (_) => Text(
                          _resultCountLabel(locale, filteredPests.length),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: context.appMutedColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.5,
                          ),
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (e, _) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Pests grid ─────────────────────────────────────────────
              Expanded(
                child: state.pests.when(
                  data: (_) {
                    if (filteredPests.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                state.statutFilter == 'favorites'
                                    ? Icons.favorite_border_rounded
                                    : Icons.search_off_outlined,
                                size: 64,
                                color: context.appTextColor
                                    .withValues(alpha: 0.35),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.statutFilter == 'favorites'
                                    ? l10n.libraryNoFavorites
                                    : _emptyMsg(locale),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: context.appTextColor
                                      .withValues(alpha: 0.45),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      itemCount: filteredPests.length,
                      padding:
                          const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.52,
                      ),
                      itemBuilder: (context, index) {
                        final pest = filteredPests[index];
                        final delayMs = 80 + (index * 40);
                        return RevealOnLoad(
                          delay: Duration(
                            milliseconds:
                                delayMs.clamp(80, 360).toInt(),
                          ),
                          child: PestCard(
                            pest: pest,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PestDetailScreen(pest: pest),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const SkeletalGridLoader(),
                  error: (err, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('Error: $err',
                          style: TextStyle(color: context.appMutedColor)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _s(String locale, String fr, String en, String ar) {
    if (locale == 'ar') return ar;
    if (locale == 'en') return en;
    return fr;
  }

  static String _resultCountLabel(String locale, int count) {
    if (locale == 'ar') return '$count نوع معروض';
    if (locale == 'en') return '$count species shown';
    return '$count espèce${count > 1 ? 's' : ''} affichée${count > 1 ? 's' : ''}';
  }

  static String _emptyMsg(String locale) {
    if (locale == 'ar') return 'لم يتم العثور على آفات مطابقة لمعايير البحث.';
    if (locale == 'en') return 'No matching pests found. Try adjusting the filters.';
    return 'Aucun ravageur ne correspond aux filtres sélectionnés.';
  }
}

// ── Compact filter dropdown ────────────────────────────────────────────────

class _FilterDropdown extends StatelessWidget {
  final String value;
  final List<(String, String)> options;
  final ValueChanged<String> onChanged;

  const _FilterDropdown({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = value.isNotEmpty;
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isActive
            ? AppTheme.primaryColor.withValues(alpha: 0.09)
            : context.appCardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? AppTheme.primaryColor : context.appStrokeColor,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.expand_more,
            size: 16,
            color: isActive ? AppTheme.primaryColor : context.appMutedColor,
          ),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? AppTheme.primaryColor : context.appMutedColor,
          ),
          dropdownColor: context.appCardColor,
          items: options
              .map((opt) => DropdownMenuItem<String>(
                    value: opt.$1,
                    child: Text(
                      opt.$2,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: opt.$1 == value
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: opt.$1 == value
                            ? AppTheme.primaryColor
                            : context.appTextColor,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (v) => onChanged(v ?? ''),
        ),
      ),
    );
  }
}

// ── Filter chip ────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = value == activeValue;
    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      onSelected: (_) => onTap(),
      backgroundColor: context.appCardColor,
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: isActive ? Colors.white : context.appMutedColor,
        fontWeight: FontWeight.w700,
        fontSize: 12.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isActive ? AppTheme.primaryColor : context.appStrokeColor,
        ),
      ),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    );
  }
}
