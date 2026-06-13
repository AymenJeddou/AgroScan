import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'AgroScan'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get navDashboard;

  /// No description provided for @navLibrary.
  ///
  /// In fr, this message translates to:
  /// **'Bibliothèque'**
  String get navLibrary;

  /// No description provided for @navScan.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get navScan;

  /// No description provided for @navHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get navHistory;

  /// No description provided for @dashboardWelcome.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour, Agriculteur'**
  String get dashboardWelcome;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Protégez vos cultures aujourd\'hui'**
  String get dashboardSubtitle;

  /// No description provided for @dashboardStats.
  ///
  /// In fr, this message translates to:
  /// **'Statistiques des cultures'**
  String get dashboardStats;

  /// No description provided for @dashboardTotalScans.
  ///
  /// In fr, this message translates to:
  /// **'Analyses totales'**
  String get dashboardTotalScans;

  /// No description provided for @dashboardHealthy.
  ///
  /// In fr, this message translates to:
  /// **'Sain'**
  String get dashboardHealthy;

  /// No description provided for @dashboardInfested.
  ///
  /// In fr, this message translates to:
  /// **'Infecté'**
  String get dashboardInfested;

  /// No description provided for @dashboardQuickActions.
  ///
  /// In fr, this message translates to:
  /// **'Actions rapides'**
  String get dashboardQuickActions;

  /// No description provided for @dashboardStartScan.
  ///
  /// In fr, this message translates to:
  /// **'Lancer une analyse'**
  String get dashboardStartScan;

  /// No description provided for @dashboardBrowseLibrary.
  ///
  /// In fr, this message translates to:
  /// **'Parcourir la bibliothèque'**
  String get dashboardBrowseLibrary;

  /// No description provided for @dashboardFarmingTip.
  ///
  /// In fr, this message translates to:
  /// **'Conseil du jour : Vérifiez sous les feuilles de tomates pour repérer les premiers signes d\'aleurodes.'**
  String get dashboardFarmingTip;

  /// No description provided for @librarySearchPlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un ravageur...'**
  String get librarySearchPlaceholder;

  /// No description provided for @libraryCropFilterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get libraryCropFilterAll;

  /// No description provided for @libraryCropFilterTomato.
  ///
  /// In fr, this message translates to:
  /// **'Tomates'**
  String get libraryCropFilterTomato;

  /// No description provided for @libraryCropFilterPepper.
  ///
  /// In fr, this message translates to:
  /// **'Poivrons'**
  String get libraryCropFilterPepper;

  /// No description provided for @libraryDanger.
  ///
  /// In fr, this message translates to:
  /// **'Danger'**
  String get libraryDanger;

  /// No description provided for @libraryDangerLow.
  ///
  /// In fr, this message translates to:
  /// **'Faible'**
  String get libraryDangerLow;

  /// No description provided for @libraryDangerMedium.
  ///
  /// In fr, this message translates to:
  /// **'Moyen'**
  String get libraryDangerMedium;

  /// No description provided for @libraryDangerHigh.
  ///
  /// In fr, this message translates to:
  /// **'Élevé'**
  String get libraryDangerHigh;

  /// No description provided for @libraryScientificName.
  ///
  /// In fr, this message translates to:
  /// **'Nom scientifique'**
  String get libraryScientificName;

  /// No description provided for @libraryAffectedCrops.
  ///
  /// In fr, this message translates to:
  /// **'Cultures affectées'**
  String get libraryAffectedCrops;

  /// No description provided for @detailTabOverview.
  ///
  /// In fr, this message translates to:
  /// **'Aperçu'**
  String get detailTabOverview;

  /// No description provided for @detailTabSymptoms.
  ///
  /// In fr, this message translates to:
  /// **'Symptômes'**
  String get detailTabSymptoms;

  /// No description provided for @detailTabDamage.
  ///
  /// In fr, this message translates to:
  /// **'Dégâts'**
  String get detailTabDamage;

  /// No description provided for @detailTabTreatments.
  ///
  /// In fr, this message translates to:
  /// **'Traitements'**
  String get detailTabTreatments;

  /// No description provided for @detailPrevention.
  ///
  /// In fr, this message translates to:
  /// **'Prévention'**
  String get detailPrevention;

  /// No description provided for @detailBiological.
  ///
  /// In fr, this message translates to:
  /// **'Traitement Biologique'**
  String get detailBiological;

  /// No description provided for @detailChemical.
  ///
  /// In fr, this message translates to:
  /// **'Traitement Chimique'**
  String get detailChemical;

  /// No description provided for @scanTitle.
  ///
  /// In fr, this message translates to:
  /// **'Détection de Ravageurs'**
  String get scanTitle;

  /// No description provided for @scanPrompt.
  ///
  /// In fr, this message translates to:
  /// **'Cadrez l\'insecte ou la feuille affectée'**
  String get scanPrompt;

  /// No description provided for @scanSelectGallery.
  ///
  /// In fr, this message translates to:
  /// **'Importer depuis la galerie'**
  String get scanSelectGallery;

  /// No description provided for @scanCapture.
  ///
  /// In fr, this message translates to:
  /// **'Prendre une photo'**
  String get scanCapture;

  /// No description provided for @scanAnalyzing.
  ///
  /// In fr, this message translates to:
  /// **'Analyse en cours par l\'IA...'**
  String get scanAnalyzing;

  /// No description provided for @scanResultHealthy.
  ///
  /// In fr, this message translates to:
  /// **'Plante saine !'**
  String get scanResultHealthy;

  /// No description provided for @scanResultPestDetected.
  ///
  /// In fr, this message translates to:
  /// **'Ravageur détecté !'**
  String get scanResultPestDetected;

  /// No description provided for @scanConfidence.
  ///
  /// In fr, this message translates to:
  /// **'Confiance'**
  String get scanConfidence;

  /// No description provided for @scanSave.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer dans l\'historique'**
  String get scanSave;

  /// No description provided for @scanCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get scanCancel;

  /// No description provided for @scanCropTypePrompt.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez le type de culture'**
  String get scanCropTypePrompt;

  /// No description provided for @historyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Historique des Analyses'**
  String get historyTitle;

  /// No description provided for @historyNoScans.
  ///
  /// In fr, this message translates to:
  /// **'Aucune analyse enregistrée.'**
  String get historyNoScans;

  /// No description provided for @historySyncSynced.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisé'**
  String get historySyncSynced;

  /// No description provided for @historySyncPending.
  ///
  /// In fr, this message translates to:
  /// **'En attente de connexion'**
  String get historySyncPending;

  /// No description provided for @historySyncTrigger.
  ///
  /// In fr, this message translates to:
  /// **'Synchroniser maintenant'**
  String get historySyncTrigger;

  /// No description provided for @historyLocalPath.
  ///
  /// In fr, this message translates to:
  /// **'Fichier local'**
  String get historyLocalPath;

  /// No description provided for @historyDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de l\'analyse'**
  String get historyDate;

  /// No description provided for @historyUnsyncedBanner.
  ///
  /// In fr, this message translates to:
  /// **'Historique non synchronisé'**
  String get historyUnsyncedBanner;

  /// No description provided for @historyScanRemovedSnackbar.
  ///
  /// In fr, this message translates to:
  /// **'Analyse supprimée de l\'historique'**
  String get historyScanRemovedSnackbar;

  /// No description provided for @scanDetailsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Détails de l\'analyse'**
  String get scanDetailsTitle;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @scanTopPredictions.
  ///
  /// In fr, this message translates to:
  /// **'Top prédictions'**
  String get scanTopPredictions;

  /// No description provided for @scanInferenceFailed.
  ///
  /// In fr, this message translates to:
  /// **'Détection échouée'**
  String get scanInferenceFailed;

  /// No description provided for @scanUnknownError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur inconnue est survenue.'**
  String get scanUnknownError;

  /// No description provided for @scanRetry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get scanRetry;

  /// No description provided for @scanAskAgriBot.
  ///
  /// In fr, this message translates to:
  /// **'Demander à AgriBot'**
  String get scanAskAgriBot;

  /// No description provided for @scanAskAgriBotSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Traitement, conseils & prévention'**
  String get scanAskAgriBotSubtitle;

  /// No description provided for @scanNewScan.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle analyse'**
  String get scanNewScan;

  /// No description provided for @scanViewPestDetails.
  ///
  /// In fr, this message translates to:
  /// **'Consulter la fiche ravageur'**
  String get scanViewPestDetails;

  /// No description provided for @dashboardAgriBot.
  ///
  /// In fr, this message translates to:
  /// **'AgriBot — Expert ravageurs'**
  String get dashboardAgriBot;

  /// No description provided for @dashboardAgriBotSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Posez toutes vos questions sur les ravageurs'**
  String get dashboardAgriBotSubtitle;

  /// No description provided for @libraryCropFilterOlive.
  ///
  /// In fr, this message translates to:
  /// **'Olivier'**
  String get libraryCropFilterOlive;

  /// No description provided for @libraryCropFilterCereal.
  ///
  /// In fr, this message translates to:
  /// **'Céréales'**
  String get libraryCropFilterCereal;

  /// No description provided for @libraryCropFilterVine.
  ///
  /// In fr, this message translates to:
  /// **'Vigne'**
  String get libraryCropFilterVine;

  /// No description provided for @libraryCropFilterCitrus.
  ///
  /// In fr, this message translates to:
  /// **'Agrumes'**
  String get libraryCropFilterCitrus;

  /// No description provided for @darkModeToggle.
  ///
  /// In fr, this message translates to:
  /// **'Mode sombre'**
  String get darkModeToggle;

  /// No description provided for @dashboardTip1.
  ///
  /// In fr, this message translates to:
  /// **'Vérifiez sous les feuilles de tomates pour repérer les premiers signes d\'aleurodes.'**
  String get dashboardTip1;

  /// No description provided for @dashboardTip2.
  ///
  /// In fr, this message translates to:
  /// **'La rotation des cultures réduit la pression des ravageurs de 40 % en moyenne.'**
  String get dashboardTip2;

  /// No description provided for @dashboardTip3.
  ///
  /// In fr, this message translates to:
  /// **'Installez des pièges à phéromones dès le début de la saison pour surveiller les mineuses.'**
  String get dashboardTip3;

  /// No description provided for @dashboardTip4.
  ///
  /// In fr, this message translates to:
  /// **'Arrosez tôt le matin pour réduire l\'humidité foliaire et limiter les maladies fongiques.'**
  String get dashboardTip4;

  /// No description provided for @dashboardTip5.
  ///
  /// In fr, this message translates to:
  /// **'Les auxiliaires naturels comme les coccinelles contrôlent les pucerons efficacement.'**
  String get dashboardTip5;

  /// No description provided for @libraryCropFilterPalm.
  ///
  /// In fr, this message translates to:
  /// **'Palmier dattier'**
  String get libraryCropFilterPalm;

  /// No description provided for @libraryCropFilterPommeDeTerre.
  ///
  /// In fr, this message translates to:
  /// **'Pomme de terre'**
  String get libraryCropFilterPommeDeTerre;

  /// No description provided for @libraryCropFilterMaraichage.
  ///
  /// In fr, this message translates to:
  /// **'Maraîchage'**
  String get libraryCropFilterMaraichage;

  /// No description provided for @libraryCropFilterArboriculture.
  ///
  /// In fr, this message translates to:
  /// **'Arboriculture'**
  String get libraryCropFilterArboriculture;

  /// No description provided for @libraryCropFilterPolyphage.
  ///
  /// In fr, this message translates to:
  /// **'Polyphage'**
  String get libraryCropFilterPolyphage;

  /// No description provided for @libraryCropFilterBetterave.
  ///
  /// In fr, this message translates to:
  /// **'Betterave'**
  String get libraryCropFilterBetterave;

  /// No description provided for @libraryCropFilterOignon.
  ///
  /// In fr, this message translates to:
  /// **'Oignon'**
  String get libraryCropFilterOignon;

  /// No description provided for @libraryCropFilterFiguierBarbarie.
  ///
  /// In fr, this message translates to:
  /// **'Figuier de Barbarie'**
  String get libraryCropFilterFiguierBarbarie;

  /// No description provided for @libraryCropFilterOrnement.
  ///
  /// In fr, this message translates to:
  /// **'Ornement'**
  String get libraryCropFilterOrnement;

  /// No description provided for @scanCropTypeGeneral.
  ///
  /// In fr, this message translates to:
  /// **'Général'**
  String get scanCropTypeGeneral;

  /// No description provided for @scanCropTypeUnknown.
  ///
  /// In fr, this message translates to:
  /// **'Je ne sais pas'**
  String get scanCropTypeUnknown;

  /// No description provided for @scanNotRelevantTitle.
  ///
  /// In fr, this message translates to:
  /// **'Image non reconnue'**
  String get scanNotRelevantTitle;

  /// No description provided for @scanNotRelevantMessage.
  ///
  /// In fr, this message translates to:
  /// **'Cette image ne montre pas une plante, une culture ou un ravageur agricole. Veuillez photographier une feuille, un plant ou un insecte.'**
  String get scanNotRelevantMessage;

  /// No description provided for @scanSummaryLabel.
  ///
  /// In fr, this message translates to:
  /// **'Résumé du diagnostic'**
  String get scanSummaryLabel;

  /// No description provided for @scanSelectCropFirst.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez un type de culture pour continuer'**
  String get scanSelectCropFirst;

  /// No description provided for @scanShare.
  ///
  /// In fr, this message translates to:
  /// **'Partager le résultat'**
  String get scanShare;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsAppearance.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get settingsThemeSystem;

  /// No description provided for @settingsVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @libraryFavorites.
  ///
  /// In fr, this message translates to:
  /// **'Favoris'**
  String get libraryFavorites;

  /// No description provided for @libraryNoFavorites.
  ///
  /// In fr, this message translates to:
  /// **'Aucun favori enregistré. Appuyez sur ♥ pour en ajouter.'**
  String get libraryNoFavorites;

  /// No description provided for @historyStatsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aperçu'**
  String get historyStatsTitle;

  /// No description provided for @historyTopPests.
  ///
  /// In fr, this message translates to:
  /// **'Ravageurs fréquents'**
  String get historyTopPests;

  /// No description provided for @settingsLicense.
  ///
  /// In fr, this message translates to:
  /// **'Licence & Mentions légales'**
  String get settingsLicense;

  /// No description provided for @licenseTitle.
  ///
  /// In fr, this message translates to:
  /// **'À propos de l\'application'**
  String get licenseTitle;

  /// No description provided for @licenseCreatedByLabel.
  ///
  /// In fr, this message translates to:
  /// **'Développé par'**
  String get licenseCreatedByLabel;

  /// No description provided for @licenseAuthorName.
  ///
  /// In fr, this message translates to:
  /// **'Moez Harb'**
  String get licenseAuthorName;

  /// No description provided for @licenseContactLabel.
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get licenseContactLabel;

  /// No description provided for @licenseContactEmail.
  ///
  /// In fr, this message translates to:
  /// **'moez.harb25@gmail.com'**
  String get licenseContactEmail;

  /// No description provided for @licenseYear.
  ///
  /// In fr, this message translates to:
  /// **'2026'**
  String get licenseYear;

  /// No description provided for @licenseRights.
  ///
  /// In fr, this message translates to:
  /// **'© 2026 Moez Harb. Tous droits réservés.'**
  String get licenseRights;

  /// No description provided for @licenseDescription.
  ///
  /// In fr, this message translates to:
  /// **'AgroScan est une application mobile de détection de ravageurs agricoles conçue pour aider les agriculteurs d\'Afrique du Nord (Tunisie, Maroc, Algérie) à identifier et combattre 40 ravageurs spécifiques grâce à l\'intelligence artificielle. L\'application analyse des photos de cultures et fournit un diagnostic instantané, des conseils de traitement et un accès à une bibliothèque complète de ravageurs.'**
  String get licenseDescription;

  /// No description provided for @licenseTechTitle.
  ///
  /// In fr, this message translates to:
  /// **'Technologies utilisées'**
  String get licenseTechTitle;

  /// No description provided for @licenseTechUI.
  ///
  /// In fr, this message translates to:
  /// **'Interface : Flutter (Dart)'**
  String get licenseTechUI;

  /// No description provided for @licenseTechAI.
  ///
  /// In fr, this message translates to:
  /// **'Intelligence Artificielle : Google Gemini 2.5 Flash'**
  String get licenseTechAI;

  /// No description provided for @licenseTechDB.
  ///
  /// In fr, this message translates to:
  /// **'Base de données locale : Drift / SQLite'**
  String get licenseTechDB;

  /// No description provided for @licenseTechSync.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisation cloud : Supabase'**
  String get licenseTechSync;

  /// No description provided for @licenseDatasetTitle.
  ///
  /// In fr, this message translates to:
  /// **'Base de données d\'images'**
  String get licenseDatasetTitle;

  /// No description provided for @licenseDatasetDesc.
  ///
  /// In fr, this message translates to:
  /// **'Les images de ravageurs intégrées à l\'application proviennent d\'un dataset scientifique constitué dans le cadre du projet PFE et couvrent 40 espèces ravageuses présentes dans les agrosystèmes nord-africains.'**
  String get licenseDatasetDesc;

  /// No description provided for @licenseOpenSource.
  ///
  /// In fr, this message translates to:
  /// **'Mentions Open Source'**
  String get licenseOpenSource;

  /// No description provided for @licenseOpenSourceDesc.
  ///
  /// In fr, this message translates to:
  /// **'Cette application utilise des bibliothèques open source. Les mentions de licence complètes sont accessibles via le bouton ci-dessous.'**
  String get licenseOpenSourceDesc;

  /// No description provided for @agrandir.
  ///
  /// In fr, this message translates to:
  /// **'Agrandir'**
  String get agrandir;

  /// No description provided for @detailTabTaxonomy.
  ///
  /// In fr, this message translates to:
  /// **'Taxonomie'**
  String get detailTabTaxonomy;

  /// No description provided for @detailTabLifecycle.
  ///
  /// In fr, this message translates to:
  /// **'Cycle de vie'**
  String get detailTabLifecycle;

  /// No description provided for @detailTabMechanical.
  ///
  /// In fr, this message translates to:
  /// **'Lutte méc.'**
  String get detailTabMechanical;

  /// No description provided for @detailTaxonomyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Classification taxonomique'**
  String get detailTaxonomyTitle;

  /// No description provided for @detailLifecycleTitle.
  ///
  /// In fr, this message translates to:
  /// **'Cycle de vie'**
  String get detailLifecycleTitle;

  /// No description provided for @detailMechanicalTitle.
  ///
  /// In fr, this message translates to:
  /// **'Lutte mécanique'**
  String get detailMechanicalTitle;

  /// No description provided for @detailTaxonomyOrder.
  ///
  /// In fr, this message translates to:
  /// **'Ordre'**
  String get detailTaxonomyOrder;

  /// No description provided for @detailTaxonomyFamily.
  ///
  /// In fr, this message translates to:
  /// **'Famille'**
  String get detailTaxonomyFamily;

  /// No description provided for @detailTaxonomySpecies.
  ///
  /// In fr, this message translates to:
  /// **'Espèce'**
  String get detailTaxonomySpecies;

  /// No description provided for @detailPhotoGallery.
  ///
  /// In fr, this message translates to:
  /// **'Galerie photos'**
  String get detailPhotoGallery;

  /// No description provided for @detailDangerLow.
  ///
  /// In fr, this message translates to:
  /// **'Danger: Faible'**
  String get detailDangerLow;

  /// No description provided for @detailDangerMedium.
  ///
  /// In fr, this message translates to:
  /// **'Danger: Moyen'**
  String get detailDangerMedium;

  /// No description provided for @detailDangerHigh.
  ///
  /// In fr, this message translates to:
  /// **'Danger: Élevé'**
  String get detailDangerHigh;

  /// No description provided for @dashboardPestSectionTitle.
  ///
  /// In fr, this message translates to:
  /// **'Les ravageurs de culture'**
  String get dashboardPestSectionTitle;

  /// No description provided for @dashboardPestCategoriesSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'6 familles de ravageurs décrites'**
  String get dashboardPestCategoriesSubtitle;

  /// No description provided for @pestCategoriesIntro.
  ///
  /// In fr, this message translates to:
  /// **'Les ravageurs des cultures sont des organismes nuisibles qui se nourrissent des plantes cultivées et causent des dommages à différents stades de leur développement. Ils peuvent attaquer diverses parties de la plante : feuilles, tiges, racines, fleurs et fruits. Ces ravageurs présentent une grande diversité biologique et appartiennent à plusieurs ordres — Lépidoptères, Diptères, Coléoptères, Hémiptères et Thysanoptères — auxquels s\'ajoutent des acariens phytophages, qui ne sont pas des insectes au sens strict. Leur capacité d\'adaptation, leur cycle de vie court et leur forte fécondité favorisent leur prolifération dans les agroécosystèmes.\n\nL\'agroécosystème tunisien, marqué par une transition bioclimatique allant du subhumide au nord à l\'aride au sud, abrite une entomofaune nuisible qui illustre parfaitement cette complexité taxonomique. On y distingue plusieurs groupes spécialisés :'**
  String get pestCategoriesIntro;

  /// No description provided for @dashboardCatLepidopteraName.
  ///
  /// In fr, this message translates to:
  /// **'Lépidoptères — chenilles & mineuses'**
  String get dashboardCatLepidopteraName;

  /// No description provided for @dashboardCatLepidopteraDesc.
  ///
  /// In fr, this message translates to:
  /// **'Parmi les ravageurs les plus destructeurs des cultures méditerranéennes. Tuta absoluta, Spodoptera, Helicoverpa et Lobesia causent des galeries dans les feuilles et les fruits.'**
  String get dashboardCatLepidopteraDesc;

  /// No description provided for @dashboardCatDipteraName.
  ///
  /// In fr, this message translates to:
  /// **'Diptères — mouches & mineuses'**
  String get dashboardCatDipteraName;

  /// No description provided for @dashboardCatDipteraDesc.
  ///
  /// In fr, this message translates to:
  /// **'Bactrocera oleae, Ceratitis capitata, Mayetiola destructor et les mineuses Liriomyza développent leurs larves à l\'intérieur des organes végétaux, rendant la lutte chimique difficile.'**
  String get dashboardCatDipteraDesc;

  /// No description provided for @dashboardCatHemipteraName.
  ///
  /// In fr, this message translates to:
  /// **'Hémiptères — pucerons & cochenilles'**
  String get dashboardCatHemipteraName;

  /// No description provided for @dashboardCatHemipteraDesc.
  ///
  /// In fr, this message translates to:
  /// **'Pucerons (Myzus persicae, Aphis gossypii), aleurodes (Bemisia tabaci) et cochenilles (Saissetia oleae) affaiblissent les plantes par ponction de sève et transmettent des virus phytopathogènes.'**
  String get dashboardCatHemipteraDesc;

  /// No description provided for @dashboardCatColeopteraName.
  ///
  /// In fr, this message translates to:
  /// **'Coléoptères — charançons & scolytes'**
  String get dashboardCatColeopteraName;

  /// No description provided for @dashboardCatColeopteraDesc.
  ///
  /// In fr, this message translates to:
  /// **'Rhynchophorus ferrugineus, Phloeotribus scarabaeoides et Scolytus amygdali creusent des galeries profondes et difficilement détectables à l\'intérieur des tissus végétaux.'**
  String get dashboardCatColeopteraDesc;

  /// No description provided for @dashboardCatThysanopteraName.
  ///
  /// In fr, this message translates to:
  /// **'Thysanoptères — thrips'**
  String get dashboardCatThysanopteraName;

  /// No description provided for @dashboardCatThysanopteraDesc.
  ///
  /// In fr, this message translates to:
  /// **'Thrips tabaci, Frankliniella occidentalis et Pezothrips kellyanus lacèrent les tissus végétaux causant des déformations. Vecteurs de Tospovirus, ce qui aggrave considérablement leur nuisibilité.'**
  String get dashboardCatThysanopteraDesc;

  /// No description provided for @dashboardCatAcariName.
  ///
  /// In fr, this message translates to:
  /// **'Acariens — tétranyques'**
  String get dashboardCatAcariName;

  /// No description provided for @dashboardCatAcariDesc.
  ///
  /// In fr, this message translates to:
  /// **'Bien qu\'arachnides et non insectes, Tetranychus urticae attaque plus de 1 100 espèces végétales et développe rapidement des résistances aux acaricides sous climat chaud et sec.'**
  String get dashboardCatAcariDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
