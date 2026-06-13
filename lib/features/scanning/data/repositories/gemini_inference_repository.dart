import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import '../../../../core/config/gemini_config.dart';
import '../../domain/models/inference_result.dart';
import '../../domain/repositories/ai_inference_repository.dart';

class GeminiInferenceRepository implements AIInferenceRepository {
  // Valid pest IDs per culture (source of truth matches pest_cultures mapping)
  static const _cropHostMap = {
    'olivier':
        'pest_05,pest_08,pest_13,pest_20,pest_29,pest_33',
    'agrumes':
        'pest_10,pest_14,pest_19,pest_26,pest_29,pest_31,pest_34,pest_35,pest_39',
    'tomate':
        'pest_01,pest_12',
    'pomme_de_terre':
        'pest_09',
    'cereales':
        'pest_15,pest_28',
    'palmier':
        'pest_10,pest_16,pest_17,pest_30',
    'vigne':
        'pest_07',
    'maraichage':
        'pest_01,pest_11,pest_12,pest_24,pest_37,pest_38',
    'arboriculture':
        'pest_06,pest_14,pest_18,pest_36',
    'betterave':
        'pest_21',
    'oignon':
        'pest_37',
    'figuier_de_barbarie':
        'pest_27',
    'ornement':
        'pest_08,pest_11,pest_38',
    'polyphage':
        'pest_02,pest_03,pest_04,pest_22,pest_23,pest_25,pest_32,pest_40',
  };

  static const _cropContextMap = {
    'olivier': 'oliviers (Olea europaea)',
    'agrumes': 'agrumes (oranges, citrons, mandarines, clémentines)',
    'tomate': 'cultures de tomates (Solanum lycopersicum)',
    'pomme_de_terre': 'cultures de pomme de terre (Solanum tuberosum)',
    'cereales': 'céréales (blé, orge, avoine)',
    'palmier': 'palmier dattier (Phoenix dactylifera)',
    'vigne': 'vigne (Vitis vinifera)',
    'maraichage': 'cultures maraîchères (légumes de serre ou plein champ)',
    'arboriculture': 'arboriculture fruitière (pommier, poirier, amandier, prunier, pêcher, abricotier)',
    'betterave': 'betterave (Beta vulgaris)',
    'oignon': 'oignon, ail et poireau (Allium spp.)',
    'figuier_de_barbarie': 'figuier de Barbarie (Opuntia ficus-indica)',
    'ornement': 'plantes ornementales et florales (jasmin, fleurs coupées)',
    'polyphage': 'culture non spécifique — ravageur polyphage possible sur n\'importe quelle culture',
    'unknown': 'culture non identifiée — analyse générale tous ravageurs',
  };

  static String _mimeTypeOf(String filePath) {
    switch (p.extension(filePath).toLowerCase()) {
      case '.png':
        return 'image/png';
      case '.webp':
        return 'image/webp';
      case '.heic':
      case '.heif':
        return 'image/heic';
      default:
        return 'image/jpeg';
    }
  }

