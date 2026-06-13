// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'AgroScan';

  @override
  String get navDashboard => 'الرئيسية';

  @override
  String get navLibrary => 'المكتبة';

  @override
  String get navScan => 'الفحص';

  @override
  String get navHistory => 'السجل';

  @override
  String get dashboardWelcome => 'مرحباً بك، أيها المزارع';

  @override
  String get dashboardSubtitle => 'احمِ محاصيلك اليوم';

  @override
  String get dashboardStats => 'إحصائيات المحاصيل';

  @override
  String get dashboardTotalScans => 'إجمالي الفحوصات';

  @override
  String get dashboardHealthy => 'سليم';

  @override
  String get dashboardInfested => 'مصاب';

  @override
  String get dashboardQuickActions => 'إجراءات سريعة';

  @override
  String get dashboardStartScan => 'بدء فحص جديد';

  @override
  String get dashboardBrowseLibrary => 'تصفح المكتبة';

  @override
  String get dashboardFarmingTip =>
      'نصيحة اليوم: تفحص الجانب السفلي من أوراق الطماطم لاكتشاف العلامات المبكرة للذبابة البيضاء.';

  @override
  String get librarySearchPlaceholder => 'البحث عن آفة...';

  @override
  String get libraryCropFilterAll => 'الكل';

  @override
  String get libraryCropFilterTomato => 'طماطم';

  @override
  String get libraryCropFilterPepper => 'فلفل';

  @override
  String get libraryDanger => 'درجة الخطورة';

  @override
  String get libraryDangerLow => 'منخفضة';

  @override
  String get libraryDangerMedium => 'متوسطة';

  @override
  String get libraryDangerHigh => 'مرتفعة';

  @override
  String get libraryScientificName => 'الاسم العلمي';

  @override
  String get libraryAffectedCrops => 'المحاصيل المصابة';

  @override
  String get detailTabOverview => 'نظرة عامة';

  @override
  String get detailTabSymptoms => 'الأعراض';

  @override
  String get detailTabDamage => 'الأضرار';

  @override
  String get detailTabTreatments => 'العلاجات';

  @override
  String get detailPrevention => 'الوقاية';

  @override
  String get detailBiological => 'العلاج الحيوي';

  @override
  String get detailChemical => 'العلاج الكيميائي';

  @override
  String get scanTitle => 'كشف الآفات';

  @override
  String get scanPrompt => 'ضع الحشرة أو الورقة المصابة داخل الإطار';

  @override
  String get scanSelectGallery => 'استيراد من المعرض';

  @override
  String get scanCapture => 'التقاط صورة';

  @override
  String get scanAnalyzing => 'جاري تحليل الصورة بالذكاء الاصطناعي...';

  @override
  String get scanResultHealthy => 'نبات سليم ومحمي!';

  @override
  String get scanResultPestDetected => 'تم اكتشاف آفة!';

  @override
  String get scanConfidence => 'نسبة التأكد';

  @override
  String get scanSave => 'حفظ في السجل';

  @override
  String get scanCancel => 'إلغاء';

  @override
  String get scanCropTypePrompt => 'اختر نوع المحصول';

  @override
  String get historyTitle => 'سجل الفحوصات';

  @override
  String get historyNoScans => 'لم يتم تسجيل أي فحص بعد.';

  @override
  String get historySyncSynced => 'متزامن';

  @override
  String get historySyncPending => 'في انتظار الاتصال';

  @override
  String get historySyncTrigger => 'مزامنة الآن';

  @override
  String get historyLocalPath => 'المسار المحلي';

  @override
  String get historyDate => 'تاريخ الفحص';

  @override
  String get historyUnsyncedBanner => 'السجل غير متزامن';

  @override
  String get historyScanRemovedSnackbar => 'تمت إزالة الفحص من السجل';

  @override
  String get scanDetailsTitle => 'تفاصيل الفحص';

  @override
  String get close => 'إغلاق';

  @override
  String get scanTopPredictions => 'أفضل التوقعات';

  @override
  String get scanInferenceFailed => 'فشل الكشف';

  @override
  String get scanUnknownError => 'حدث خطأ غير معروف.';

  @override
  String get scanRetry => 'إعادة المحاولة';

  @override
  String get scanAskAgriBot => 'اسأل AgriBot';

  @override
  String get scanAskAgriBotSubtitle => 'العلاج والنصائح والوقاية';

  @override
  String get scanNewScan => 'فحص جديد';

  @override
  String get scanViewPestDetails => 'عرض التفاصيل والوقاية';

  @override
  String get dashboardAgriBot => 'AgriBot — خبير الآفات';

  @override
  String get dashboardAgriBotSubtitle => 'اطرح كل أسئلتك عن الآفات';

  @override
  String get libraryCropFilterOlive => 'زيتون';

  @override
  String get libraryCropFilterCereal => 'حبوب';

  @override
  String get libraryCropFilterVine => 'عنب';

  @override
  String get libraryCropFilterCitrus => 'حمضيات';

  @override
  String get darkModeToggle => 'الوضع الداكن';

  @override
  String get dashboardTip1 =>
      'افحص الجانب السفلي من أوراق الطماطم لاكتشاف العلامات المبكرة للذبابة البيضاء.';

  @override
  String get dashboardTip2 =>
      'تناوب المحاصيل يقلل من ضغط الآفات بنسبة 40٪ في المتوسط.';

  @override
  String get dashboardTip3 =>
      'نصب مصائد الفيرمونات في بداية الموسم لمراقبة الحشرات الحافرة.';

  @override
  String get dashboardTip4 =>
      'اسقِ النباتات صباحاً مبكراً لتقليل رطوبة الأوراق والحد من الأمراض الفطرية.';

  @override
  String get dashboardTip5 =>
      'الحشرات المفيدة كالدعسوقة تتحكم في أعداد المن بفعالية عالية.';

  @override
  String get libraryCropFilterPalm => 'نخيل التمر';

  @override
  String get libraryCropFilterPommeDeTerre => 'بطاطا';

  @override
  String get libraryCropFilterMaraichage => 'زراعة الخضروات';

  @override
  String get libraryCropFilterArboriculture => 'الأشجار المثمرة';

  @override
  String get libraryCropFilterPolyphage => 'متعدد العوائل';

  @override
  String get libraryCropFilterBetterave => 'شمندر';

  @override
  String get libraryCropFilterOignon => 'بصل';

  @override
  String get libraryCropFilterFiguierBarbarie => 'صبار التين';

  @override
  String get libraryCropFilterOrnement => 'نباتات الزينة';

  @override
  String get scanCropTypeGeneral => 'عام';

  @override
  String get scanCropTypeUnknown => 'لا أعرف';

  @override
  String get scanNotRelevantTitle => 'صورة غير معروفة';

  @override
  String get scanNotRelevantMessage =>
      'هذه الصورة لا تُظهر نباتاً أو محصولاً أو آفة زراعية. يرجى التقاط صورة لورقة أو نبات أو حشرة.';

  @override
  String get scanSummaryLabel => 'ملخص التشخيص';

  @override
  String get scanSelectCropFirst => 'اختر نوع المحصول للمتابعة';

  @override
  String get scanShare => 'مشاركة النتيجة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsVersion => 'الإصدار';

  @override
  String get libraryFavorites => 'المفضلة';

  @override
  String get libraryNoFavorites => 'لا توجد مفضلات. اضغط على ♥ لإضافة آفة.';

  @override
  String get historyStatsTitle => 'نظرة عامة';

  @override
  String get historyTopPests => 'الآفات الشائعة';

  @override
  String get settingsLicense => 'الترخيص والإشعارات القانونية';

  @override
  String get licenseTitle => 'حول التطبيق';

  @override
  String get licenseCreatedByLabel => 'طوّره';

  @override
  String get licenseAuthorName => 'معز حرب';

  @override
  String get licenseContactLabel => 'التواصل';

  @override
  String get licenseContactEmail => 'moez.harb25@gmail.com';

  @override
  String get licenseYear => '2026';

  @override
  String get licenseRights => '© 2026 معز حرب. جميع الحقوق محفوظة.';

  @override
  String get licenseDescription =>
      'AgroScan تطبيق جوال لكشف الآفات الزراعية، صُمِّم لمساعدة المزارعين في شمال أفريقيا (تونس، المغرب، الجزائر) على تحديد ومكافحة 40 آفة محددة باستخدام الذكاء الاصطناعي. يحلل التطبيق صور المحاصيل ويقدم تشخيصاً فورياً ونصائح العلاج والوصول إلى مكتبة شاملة للآفات.';

  @override
  String get licenseTechTitle => 'التقنيات المستخدمة';

  @override
  String get licenseTechUI => 'الواجهة: Flutter (Dart)';

  @override
  String get licenseTechAI => 'الذكاء الاصطناعي: Google Gemini 2.5 Flash';

  @override
  String get licenseTechDB => 'قاعدة البيانات المحلية: Drift / SQLite';

  @override
  String get licenseTechSync => 'المزامنة السحابية: Supabase';

  @override
  String get licenseDatasetTitle => 'قاعدة بيانات الصور';

  @override
  String get licenseDatasetDesc =>
      'صور الآفات المدمجة في التطبيق مأخوذة من قاعدة بيانات علمية جُمعت في إطار مشروع PFE، وتغطي 40 نوعاً من الآفات الموجودة في النظم الزراعية لشمال أفريقيا.';

  @override
  String get licenseOpenSource => 'إشعارات المصدر المفتوح';

  @override
  String get licenseOpenSourceDesc =>
      'يستخدم هذا التطبيق مكتبات مفتوحة المصدر. يمكن الاطلاع على إشعارات الترخيص الكاملة عبر الزر أدناه.';

  @override
  String get agrandir => 'تكبير';

  @override
  String get detailTabTaxonomy => 'التصنيف';

  @override
  String get detailTabLifecycle => 'دورة الحياة';

  @override
  String get detailTabMechanical => 'ميكانيكية';

  @override
  String get detailTaxonomyTitle => 'التصنيف العلمي';

  @override
  String get detailLifecycleTitle => 'دورة الحياة';

  @override
  String get detailMechanicalTitle => 'المكافحة الميكانيكية';

  @override
  String get detailTaxonomyOrder => 'الرتبة';

  @override
  String get detailTaxonomyFamily => 'الفصيلة';

  @override
  String get detailTaxonomySpecies => 'الاسم العلمي';

  @override
  String get detailPhotoGallery => 'الصور';

  @override
  String get detailDangerLow => 'درجة الخطورة: منخفضة';

  @override
  String get detailDangerMedium => 'درجة الخطورة: متوسطة';

  @override
  String get detailDangerHigh => 'درجة الخطورة: مرتفعة';

  @override
  String get dashboardPestSectionTitle => 'فئات آفات المحاصيل';

  @override
  String get dashboardPestCategoriesSubtitle => '٦ عائلات من آفات المحاصيل';

  @override
  String get pestCategoriesIntro =>
      'آفات المحاصيل كائنات ضارة تتغذى على النباتات المزروعة وتُلحق بها أضراراً في مراحل مختلفة من دورة نموها. يمكنها مهاجمة أجزاء متعددة من النبات: الأوراق والسيقان والجذور والأزهار والثمار. تتسم هذه الآفات بتنوع بيولوجي واسع، وتنتمي إلى رتب عدة — حرشفية الأجنحة، وثنائية الأجنحة، وغمدية الأجنحة، ونصفية الأجنحة، وحوصلية الأجنحة — فضلاً عن الأكاروس النباتي الذي لا يُصنَّف ضمن الحشرات بالمعنى الدقيق. قدرتها على التكيف وقِصَر دورة حياتها وارتفاع خصوبتها عوامل تُسهم في تكاثرها في الأنظمة الزراعية الإيكولوجية.\n\nيتسم النظام الزراعي التونسي بانتقال مناخي-حيوي من شبه الرطب في الشمال إلى الجاف في الجنوب، ويحتضن حشرات ضارة تُجسّد هذا التعقيد التصنيفي بامتياز. ويمكن التمييز بين عدة مجموعات متخصصة:';

  @override
  String get dashboardCatLepidopteraName => 'حرشفية الأجنحة — العث والحفارات';

  @override
  String get dashboardCatLepidopteraDesc =>
      'من أشد الآفات ضراراً في المحاصيل المتوسطية. تسبب أضراراً بالأكل المباشر أو بحفر أنفاق داخل الأوراق والثمار.';

  @override
  String get dashboardCatDipteraName => 'ثنائية الأجنحة — الذباب والحفارات';

  @override
  String get dashboardCatDipteraDesc =>
      'ذبابة الزيتون وذبابة الفاكهة المتوسطية وذبابة الهيسيان ومينز ليريومايزا تتطور يرقاتها داخل الأنسجة النباتية مما يُصعّب المكافحة الكيميائية.';

  @override
  String get dashboardCatHemipteraName =>
      'نصفية الأجنحة — المن والحشرات القشرية';

  @override
  String get dashboardCatHemipteraDesc =>
      'المن والذبابة البيضاء والحشرات القشرية تضعف النباتات بامتصاص العصارة وتنقل فيروسات نباتية خطيرة.';

  @override
  String get dashboardCatColeopteraName => 'غمدية الأجنحة — السوس والخنافس';

  @override
  String get dashboardCatColeopteraDesc =>
      'سوسة النخيل الحمراء وسوسة الزيتون وحفّار اللوز تحفر أنفاقاً عميقة يصعب كشفها داخل الأنسجة النباتية.';

  @override
  String get dashboardCatThysanopteraName => 'حوصلية الأجنحة — التربس';

  @override
  String get dashboardCatThysanopteraDesc =>
      'التربس يجرح الأنسجة النباتية ويمتص محتوياتها مسبباً تشوهات وتغيرات لونية. وينقل فيروسات Tospovirus مما يزيد خطورته.';

  @override
  String get dashboardCatAcariName => 'الأكاروس — عناكب التيترانيك';

  @override
  String get dashboardCatAcariDesc =>
      'رغم كونها عناكب لا حشرات، يهاجم عنكبوت التيترانيك أكثر من 1100 نوع نباتي ويطوّر مقاومة سريعة لمبيدات الأكاروس في المناخ الحار والجاف.';
}
