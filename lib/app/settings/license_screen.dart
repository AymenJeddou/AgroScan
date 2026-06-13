import 'package:flutter/material.dart';
import 'package:agroscan/app/localization/l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.licenseTitle),
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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 48),
            children: [
              // ── App identity card ─────────────────────────────────────────
              _LicenseCard(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.25),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.eco_rounded,
                        color: AppTheme.primaryColor,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'AgroScan',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${l10n.settingsVersion} 1.0.0  •  ${l10n.licenseYear}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.appMutedColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _InfoRow(
                      icon: Icons.person_outline_rounded,
                      label: l10n.licenseCreatedByLabel,
                      value: l10n.licenseAuthorName,
                      valueStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.mail_outline_rounded,
                      label: l10n.licenseContactLabel,
                      value: l10n.licenseContactEmail,
                      valueStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Description ───────────────────────────────────────────────
              _LicenseSection(
                icon: Icons.info_outline_rounded,
                iconColor: AppTheme.primaryColor,
                title: isAr ? 'وصف التطبيق' : (Localizations.localeOf(context).languageCode == 'fr' ? 'Description' : 'Description'),
                child: Text(
                  l10n.licenseDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: context.appTextColor,
                  ),
                  textAlign: isAr ? TextAlign.right : TextAlign.left,
                ),
              ),
              const SizedBox(height: 12),

              // ── Technologies ──────────────────────────────────────────────
              _LicenseSection(
                icon: Icons.code_rounded,
                iconColor: const Color(0xFF7B61FF),
                title: l10n.licenseTechTitle,
                child: Column(
                  crossAxisAlignment: isAr
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _TechItem(icon: Icons.phone_android_rounded,
                        color: const Color(0xFF54C5F8), label: l10n.licenseTechUI),
                    _TechItem(icon: Icons.auto_awesome_rounded,
                        color: const Color(0xFF4285F4), label: l10n.licenseTechAI),
                    _TechItem(icon: Icons.storage_rounded,
                        color: const Color(0xFF34A853), label: l10n.licenseTechDB),
                    _TechItem(icon: Icons.cloud_sync_outlined,
                        color: const Color(0xFF3ECF8E), label: l10n.licenseTechSync),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Dataset ───────────────────────────────────────────────────
              _LicenseSection(
                icon: Icons.photo_library_outlined,
                iconColor: const Color(0xFFFF8F00),
                title: l10n.licenseDatasetTitle,
                child: Text(
                  l10n.licenseDatasetDesc,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: context.appTextColor,
                  ),
                  textAlign: isAr ? TextAlign.right : TextAlign.left,
                ),
              ),
              const SizedBox(height: 12),

              // ── Open source notices ───────────────────────────────────────
              _LicenseSection(
                icon: Icons.balance_outlined,
                iconColor: const Color(0xFF00897B),
                title: l10n.licenseOpenSource,
                child: Column(
                  crossAxisAlignment: isAr
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.licenseOpenSourceDesc,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: context.appTextColor,
                      ),
                      textAlign: isAr ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => showLicensePage(
                          context: context,
                          applicationName: 'AgroScan',
                          applicationVersion: '1.0.0',
                          applicationIcon: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.eco_rounded,
                                color: AppTheme.primaryColor, size: 40),
                          ),
                        ),
                        icon: const Icon(Icons.open_in_new_rounded, size: 18),
                        label: Text(
                          isAr
                              ? 'عرض تراخيص المكتبات'
                              : (Localizations.localeOf(context).languageCode == 'fr'
                                  ? 'Voir les licences des bibliothèques'
                                  : 'View library licenses'),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: BorderSide(
                            color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Rights footer ─────────────────────────────────────────────
              Center(
                child: Text(
                  l10n.licenseRights,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.appMutedColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────

class _LicenseCard extends StatelessWidget {
  final Widget child;
  const _LicenseCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: context.appCardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.appStrokeColor),
      ),
      child: child,
    );
  }
}

class _LicenseSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  const _LicenseSection({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appStrokeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: context.appMutedColor),
        const SizedBox(width: 8),
        Text(
          '$label : ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: context.appMutedColor,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: valueStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

class _TechItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _TechItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.appTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