  @override
  Future<InferenceResult> analyzeImage(File image, String cropType) async {
    try {
      final apiKey = GeminiConfig.apiKey;
      if (apiKey.isEmpty) {
        throw Exception('Gemini API key not configured. Rebuild with --dart-define=GEMINI_KEY=your_key');
      }
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey',
      );

      final isUnrestricted = cropType == 'unknown' || cropType.isEmpty;
      final cropContext = _cropContextMap[cropType] ??
          'any agricultural plant or crop (general scan mode)';
      final allowedPests =
          isUnrestricted ? 'all 40 pests' : (_cropHostMap[cropType] ?? 'all 40 pests');

      final cropHostRule = isUnrestricted
          ? 'CROP-HOST RULE: No crop restriction — analyze for any of the 40 known agricultural pests.'
          : '''The user is scanning a plant from the following crop/host category: $cropContext.
Only identify pests that are known to affect this crop. The valid pests for this crop are: $allowedPests.
Do not suggest pests outside this list unless you are highly confident the visual evidence overrides the crop context. If unsure, rank candidates only from the valid list.''';

      final prompt = '''
You are an expert agricultural entomologist specializing in North African crop pests (Tunisia, Morocco, Algeria).

STEP 1 — IMAGE RELEVANCE CHECK
Determine if this image shows a plant, crop, leaf, fruit, agricultural field, soil with seedlings, or an insect/pest specimen.
If the image shows anything else (human face, animal, building, food, vehicle, random object) — set "isRelevantImage": false and stop immediately.

STEP 2 — CROP ANALYSIS (only if isRelevantImage is true)
Analyze the image as $cropContext. Look for:
- Physical damage: leaf mines, galleries, bite marks, fruit punctures, stem cuts, wilting
- Insect presence: adults, larvae, eggs, nymphs, scales, mealybug wax, mite webbing, sooty mold
- Secondary signs: galls, discoloration, deformation, root damage

$cropHostRule

PEST REFERENCE LIST:

[Lepidoptera — Moths / Leaf Miners — read carefully before choosing]
- pest_01: Tuta absoluta — Mineuse de la tomate
  HOST: tomato ONLY. MINE: whitish translucent blister-like serpentine galleries INSIDE the leaf blade (not superficial); frass visible as black dots through leaf tissue. Larvae cream/yellowish-green. Fruits show small entry holes with frass. Distinguished from Liriomyza by: tomato-exclusive host, deeper mines, fruit damage.
- pest_05: Prays oleae — Teigne de l'olivier
  HOST: olive ONLY. Creates tiny irregular mines in young olive leaves (phyllophagous generation); also attacks flowers (anthophagous) and fruits (carpophagous). Adult is a tiny silvery-gray moth.
- pest_08: Palpita unionalis — Palpite de l'olivier
  HOST: olive ONLY. Larvae fold and web together young olive shoot tips; mines visible on shoot leaves; silken shelter at growing point. Distinguished from Prays by: shoot tip folding + silk, not flower/fruit attack.
- pest_09: Phthorimaea operculella — Teigne de la pomme de terre
  HOST: potato ONLY. Irregular blotch mines in potato leaves with silk webbing; tunnels inside tubers covered with frass and silk. No fruit damage on above-ground crops.
- pest_11: Liriomyza trifolii — Mineuse américaine
  HOST: tomato, bean, celery, ornamentals — NOT olive, NOT potato. MINE: pale yellow-white irregular serpentine on upper leaf surface, more superficial than Tuta. No fruit damage. Adult is a tiny black-and-yellow fly.
- pest_12: Liriomyza bryoniae — Mineuse des cucurbitacées
  HOST: cucurbits (cucumber, melon, courgette) and tomato. MINE: pale yellowish meandering on upper surface. Distinguished from pest_11 by cucurbit host preference.
- pest_02: Spodoptera littoralis — Légionnaire des feuilles
  HOST: tomato, pepper, maize, cotton. Chewing pest: irregular holes in leaves, NOT mines. Gregarious young larvae skeleton leaves; older larvae eat through entirely. No gallery/mine pattern.
- pest_03: Agrotis ipsilon — Ver gris
  HOST: seedlings of many crops. Cuts stem at soil level at night; gray-brown caterpillar found in soil near base. Seedling collapses.
- pest_04: Helicoverpa armigera — Noctuelle de la tomate
  HOST: tomato, pepper, maize, cotton. Larva bores INTO fruit; circular entry hole at shoulder with frass; greenish caterpillar partially inside fruit.
- pest_06: Cydia pomonella — Carpocapse des pommes
  HOST: apple, pear, quince ONLY. Larva in core of fruit; entry point with reddish frass plug on fruit surface.
- pest_07: Lobesia botrana — Eudemis de la vigne
  HOST: grape ONLY. Larvae web together grape berries with silk; berries show feeding damage and are prone to secondary mold infection.
- pest_10: Ectomyelois ceratoniae — Pyrale de la datte
  HOST: date palm (dates) ONLY. Larva inside date fruit; frass and silk webbing at entry point; dates shrivel.
- pest_19: Phyllocnistis citrella — Mineuse des agrumes
  HOST: citrus ONLY. Tiny moth; translucent larva mines YOUNG citrus leaves making silvery winding (serpentine) galleries; leaves curl and distort. Damage on young/nursery trees; mines on leaf, not fruit.

[Diptera — Flies]
- pest_13: Bactrocera oleae — Mouche de l'olive
  HOST: olive ONLY. Stinging mark (oviposition puncture) on olive skin; larval tunnels inside olive flesh; premature fruit drop.
- pest_14: Ceratitis capitata — Mouche méditerranéenne des fruits
  HOST: citrus, peach, fig, apricot. Punctured fruit skin with soft sunken spot; maggots inside decaying flesh.
- pest_15: Mayetiola destructor — Mouche de Hesse
  HOST: wheat, barley ONLY. Infested tillers are stunted and yellow; maggot (white, legless) found under leaf sheath at base of tiller.

[Coleoptera — Beetles & Weevils]
- pest_16: Rhynchophorus ferrugineus — Charançon rouge du palmier
  HOST: date palm, coconut palm. Crown leaves wilt and collapse inward; large cream-colored grub with brown head in soft tissue; characteristic fermentation smell from crown.
- pest_17: Oryctes agamemnon — Rhinocéros du palmier
  HOST: palm ONLY. Characteristic V-shaped or fan-shaped cuts/holes in unopened palm fronds; large dark brown scarab beetle.
- pest_18: Scolytus amygdali — Scolyte de l'amandier
  HOST: stone-fruit trees (almond, plum, peach, apricot). Small cylindrical dark brown-to-black bark beetle (2.5–3.5 mm) with obliquely truncated abdomen; galleries under bark destroying phloem; round exit holes; twig dieback on weakened/drought-stressed trees.
- pest_20: Phloeotribus scarabaeoides — Scolyte de l'olivier
  HOST: olive bark ONLY. Multiple small round entry holes (1–2 mm) in olive branches/trunk; star-shaped gallery network under bark; branch dieback.
- pest_21: Cassida vittata — Casside de la betterave
  HOST: beet, spinach. Leaves skeletonized (epidermis intact, mesophyll eaten); oval, flattened greenish-yellow adult with spiny margins.

[Hemiptera — Aphids & Whiteflies]
- pest_22: Bemisia tabaci — Mouche blanche du tabac
  Tiny (~1 mm) white-winged insects densely packed under leaves; leaves curl upward; sticky honeydew + black sooty mold on upper surface.
- pest_23: Aphis gossypii — Puceron du cotonnier/concombre
  Dense colonies of small green or black aphids on young shoots and undersides; heavily distorted new growth; honeydew and ants.
- pest_24: Trialeurodes vaporariorum — Mouche blanche des serres
  Similar to pest_22 but adults are larger and hold wings flat (tent-like) vs. pest_22 which holds wings slightly angled. Host: tomato, cucumber, greenhouse crops.
- pest_25: Myzus persicae — Puceron vert du pêcher
  Light yellowish-green soft-bodied aphids on curled young leaves; primarily peach, but also on many vegetable crops.
- pest_26: Toxoptera aurantii — Puceron noir des agrumes
  HOST: citrus ONLY. Dense shiny black aphid colonies causing tight curling of young citrus shoot tips.
- pest_27: Dactylopius opuntiae — Cochenille du figuier de Barbarie
  HOST: Opuntia (prickly pear) ONLY. Vivid crimson stain when crushed + white cottony wax masses on cladodes.
- pest_28: Schizaphis graminum — Puceron des céréales
  HOST: wheat, barley, oats. Yellow-green aphids on cereal leaves causing yellowing and stunting; leaf may turn completely yellow.

[Hemiptera — Scale Insects & Bugs]
- pest_29: Saissetia oleae — Cochenille noire de l'olivier
  HOST: olive, citrus. Black hemispherical scale (3–5 mm) with H-shaped ridge on back; encrusts stems and branches; honeydew and sooty mold.
- pest_30: Parlatoria blanchardi — Cochenille blanche du palmier
  HOST: date palm ONLY. White-gray armored flat scales (elongated, <2 mm) densely covering date palm fronds; fronds turn grayish.
- pest_31: Aonidiella aurantii — Cochenille rouge de Californie
  HOST: citrus ONLY. Circular reddish-orange armored scales (~2 mm) on citrus fruit and branches; fruit shows reddish halos around scales.
- pest_32: Nezara viridula — Punaise verte
  Bright uniform green shield-shaped bug (12–14 mm); damages pods and fruit by sucking; causes deformed seeds.
- pest_33: Euphyllura olivina — Psylle de l'olivier
  HOST: olive ONLY. White cottony wax threads covering olive inflorescences (flower clusters); young shoots sticky; flower drop.
- pest_34: Icerya purchasi — Cochenille australienne
  HOST: citrus ONLY. Very distinctive large (8–12 mm) white fluted cottony egg sac attached to citrus branches; female body is orange-red under wax.
- pest_35: Planococcus citri — Cochenille farineuse
  Oval, soft, white powdery mealybug (3–4 mm) at leaf axils, under bark, and in fruit clusters; white waxy filaments around body margin.
- pest_36: Diaspidiotus perniciosus — Pou de San José
  Small circular gray armored scales (1.5 mm) with central nipple; infests bark, branches, and fruit surface; causes reddish halo on fruit skin.

[Thysanoptera — Thrips]
- pest_37: Thrips tabaci — Thrips du tabac/oignon
  HOST: onion, tobacco, leek. Silvery-white streaks and blotches on onion/leek leaves from cell-content feeding; tiny (1 mm) yellow-brown insects in leaf folds.
- pest_38: Frankliniella occidentalis — Thrips californien
  HOST: flowers and young leaves of many crops. Silvering or bronzing of petal edges and young leaf surfaces; tiny dark fecal spots. Key vector of TSWV virus.
- pest_39: Pezothrips kellyanus — Thrips des agrumes
  HOST: citrus ONLY. Small dark brown-to-blackish thrips; larvae feed under the calyx of young fruit producing a characteristic SILVERY RING/scarring at the fruit base; cosmetic fruit damage, key on lemon/bergamot.

[Acari — Mites]
- pest_40: Tetranychus urticae — Tétranyque tisserand
  Fine silky webbing on leaf underside (diagnostic); upper surface shows pale stippled/bronzed appearance from cell-content feeding; colonies visible as moving red/brown dots.

Respond ONLY with a valid JSON object — no markdown, no extra text:

{
  "isRelevantImage": true,
  "isHealthy": false,
  "summary": "Une brève description en français (2-3 phrases) du diagnostic: ce qui est observé, quel ravageur est détecté et l'impact sur la culture.",
  "topGuesses": [
    {
      "pestId": "pest_01",
      "pestName": "Tuta absoluta — Mineuse de la tomate",
      "confidenceScore": 0.87
    }
  ]
}

Rules:
- If image is NOT of a plant, crop, leaf, insect or agricultural context: set isRelevantImage=false, isHealthy=false, summary=null, topGuesses=[]
- ANTI-BIAS: Do NOT default to pest_01 (Tuta absoluta) for generic mine-like or irregular damage. Only assign pest_01 when (a) host is clearly tomato AND (b) whitish transparent serpentine galleries are visible inside the leaf blade. Discoloration or blotch damage alone does NOT confirm Tuta absoluta.
- CROP-HOST: Only use pestId values from the allowed set for this crop. Never suggest a pest that does not infest the scanned crop.
- List 1 to 3 guesses sorted by confidenceScore descending
- Use pestId values from the list above ONLY; set pestId to null for any unidentifiable pest
- If the plant appears healthy: isHealthy=true, topGuesses=[{pestId:null, pestName:"Sain / Healthy", confidenceScore:0.95}]
- The summary must be in French, 2-3 sentences, clinically precise
- Be conservative: prefer pestId=null over a wrong identification
- Confidence scores must be between 0.50 and 0.98
- When two pests look similar, list both as guesses with appropriate confidence rather than picking one arbitrarily
''';

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
                {
                  'inlineData': {
                    'mimeType': _mimeTypeOf(image.path),
                    'data': base64Image,
                  },
                },
              ],
            },
          ],
          'generationConfig': {
            'responseMimeType': 'application/json',
          },
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Gemini API returned ${response.statusCode}: ${response.body}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final candidate = (data['candidates'] as List?)?.first as Map<String, dynamic>?;
      final content = candidate?['content'] as Map<String, dynamic>?;
      final text = ((content?['parts'] as List?)?.first as Map<String, dynamic>?)?['text'] as String?;
      if (text == null) {
        throw Exception(
          'Gemini returned no content (finishReason: ${candidate?['finishReason']})',
        );
      }
      final jsonResult = jsonDecode(text) as Map<String, dynamic>;

      final isRelevant = jsonResult['isRelevantImage'] as bool? ?? false;

      if (!isRelevant) {
        return InferenceResult.notRelevant(cropType);
      }

      final isHealthy = jsonResult['isHealthy'] as bool? ?? false;
      final summary = jsonResult['summary'] as String?;
      final rawGuesses = jsonResult['topGuesses'] as List? ?? [];

      final List<PestGuess> guesses = rawGuesses
          .map((item) => PestGuess(
                pestId: item['pestId'] as String?,
                pestName: item['pestName'] as String? ?? 'Inconnu',
                confidenceScore:
                    (item['confidenceScore'] as num? ?? 0.5).toDouble(),
              ))
          .toList();

      if (guesses.isEmpty) {
        if (isHealthy) return InferenceResult.healthy(cropType, summary: summary);
        // Gemini detected damage but could not identify the specific pest.
        return InferenceResult(
          confidenceScore: 0.0,
          cropType: cropType,
          isHealthy: false,
          isRelevantImage: true,
          summary: summary,
          topGuesses: const [],
        );
      }

      final topGuess = guesses.first;

      return InferenceResult(
        pestId: topGuess.pestId,
        pestName: topGuess.pestName,
        confidenceScore: topGuess.confidenceScore,
        cropType: cropType,
        isHealthy: isHealthy,
        isRelevantImage: true,
        summary: summary,
        topGuesses: guesses,
      );
    } catch (e) {
      rethrow;
    }
  }
}
