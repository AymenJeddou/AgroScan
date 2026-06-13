// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AgroScan';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navLibrary => 'Library';

  @override
  String get navScan => 'Scan';

  @override
  String get navHistory => 'History';

  @override
  String get dashboardWelcome => 'Welcome, Farmer';

  @override
  String get dashboardSubtitle => 'Protect your crops today';

  @override
  String get dashboardStats => 'Crop Statistics';

  @override
  String get dashboardTotalScans => 'Total Scans';

  @override
  String get dashboardHealthy => 'Healthy';

  @override
  String get dashboardInfested => 'Infested';

  @override
  String get dashboardQuickActions => 'Quick Actions';

  @override
  String get dashboardStartScan => 'Start a Scan';

  @override
  String get dashboardBrowseLibrary => 'Browse Library';

  @override
  String get dashboardFarmingTip =>
      'Tip of the Day: Inspect the undersides of tomato leaves to detect whitefly early signs.';

  @override
  String get librarySearchPlaceholder => 'Search for a pest...';

  @override
  String get libraryCropFilterAll => 'All';

  @override
  String get libraryCropFilterTomato => 'Tomatoes';

  @override
  String get libraryCropFilterPepper => 'Peppers';

  @override
  String get libraryDanger => 'Danger';

  @override
  String get libraryDangerLow => 'Low';

  @override
  String get libraryDangerMedium => 'Medium';

  @override
  String get libraryDangerHigh => 'High';

  @override
  String get libraryScientificName => 'Scientific name';

  @override
  String get libraryAffectedCrops => 'Affected crops';

  @override
  String get detailTabOverview => 'Overview';

  @override
  String get detailTabSymptoms => 'Symptoms';

  @override
  String get detailTabDamage => 'Damage';

  @override
  String get detailTabTreatments => 'Treatments';

  @override
  String get detailPrevention => 'Prevention';

  @override
  String get detailBiological => 'Biological Treatment';

  @override
  String get detailChemical => 'Chemical Treatment';

  @override
  String get scanTitle => 'Pest Detection';

  @override
  String get scanPrompt => 'Frame the insect or affected leaf';

  @override
  String get scanSelectGallery => 'Import from Gallery';

  @override
  String get scanCapture => 'Take a Photo';

  @override
  String get scanAnalyzing => 'Analyzing image with AI...';

  @override
  String get scanResultHealthy => 'Healthy Plant!';

  @override
  String get scanResultPestDetected => 'Pest Detected!';

  @override
  String get scanConfidence => 'Confidence';

  @override
  String get scanSave => 'Save to History';

  @override
  String get scanCancel => 'Cancel';

  @override
  String get scanCropTypePrompt => 'Choose Crop Type';

  @override
  String get historyTitle => 'Scan History';

  @override
  String get historyNoScans => 'No scans recorded yet.';

  @override
  String get historySyncSynced => 'Synced';

  @override
  String get historySyncPending => 'Pending sync';

  @override
  String get historySyncTrigger => 'Sync Now';

  @override
  String get historyLocalPath => 'Local path';

  @override
  String get historyDate => 'Scan date';

  @override
  String get historyUnsyncedBanner => 'History is not synced';

  @override
  String get historyScanRemovedSnackbar => 'Scan removed from history';

  @override
  String get scanDetailsTitle => 'Scan Details';

  @override
  String get close => 'Close';

  @override
  String get scanTopPredictions => 'Top Predictions';

  @override
  String get scanInferenceFailed => 'Detection Failed';

  @override
  String get scanUnknownError => 'An unknown error occurred.';

  @override
  String get scanRetry => 'Retry';

  @override
  String get scanAskAgriBot => 'Ask AgriBot';

  @override
  String get scanAskAgriBotSubtitle => 'Treatment, advice & prevention';

  @override
  String get scanNewScan => 'New Scan';

  @override
  String get scanViewPestDetails => 'View Pest Details';

  @override
  String get dashboardAgriBot => 'AgriBot — Pest Expert';

  @override
  String get dashboardAgriBotSubtitle => 'Ask all your questions about pests';

  @override
  String get libraryCropFilterOlive => 'Olive trees';

  @override
  String get libraryCropFilterCereal => 'Cereals';

  @override
  String get libraryCropFilterVine => 'Vine';

  @override
  String get libraryCropFilterCitrus => 'Citrus';

  @override
  String get darkModeToggle => 'Dark Mode';

  @override
  String get dashboardTip1 =>
      'Inspect the undersides of tomato leaves to detect whitefly early signs.';

  @override
  String get dashboardTip2 =>
      'Crop rotation reduces pest pressure by an average of 40%.';

  @override
  String get dashboardTip3 =>
      'Set up pheromone traps at the start of the season to monitor leafminers.';

  @override
  String get dashboardTip4 =>
      'Water early in the morning to reduce leaf humidity and limit fungal diseases.';

  @override
  String get dashboardTip5 =>
      'Natural predators like ladybugs can effectively control aphid populations.';

  @override
  String get libraryCropFilterPalm => 'Date Palm';

  @override
  String get libraryCropFilterPommeDeTerre => 'Potato';

  @override
  String get libraryCropFilterMaraichage => 'Horticulture';

  @override
  String get libraryCropFilterArboriculture => 'Orchards';

  @override
  String get libraryCropFilterPolyphage => 'Polyphagous';

  @override
  String get libraryCropFilterBetterave => 'Beetroot';

  @override
  String get libraryCropFilterOignon => 'Onion';

  @override
  String get libraryCropFilterFiguierBarbarie => 'Prickly pear';

  @override
  String get libraryCropFilterOrnement => 'Ornamental';

  @override
  String get scanCropTypeGeneral => 'General';

  @override
  String get scanCropTypeUnknown => 'I don\'t know';

  @override
  String get scanNotRelevantTitle => 'Image Not Recognized';

  @override
  String get scanNotRelevantMessage =>
      'This image does not show a plant, crop, or agricultural pest. Please photograph a leaf, plant, or insect.';

  @override
  String get scanSummaryLabel => 'Diagnostic Summary';

  @override
  String get scanSelectCropFirst => 'Select a crop type to continue';

  @override
  String get scanShare => 'Share Result';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsVersion => 'Version';

  @override
  String get libraryFavorites => 'Favorites';

  @override
  String get libraryNoFavorites => 'No favorites saved yet. Tap ♥ to add one.';

  @override
  String get historyStatsTitle => 'Overview';

  @override
  String get historyTopPests => 'Frequent Pests';

  @override
  String get settingsLicense => 'License & Legal Notices';

  @override
  String get licenseTitle => 'About the App';

  @override
  String get licenseCreatedByLabel => 'Developed by';

  @override
  String get licenseAuthorName => 'Moez Harb';

  @override
  String get licenseContactLabel => 'Contact';

  @override
  String get licenseContactEmail => 'moez.harb25@gmail.com';

  @override
  String get licenseYear => '2026';

  @override
  String get licenseRights => '© 2026 Moez Harb. All rights reserved.';

  @override
  String get licenseDescription =>
      'AgroScan is a mobile application for agricultural pest detection, designed to help farmers in North Africa (Tunisia, Morocco, Algeria) identify and manage 40 specific pests using artificial intelligence. The app analyzes crop photos and provides instant diagnosis, treatment advice, and access to a comprehensive pest library.';

  @override
  String get licenseTechTitle => 'Technologies Used';

  @override
  String get licenseTechUI => 'UI Framework: Flutter (Dart)';

  @override
  String get licenseTechAI =>
      'Artificial Intelligence: Google Gemini 2.5 Flash';

  @override
  String get licenseTechDB => 'Local Database: Drift / SQLite';

  @override
  String get licenseTechSync => 'Cloud Sync: Supabase';

  @override
  String get licenseDatasetTitle => 'Image Dataset';

  @override
  String get licenseDatasetDesc =>
      'The pest images integrated into the app come from a scientific dataset assembled as part of the PFE project, covering 40 pest species present in North African agrosystems.';

  @override
  String get licenseOpenSource => 'Open Source Notices';

  @override
  String get licenseOpenSourceDesc =>
      'This app uses open source libraries. Full license notices are accessible via the button below.';

  @override
  String get agrandir => 'Enlarge';

  @override
  String get detailTabTaxonomy => 'Taxonomy';

  @override
  String get detailTabLifecycle => 'Life Cycle';

  @override
  String get detailTabMechanical => 'Mechanical';

  @override
  String get detailTaxonomyTitle => 'Taxonomic Classification';

  @override
  String get detailLifecycleTitle => 'Life Cycle';

  @override
  String get detailMechanicalTitle => 'Mechanical Control';

  @override
  String get detailTaxonomyOrder => 'Order';

  @override
  String get detailTaxonomyFamily => 'Family';

  @override
  String get detailTaxonomySpecies => 'Species';

  @override
  String get detailPhotoGallery => 'Photo Gallery';

  @override
  String get detailDangerLow => 'Danger: Low';

  @override
  String get detailDangerMedium => 'Danger: Medium';

  @override
  String get detailDangerHigh => 'Danger: High';

  @override
  String get dashboardPestSectionTitle => 'Crop Pest Categories';

  @override
  String get dashboardPestCategoriesSubtitle =>
      '6 crop pest families described';

  @override
  String get pestCategoriesIntro =>
      'Crop pests are harmful organisms that feed on cultivated plants and cause damage at various stages of their development. They can attack different parts of the plant: leaves, stems, roots, flowers and fruits. These pests present great biological diversity and belong to several orders — Lepidoptera, Diptera, Coleoptera, Hemiptera and Thysanoptera — to which phytophagous mites are added, which are not insects in the strict sense. Their adaptability, short life cycle and high fecundity favor their proliferation in agroecosystems.\n\nThe Tunisian agroecosystem, marked by a bioclimatic transition from sub-humid in the north to arid in the south, harbors a pest entomofauna that perfectly illustrates this taxonomic complexity. Several specialized groups can be distinguished:';

  @override
  String get dashboardCatLepidopteraName => 'Lepidoptera — moths & leafminers';

  @override
  String get dashboardCatLepidopteraDesc =>
      'Among the most destructive Mediterranean crop pests. Tuta absoluta, Spodoptera, Helicoverpa and Lobesia cause damage by direct feeding or by forming galleries in leaves and fruits.';

  @override
  String get dashboardCatDipteraName => 'Diptera — flies & leafminers';

  @override
  String get dashboardCatDipteraDesc =>
      'Bactrocera oleae, Ceratitis capitata, Mayetiola destructor and Liriomyza leafminers develop larvae inside plant organs, making chemical control difficult.';

  @override
  String get dashboardCatHemipteraName => 'Hemiptera — aphids & scale insects';

  @override
  String get dashboardCatHemipteraDesc =>
      'Aphids (Myzus persicae, Aphis gossypii), whiteflies (Bemisia tabaci) and scale insects (Saissetia oleae) weaken plants by sap extraction and vector numerous plant viruses.';

  @override
  String get dashboardCatColeopteraName => 'Coleoptera — weevils & beetles';

  @override
  String get dashboardCatColeopteraDesc =>
      'Rhynchophorus ferrugineus, Phloeotribus scarabaeoides and Scolytus amygdali bore deep, hard-to-detect galleries inside plant tissues.';

  @override
  String get dashboardCatThysanopteraName => 'Thysanoptera — thrips';

  @override
  String get dashboardCatThysanopteraDesc =>
      'Thrips tabaci, Frankliniella occidentalis and Pezothrips kellyanus rasp plant tissues causing deformations and discolorations. They also vector Tospoviruses, greatly increasing their harmfulness.';

  @override
  String get dashboardCatAcariName => 'Acari — spider mites';

  @override
  String get dashboardCatAcariDesc =>
      'Though arachnids, not insects, Tetranychus urticae attacks over 1,100 plant species and rapidly develops acaricide resistance in hot, dry climates.';
}
