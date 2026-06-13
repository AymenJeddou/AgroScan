import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/design_system/app_button.dart';
import '../../../../core/design_system/crop_badge.dart';
import '../../../../core/providers.dart';
import '../controllers/scan_controller.dart';
import '../../../../features/library/presentation/views/pest_detail_screen.dart';
import '../../../../core/design_system/animated_entry.dart';
import '../../../../app/navigation/app_shell.dart';
import '../../../../features/chatbot/presentation/controllers/chatbot_controller.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanAnimationController;
  late Animation<double> _scanLinePosition;

  @override
  void initState() {
    super.initState();
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scanLinePosition = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(scanControllerProvider);
    final controller = ref.read(scanControllerProvider.notifier);

    if (state.status == ScanUIStatus.analyzing) {
      _scanAnimationController.repeat(reverse: true);
    } else {
      _scanAnimationController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: state.status != ScanUIStatus.idle
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => controller.reset(),
              )
            : null,
        actions: [
          if (state.status == ScanUIStatus.completed &&
              state.result != null &&
              state.result!.isRelevantImage &&
              state.image != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              tooltip: l10n.scanShare,
              onPressed: () => _shareResult(state, l10n),
            ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: context.appHeroGradient),
            ),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor
                    .withValues(alpha: context.isDark ? 0.10 : 0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Builder(
            builder: (context) {
              switch (state.status) {
                case ScanUIStatus.idle:
                  return _buildIdleState(context, controller, l10n, state);
                case ScanUIStatus.capturing:
                case ScanUIStatus.analyzing:
                  return _buildScanningState(context, state, l10n);
                case ScanUIStatus.completed:
                  final result = state.result;
                  if (result != null && !result.isRelevantImage) {
                    return _buildNotRelevantState(
                        context, controller, l10n, state);
                  }
                  return _buildCompletedState(
                      context, state, controller, l10n);
                case ScanUIStatus.error:
                  return _buildErrorState(context, state, controller, l10n);
              }
            },
          ),
        ],
      ),
    );
  }

  // ── Share ──────────────────────────────────────────────────────────────

  Future<void> _shareResult(ScanState state, AppLocalizations l10n) async {
    final result = state.result!;
    final sb = StringBuffer()
      ..writeln('🌿 AgroScan')
      ..writeln()
      ..writeln('Culture : ${result.cropType}')
      ..writeln(
          'Résultat : ${result.isHealthy ? "Plante saine ✅" : "Ravageur détecté ⚠️"}');
    if (!result.isHealthy && result.pestName != null) {
      sb.writeln('Ravageur : ${result.pestName}');
    }
    if (result.summary != null && result.summary!.isNotEmpty) {
      sb
        ..writeln()
        ..writeln(result.summary);
    }
    sb
      ..writeln()
      ..writeln(
          'Confiance : ${(result.confidenceScore * 100).toStringAsFixed(0)}%');

    await Share.shareXFiles(
      [XFile(state.image!.path)],
      text: sb.toString(),
    );
  }

  // ── Idle state ─────────────────────────────────────────────────────────

  Widget _buildIdleState(
    BuildContext context,
    ScanController controller,
    AppLocalizations l10n,
    ScanState state,
  ) {
    final theme = Theme.of(context);
    final cropSelected = state.cropType.isNotEmpty;

    final crops = [
      _CropOption('olivier', '🫒', l10n.libraryCropFilterOlive),
      _CropOption('agrumes', '🍊', l10n.libraryCropFilterCitrus),
      _CropOption('tomate', '🍅', l10n.libraryCropFilterTomato),
      _CropOption('pomme_de_terre', '🥔', l10n.libraryCropFilterPommeDeTerre),
      _CropOption('cereales', '🌾', l10n.libraryCropFilterCereal),
      _CropOption('palmier', '🌴', l10n.libraryCropFilterPalm),
      _CropOption('vigne', '🍇', l10n.libraryCropFilterVine),
      _CropOption('maraichage', '🥬', l10n.libraryCropFilterMaraichage),
      _CropOption('arboriculture', '🍎', l10n.libraryCropFilterArboriculture),
      _CropOption('betterave', '🫜', l10n.libraryCropFilterBetterave),
      _CropOption('oignon', '🧅', l10n.libraryCropFilterOignon),
      _CropOption('figuier_de_barbarie', '🌵', l10n.libraryCropFilterFiguierBarbarie),
      _CropOption('ornement', '🌸', l10n.libraryCropFilterOrnement),
      _CropOption('polyphage', '🌍', l10n.libraryCropFilterPolyphage),
      _CropOption('unknown', '❓', l10n.scanCropTypeUnknown),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon circle
          RevealOnLoad(
            delay: const Duration(milliseconds: 80),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.appSecondaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.18),
                  ),
                ),
                child: const Icon(
                  Icons.center_focus_weak_rounded,
                  size: 80,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title + prompt
          RevealOnLoad(
            delay: const Duration(milliseconds: 140),
            child: Column(
              children: [
                Text(
                  l10n.scanTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: context.appTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.scanPrompt,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.appMutedColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Crop selector
          RevealOnLoad(
            delay: const Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.scanCropTypePrompt,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.appTextColor,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: crops.map((crop) {
                      final isSelected = state.cropType == crop.key;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _CropPill(
                          emoji: crop.emoji,
                          label: crop.label,
                          isSelected: isSelected,
                          onTap: () => controller.setCropType(crop.key),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (!cropSelected)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 14, color: AppTheme.accentColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            l10n.scanSelectCropFirst,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppTheme.accentColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Camera button
          RevealOnLoad(
            delay: const Duration(milliseconds: 280),
            child: AppButton(
              text: l10n.scanCapture,
              icon: Icons.camera_alt_rounded,
              onPressed: cropSelected
                  ? () => controller.pickImage(ImageSource.camera)
                  : null,
            ),
          ),
          const SizedBox(height: 12),

          // Gallery button
          RevealOnLoad(
            delay: const Duration(milliseconds: 320),
            child: AppButton(
              text: l10n.scanSelectGallery,
              icon: Icons.image_outlined,
              isSecondary: true,
              onPressed: cropSelected
                  ? () => controller.pickImage(ImageSource.gallery)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // ── Scanning state ─────────────────────────────────────────────────────

  Widget _buildScanningState(
    BuildContext context,
    ScanState state,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (state.image != null)
                    Image.file(state.image!, fit: BoxFit.contain)
                  else
                    Container(color: context.appSecondaryColor),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppTheme.primaryColor.withValues(alpha: 0.10),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  if (state.status == ScanUIStatus.analyzing)
                    AnimatedBuilder(
                      animation: _scanAnimationController,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment(
                            0,
                            (_scanLinePosition.value * 2) - 1,
                          ),
                          child: Container(
                            height: 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor
                                      .withValues(alpha: 0.8),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.scanAnalyzing,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── Not-relevant state ─────────────────────────────────────────────────

  Widget _buildNotRelevantState(
    BuildContext context,
    ScanController controller,
    AppLocalizations l10n,
    ScanState state,
  ) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state.image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 280),
                child: Image.file(
                  state.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.image_not_supported_rounded,
                size: 52,
                color: Color(0xFFE65100),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.scanNotRelevantTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE65100),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.scanNotRelevantMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.appMutedColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          AppButton(
            text: l10n.scanNewScan,
            onPressed: () => controller.reset(),
          ),
        ],
      ),
    );
  }

  // ── Completed state ────────────────────────────────────────────────────

  Widget _buildCompletedState(
    BuildContext context,
    ScanState state,
    ScanController controller,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final result = state.result!;
    final isHealthy = result.isHealthy;
    final topGuesses = result.topGuesses;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Scanned image thumbnail ──────────────────────────────────
          if (state.image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 280),
                child: Image.file(
                  state.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── Status icon + title ──────────────────────────────────────
          Center(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isHealthy
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isHealthy ? Icons.check_circle_rounded : Icons.warning_rounded,
                size: 52,
                color: isHealthy ? AppTheme.dangerLow : AppTheme.dangerHigh,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isHealthy ? l10n.scanResultHealthy : l10n.scanResultPestDetected,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isHealthy ? AppTheme.dangerLow : AppTheme.dangerHigh,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Center(child: CropBadge(cropType: result.cropType)),
          const SizedBox(height: 20),

          // ── AI Summary ───────────────────────────────────────────────
          if (result.summary != null && result.summary!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.appCardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.appStrokeColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.summarize_rounded,
                          size: 17, color: AppTheme.primaryColor),
                      const SizedBox(width: 6),
                      Text(
                        l10n.scanSummaryLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result.summary!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.appTextColor,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── Top predictions ──────────────────────────────────────────
          if (topGuesses.isNotEmpty) ...[
            Row(
              children: [
                const Icon(Icons.bar_chart_rounded,
                    size: 18, color: AppTheme.primaryColor),
                const SizedBox(width: 6),
                Text(
                  l10n.scanTopPredictions,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...topGuesses.asMap().entries.map((entry) {
              final i = entry.key;
              final guess = entry.value;
              final pct = (guess.confidenceScore * 100).clamp(0, 100);
              final isTop = i == 0;
              final tappable = guess.pestId != null;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: tappable
                      ? () async {
                          final libraryRepo = ref.read(libraryRepositoryProvider);
                          final pest =
                              await libraryRepo.getPestById(guess.pestId!);
                          if (pest != null && context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PestDetailScreen(pest: pest),
                              ),
                            );
                          }
                        }
                      : null,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: isTop && !isHealthy
                          ? LinearGradient(
                              colors: [
                                AppTheme.primaryColor.withValues(alpha: 0.08),
                                AppTheme.accentColor.withValues(alpha: 0.05),
                              ],
                            )
                          : null,
                      color: isTop && !isHealthy ? null : context.appCardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isTop && !isHealthy
                            ? AppTheme.primaryColor.withValues(alpha: 0.30)
                            : context.appStrokeColor,
                        width: isTop ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: isTop
                                    ? AppTheme.primaryColor
                                    : context.appStrokeColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '#${i + 1}',
                                style: TextStyle(
                                  color: isTop
                                      ? Colors.white
                                      : context.appMutedColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                guess.pestName,
                                style: TextStyle(
                                  fontWeight: isTop
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  fontSize: 13.5,
                                  color: context.appTextColor,
                                ),
                              ),
                            ),
                            if (tappable)
                              Icon(Icons.chevron_right_rounded,
                                  size: 18, color: context.appMutedColor),
                            Text(
                              '${pct.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: isTop
                                    ? AppTheme.primaryColor
                                    : context.appMutedColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: guess.confidenceScore.clamp(0.0, 1.0),
                            backgroundColor:
                                context.appStrokeColor.withValues(alpha: 0.6),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isTop
                                  ? AppTheme.primaryColor
                                  : context.appMutedColor,
                            ),
                            minHeight: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: 16),

          // ── AgriBot follow-up ────────────────────────────────────────
          if (!isHealthy && topGuesses.isNotEmpty) ...[
            GestureDetector(
              onTap: () {
                final top = topGuesses.first;
                ref
                    .read(chatbotControllerProvider.notifier)
                    .startWithScanContext(
                      pestName: top.pestName,
                      cropType: result.cropType,
                      confidence: top.confidenceScore,
                    );
                ref.read(navigationIndexProvider.notifier).state = 3;
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.agriBotColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.agriBotColor.withValues(alpha: 0.30),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.smart_toy_rounded,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.scanAskAgriBot,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          l10n.scanAskAgriBotSubtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.80),
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],


          // ── New scan ─────────────────────────────────────────────────
          AppButton(
            text: l10n.scanNewScan,
            isSecondary: isHealthy,
            onPressed: () => controller.reset(),
          ),
        ],
      ),
    );
  }

  // ── Error state ────────────────────────────────────────────────────────

  Widget _buildErrorState(
    BuildContext context,
    ScanState state,
    ScanController controller,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 64, color: AppTheme.dangerHigh),
          const SizedBox(height: 16),
          Text(
            l10n.scanInferenceFailed,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            state.errorMessage ?? l10n.scanUnknownError,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.appMutedColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          AppButton(
            text: l10n.scanRetry,
            onPressed: () => controller.reset(),
          ),
        ],
      ),
    );
  }
}

// ── Crop option data ───────────────────────────────────────────────────────

class _CropOption {
  final String key;
  final String emoji;
  final String label;
  const _CropOption(this.key, this.emoji, this.label);
}

// ── Crop pill ──────────────────────────────────────────────────────────────

class _CropPill extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CropPill({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primaryColor
                .withValues(alpha: context.isDark ? 0.22 : 0.12)
            : context.appCardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? AppTheme.primaryColor : context.appStrokeColor,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : context.appMutedColor,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
