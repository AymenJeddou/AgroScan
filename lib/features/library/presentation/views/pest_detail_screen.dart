import 'package:flutter/material.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../../domain/models/pest.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/design_system/crop_badge.dart';

class PestDetailScreen extends StatefulWidget {
  final Pest pest;
  const PestDetailScreen({super.key, required this.pest});

  @override
  State<PestDetailScreen> createState() => _PestDetailScreenState();
}

class _PestDetailScreenState extends State<PestDetailScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _taxonomyKey = GlobalKey();
  final GlobalKey _descriptionKey = GlobalKey();
  final GlobalKey _lifecycleKey = GlobalKey();
  final GlobalKey _symptomsKey = GlobalKey();
  final GlobalKey _damageKey = GlobalKey();
  final GlobalKey _preventionKey = GlobalKey();
  final GlobalKey _mechanicalKey = GlobalKey();
  final GlobalKey _biologicalKey = GlobalKey();
  final GlobalKey _chemicalKey = GlobalKey();
  int _activeSectionIndex = 0;
  bool _isProgrammaticScroll = false;

  late final List<GlobalKey> _sectionKeys;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _taxonomyKey,
      _descriptionKey,
      _lifecycleKey,
      _symptomsKey,
      _damageKey,
      _preventionKey,
      _mechanicalKey,
      _biologicalKey,
      _chemicalKey,
    ];
    _tabController = TabController(length: _sectionKeys.length, vsync: this);
    _scrollController.addListener(_updateActiveSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    if (!mounted || _isProgrammaticScroll) return;
    final topCoverage = 56.0 + MediaQuery.of(context).padding.top + 50.0 + 10.0;
    int currentIndex = _activeSectionIndex;

    for (var i = 0; i < _sectionKeys.length; i++) {
      final sectionContext = _sectionKeys[i].currentContext;
      if (sectionContext == null) continue;
      final renderObject = sectionContext.findRenderObject();
      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        if (position.dy <= topCoverage) {
          currentIndex = i;
        }
      }
    }

    if (currentIndex != _activeSectionIndex) {
      setState(() => _activeSectionIndex = currentIndex);
      _tabController.animateTo(currentIndex);
    }
  }

  void _scrollTo(GlobalKey key, int index) {
    final ctx = key.currentContext;
    if (ctx != null) {
      final renderBox = ctx.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final scrollable = Scrollable.of(ctx);
        final currentPosition = scrollable.position.pixels;
        final scrollBox = scrollable.context.findRenderObject() as RenderBox?;
        if (scrollBox != null) {
          final topCoverage = 56.0 + MediaQuery.of(ctx).padding.top + 50.0;
          final offsetInScroll =
              renderBox.localToGlobal(Offset.zero, ancestor: scrollBox).dy +
                  currentPosition;
          final targetOffset = offsetInScroll - topCoverage;

          setState(() {
            _activeSectionIndex = index;
            _isProgrammaticScroll = true;
          });
          _tabController.animateTo(index);

          _scrollController
              .animateTo(
            targetOffset.clamp(0.0, scrollable.position.maxScrollExtent),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
          )
              .then((_) {
            if (mounted) setState(() => _isProgrammaticScroll = false);
          });
        }
      }
    }
  }

  void _openFullscreen(List<String> images, int initialIndex) {
    if (images.isEmpty) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, _, _) => _FullscreenViewer(
          images: images,
          initialIndex: initialIndex,
        ),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final pest = widget.pest;

    Color dangerColor;
    String dangerLabel;
    switch (pest.dangerLevel) {
      case DangerLevel.low:
        dangerColor = AppTheme.dangerLow;
        dangerLabel = l10n.detailDangerLow;
        break;
      case DangerLevel.medium:
        dangerColor = AppTheme.dangerMedium;
        dangerLabel = l10n.detailDangerMedium;
        break;
      case DangerLevel.high:
        dangerColor = AppTheme.dangerHigh;
        dangerLabel = l10n.detailDangerHigh;
        break;
    }

    final tabLabels = [
      l10n.detailTabTaxonomy,
      l10n.detailTabOverview,
      l10n.detailTabLifecycle,
      l10n.detailTabSymptoms,
      l10n.detailTabDamage,
      l10n.detailPrevention,
      l10n.detailTabMechanical,
      l10n.detailBiological,
      l10n.detailChemical,
    ];

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ── Hero app bar ───────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.textColor),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => _openFullscreen(pest.localImages, 0),
                    child: Hero(
                      tag: 'pest-img-${pest.id}',
                      child: pest.localImages.isNotEmpty
                          ? Image.asset(
                              pest.localImages.first,
                              fit: BoxFit.cover,
                              cacheWidth: 900,
                              errorBuilder: (_, _, _) => Container(
                                color: AppTheme.secondaryColor,
                                child: const Center(
                                  child: Icon(Icons.eco, size: 64,
                                      color: AppTheme.primaryColor),
                                ),
                              ),
                            )
                          : Container(
                              color: AppTheme.secondaryColor,
                              child: const Center(
                                child: Icon(Icons.eco, size: 64,
                                    color: AppTheme.primaryColor),
                              ),
                            ),
                    ),
                  ),
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.55),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  if (pest.localImages.isNotEmpty)
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: IgnorePointer(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.zoom_in, color: Colors.white, size: 14),
                              const SizedBox(width: 4),
                              Text(l10n.agrandir,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Header info ────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(gradient: context.appHeroGradient),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pest.getName(locale),
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pest.scientificName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: context.appMutedColor,
                      ),
                    ),
                    if (pest.order.isNotEmpty || pest.family.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (pest.order.isNotEmpty)
                            _TaxonChip(
                              label: l10n.detailTaxonomyOrder,
                              value: pest.order,
                            ),
                          if (pest.order.isNotEmpty && pest.family.isNotEmpty)
                            const SizedBox(width: 8),
                          if (pest.family.isNotEmpty)
                            _TaxonChip(
                              label: l10n.detailTaxonomyFamily,
                              value: pest.family,
                            ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: dangerColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            dangerLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: dangerColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        ...pest.affectedCrops
                            .map((c) => CropBadge(cropType: c, isLarge: true)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Photo gallery ──────────────────────────────────────────────────
          if (pest.localImages.length > 1)
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(gradient: context.appHeroGradient),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _PhotoGallery(
                  images: pest.localImages,
                  locale: locale,
                  onTap: (index) => _openFullscreen(pest.localImages, index),
                ),
              ),
            ),

          // ── Sticky tab bar ─────────────────────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              tabController: _tabController,
              labels: tabLabels,
              onTap: (index) => _scrollTo(_sectionKeys[index], index),
            ),
          ),

          // ── Taxonomy ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _taxonomyKey,
              title: l10n.detailTaxonomyTitle,
              leadingIcon: Icons.account_tree_outlined,
              leadingColor: const Color(0xFF7B61FF),
              child: _buildTaxonomyTable(context, pest, locale),
            ),
          ),

          // ── Aperçu / Overview ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _descriptionKey,
              title: l10n.detailTabOverview,
              leadingIcon: Icons.info_outline,
              leadingColor: AppTheme.primaryColor,
              child: Text(
                pest.getDescription(locale),
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
            ),
          ),

          // ── Cycle de vie ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: pest.getLifecycle(locale).isNotEmpty
                ? _buildSectionCard(
                    context,
                    keyRef: _lifecycleKey,
                    title: l10n.detailLifecycleTitle,
                    leadingIcon: Icons.autorenew_rounded,
                    leadingColor: const Color(0xFF00897B),
                    child: _LifecycleTimeline(text: pest.getLifecycle(locale)),
                  )
                : SizedBox(key: _lifecycleKey),
          ),

          // ── Symptoms ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _symptomsKey,
              title: l10n.detailTabSymptoms,
              leadingIcon: Icons.search_outlined,
              leadingColor: AppTheme.dangerMedium,
              child: _buildBulletList(context, pest.getSymptoms(locale)),
            ),
          ),

          // ── Damage ─────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _damageKey,
              title: l10n.detailTabDamage,
              leadingIcon: Icons.warning_amber_outlined,
              leadingColor: AppTheme.dangerHigh,
              child: Text(
                pest.getDamage(locale),
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
            ),
          ),

          // ── Prevention ─────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _preventionKey,
              title: l10n.detailPrevention,
              leadingIcon: Icons.shield_outlined,
              leadingColor: AppTheme.primaryColor,
              child: Text(
                pest.getPrevention(locale),
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
            ),
          ),

          // ── Lutte mécanique ────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: pest.getMechanicalControl(locale).isNotEmpty
                ? _buildSectionCard(
                    context,
                    keyRef: _mechanicalKey,
                    title: l10n.detailMechanicalTitle,
                    leadingWidget: ImageIcon(
                      const AssetImage(
                          'assets/icons/ic_lutte_mecanique.png'),
                      color: const Color(0xFF6D4C41),
                      size: 22,
                    ),
                    child: Text(
                      pest.getMechanicalControl(locale),
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                  )
                : SizedBox(key: _mechanicalKey),
          ),

          // ── Biological treatment ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _biologicalKey,
              title: l10n.detailBiological,
              leadingIcon: Icons.eco_outlined,
              leadingColor: AppTheme.dangerLow,
              child: Text(
                pest.getBiologicalTreatment(locale),
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
            ),
          ),

          // ── Chemical treatment ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              keyRef: _chemicalKey,
              title: l10n.detailChemical,
              leadingIcon: Icons.science_outlined,
              leadingColor: AppTheme.dangerHigh,
              child: Text(
                pest.getChemicalTreatment(locale),
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildTaxonomyTable(BuildContext context, Pest pest, String locale) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final rows = <_TaxoRow>[
      _TaxoRow(label: l10n.detailTaxonomyOrder, value: pest.order),
      _TaxoRow(label: l10n.detailTaxonomyFamily, value: pest.family),
      _TaxoRow(label: l10n.detailTaxonomySpecies, value: pest.scientificName, italic: true),
    ];

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  row.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.appMutedColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  row.value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle:
                        row.italic ? FontStyle.italic : FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required GlobalKey keyRef,
    required String title,
    required Widget child,
    IconData? leadingIcon,
    Color? leadingColor,
    Widget? leadingWidget,
  }) {
    final theme = Theme.of(context);
    return Container(
      key: keyRef,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: context.appCardGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.appStrokeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (leadingWidget != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: leadingWidget,
                )
              else if (leadingIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    leadingIcon,
                    color: leadingColor ?? AppTheme.primaryColor,
                    size: 22,
                  ),
                ),
              Text(
                title,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildBulletList(BuildContext context, List<String> items) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child:
                    Icon(Icons.circle, size: 6, color: AppTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── Data classes ───────────────────────────────────────────────────────────────

class _TaxoRow {
  final String label;
  final String value;
  final bool italic;
  const _TaxoRow({required this.label, required this.value, this.italic = false});
}

class _StageItem {
  final String name;
  final String description;
  const _StageItem({required this.name, required this.description});
}

// ── Lifecycle timeline widget ──────────────────────────────────────────────────

class _LifecycleTimeline extends StatelessWidget {
  final String text;

  const _LifecycleTimeline({required this.text});

  static const _stageColors = [
    Color(0xFFFF8F00), // amber — egg
    Color(0xFF2E7D32), // green — larva
    Color(0xFF00695C), // teal — pupa/nymph
    AppTheme.primaryColor, // primary — adult
    Color(0xFF6A1B9A), // purple — extra stage
    Color(0xFF1565C0), // blue — extra stage
  ];

  static const _stageIcons = ['🥚', '🐛', '🫘', '🦋', '🔄', '🌿'];

  List<_StageItem> _parseStages() {
    final stages = <_StageItem>[];
    for (final line in text.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.startsWith('●')) {
        final content = trimmed.replaceFirst('●', '').trim();
        final colonIdx = content.indexOf(' : ');
        if (colonIdx != -1) {
          stages.add(_StageItem(
            name: content.substring(0, colonIdx).trim(),
            description: content.substring(colonIdx + 3).trim(),
          ));
        } else {
          stages.add(_StageItem(name: content, description: ''));
        }
      }
    }
    return stages;
  }

  String? _parseDurationNote() {
    final lines = text.split('\n');
    for (var i = lines.length - 1; i >= 0; i--) {
      final t = lines[i].trim();
      if (t.isNotEmpty && !t.startsWith('●')) return t;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stages = _parseStages();
    final duration = _parseDurationNote();

    if (stages.isEmpty) {
      return Text(text, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(stages.length, (i) {
          final stage = stages[i];
          final color = _stageColors[i % _stageColors.length];
          final emoji = _stageIcons[i % _stageIcons.length];
          final isLast = i == stages.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline spine
                SizedBox(
                  width: 40,
                  child: Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                          border: Border.all(color: color, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(emoji,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin:
                                const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Stage content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: isLast ? 0 : 20, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.name,
                          style:
                              theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                        if (stage.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            stage.description,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(height: 1.5),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        if (duration != null) ...[
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00897B).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color(0xFF00897B).withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined,
                    size: 16, color: Color(0xFF00897B)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    duration,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF00897B),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ── Full-screen image viewer (swipeable) ──────────────────────────────────────

class _FullscreenViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const _FullscreenViewer({required this.images, required this.initialIndex});

  @override
  State<_FullscreenViewer> createState() => _FullscreenViewerState();
}

class _FullscreenViewerState extends State<_FullscreenViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, i) => InteractiveViewer(
              minScale: 0.5,
              maxScale: 5.0,
              child: Image.asset(
                widget.images[i],
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Center(
                  child: Icon(Icons.broken_image_outlined,
                      color: Colors.white, size: 64),
                ),
              ),
            ),
          ),
          // Close + counter overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Material(
                    color: Colors.black54,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.images.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
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

// ── Taxon chip ─────────────────────────────────────────────────────────────────

class _TaxonChip extends StatelessWidget {
  final String label;
  final String value;
  const _TaxonChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF7B61FF).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color(0xFF7B61FF).withValues(alpha: 0.25)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.appMutedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: value,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF7B61FF),
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Photo gallery ──────────────────────────────────────────────────────────────

class _PhotoGallery extends StatelessWidget {
  final List<String> images;
  final String locale;
  final ValueChanged<int> onTap;

  const _PhotoGallery({
    required this.images,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final label = l10n.detailPhotoGallery;

    // Skip index 0 — it's already shown as the main hero image.
    final galleryImages = images.length > 1 ? images.sublist(1) : <String>[];
    if (galleryImages.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.photo_library_outlined,
                size: 18, color: AppTheme.primaryColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${images.length}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.appMutedColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: galleryImages.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final assetPath = galleryImages[i];
              // +1 because gallery skips index 0 (main image)
              final fullscreenIndex = i + 1;
              return GestureDetector(
                onTap: () => onTap(fullscreenIndex),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 110,
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.cover,
                      cacheWidth: 330,
                      errorBuilder: (_, _, _) => Container(
                        color: AppTheme.secondaryColor,
                        child: const Center(
                          child: Icon(Icons.broken_image_outlined,
                              color: AppTheme.primaryColor, size: 28),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── Sticky tab bar ─────────────────────────────────────────────────────────────

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final List<String> labels;
  final ValueChanged<int> onTap;

  const _StickyTabBarDelegate({
    required this.tabController,
    required this.labels,
    required this.onTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Container(
      color: context.appBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: AppTheme.primaryColor,
        unselectedLabelColor: context.appMutedColor,
        indicatorColor: AppTheme.primaryColor,
        indicatorWeight: 3.0,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: context.appStrokeColor,
        labelStyle: theme.textTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: theme.textTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600),
        onTap: onTap,
        tabs: labels.map((l) => Tab(text: l)).toList(),
      ),
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return oldDelegate.tabController != tabController ||
        oldDelegate.labels != labels;
  }
}
