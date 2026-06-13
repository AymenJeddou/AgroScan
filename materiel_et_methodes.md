# 9. Matériel et méthodes

## 9.1. Vue d'ensemble du système AgroScan

### 9.1.1. Architecture générale

AgroScan est une application mobile de détection d'insectes ravageurs destinée au terrain agricole tunisien, où les contraintes sont fortes : faible couverture réseau dans les zones rurales, nécessité d'une réponse rapide au moment de l'observation et préservation de la confidentialité des données de l'exploitation.

La conception du moteur de détection visuelle a fait l'objet de **deux approches successives**. Une première approche, exploratoire, a consisté à étudier la faisabilité d'un réseau de neurones convolutif (CNN) embarqué (sections 9.3 à 9.6) : constitution d'une base d'images, choix d'architecture et analyse des contraintes de déploiement. L'examen de cette piste a mis en évidence des obstacles déterminants — écart de distribution entre les images de bases de données et les photographies réelles de terrain, lourdeur de l'entraînement et de la maintenance d'un modèle embarqué — qui ont conduit à **ne pas la retenir**. L'inférence de production a finalement été confiée à l'**API Gemini** de Google, un modèle multimodal capable d'analyser directement l'image (section 9.6.2). La base d'images constituée lors de la première approche n'a pas été perdue pour autant : elle sert désormais à **fiabiliser et enrichir les identifications fournies par l'API Gemini** (constitution d'un jeu de référence et de comparaison, calibration des prompts d'identification).

Le système repose sur trois composantes interdépendantes :

1. **Le moteur d'inférence visuelle** : l'API Gemini (modèle multimodal), sollicitée au moment du scan, dont les résultats sont contextualisés à l'aide de la base d'images de référence constituée durant la phase exploratoire (l'approche CNN embarqué, étudiée mais non retenue, est décrite en sections 9.4 à 9.6) ;
2. **Le moteur de persistance local** : une base de données SQLite qui conserve l'historique des analyses, la bibliothèque des fiches ravageurs et les préférences de l'utilisateur sans synchronisation obligatoire — entièrement consultable hors ligne ;
3. **L'interface mobile multilingue** : développée en Flutter, elle guide l'agriculteur depuis la capture de l'image jusqu'à l'affichage des recommandations de lutte.

### 9.1.2. Pipeline de traitement de bout en bout

Le schéma ci-dessous représente le flux complet d'une analyse, depuis la prise de vue jusqu'à l'affichage du résultat :

```
┌─────────────────────────────────────────────────────────────────────┐
│                      APPLICATION AGROSCAN                           │
│                                                                     │
│  [1] Sélection           [2] Capture            [3] Prétraitement   │
│  de la culture      →    de l'image         →   (redimensionnement, │
│  (tomate, olive…)        (caméra ou             compression JPEG,   │
│                          galerie)                encodage base64)   │
│                                                        │            │
│  [6] Affichage      ←    [5] Post-traitement  ←  [4] Inférence      │
│  des résultats           (parsing de la          via l'API Gemini   │
│  + fiche ravageur        réponse, filtrage       (analyse multimo-  │
│  + méthodes lutte        par culture)            dale de l'image)   │
│                                                                     │
│  [7] Sauvegarde dans l'historique local (SQLite / Drift)            │
└─────────────────────────────────────────────────────────────────────┘
```

L'étape [4] d'inférence est assurée par l'**API Gemini** : l'image est transmise au modèle distant via une requête HTTP, accompagnée d'un prompt qui précise la culture sélectionnée et restreint les espèces candidates aux ravageurs compatibles avec cette culture. Les étapes de persistance, de consultation de la bibliothèque et de l'historique restent en revanche intégralement locales et hors ligne. L'approche alternative d'inférence embarquée (CNN converti en TensorFlow Lite, qui aurait permis une inférence locale d'environ 180 ms sur un Snapdragon 665) a été étudiée lors de la phase exploratoire mais **non retenue** ; elle est décrite, à titre de justification du choix, en sections 9.4 à 9.6.

---

## 9.2. Sélection et justification des 40 ravageurs cibles

### 9.2.1. Critères de sélection

La liste des 40 ravageurs intégrés dans AgroScan n'est pas arbitraire : elle découle directement de la revue bibliographique présentée dans les sections 2 et 3 du présent rapport. Trois critères ont guidé la sélection, en cohérence avec les priorités agronomiques tunisiennes :

**Critère 1 — Importance économique documentée en Tunisie.** Seules les espèces dont l'impact sur les rendements est quantifié dans la littérature scientifique ou les rapports officiels (DGSVCIA, FAO, MARHP) ont été retenues. *Tuta absoluta*, par exemple, représente à elle seule des pertes pouvant atteindre 80 à 100 % en cultures de tomate sous serre depuis son introduction en 2008 (Desneux et al., 2010).

**Critère 2 — Distribution géographique couvrant au moins une région agricole tunisienne.** Les espèces strictement tropicales ou absentes du bassin méditerranéen ont été exclues, afin de garantir la pertinence des identifications sur le terrain.

**Critère 3 — Disponibilité d'images suffisante.** Chaque espèce devait être documentée par un nombre minimal d'images de référence représentatives — exigence commune aux deux approches : ces images auraient alimenté l'entraînement du CNN lors de l'étude de faisabilité, et elles constituent aujourd'hui la base visuelle servant à fiabiliser et comparer les identifications de l'API Gemini. Ce critère technique a conduit à exclure quelques espèces agronomiquement importantes mais insuffisamment documentées photographiquement (voir section 9.8 sur les limites).

### 9.2.2. Répartition par culture

Le tableau suivant présente la répartition des 40 espèces retenues selon les huit types de cultures couverts par l'application. Les fiches détaillées de chaque ravageur sont disponibles en Annexe du présent rapport.

| Culture | Nombre d'espèces | Principaux ravageurs inclus |
|---|---|---|
| Tomate | 9 | *Tuta absoluta*, *Bemisia tabaci*, *Helicoverpa armigera*, *Myzus persicae*, *Frankliniella occidentalis*, *Tetranychus urticae*, *Trialeurodes vaporariorum*, *Spodoptera exigua*, *Agrotis ipsilon* |
| Poivron | 6 | *Bemisia tabaci*, *Myzus persicae*, *Frankliniella occidentalis*, *Spodoptera littoralis*, *Aphis gossypii*, *Tetranychus urticae* |
| Olivier | 5 | *Bactrocera oleae*, *Prays oleae*, *Saissetia oleae*, *Phloeotribus scarabaeoides*, *Parlatoria oleae* |
| Palmier dattier | 4 | *Rhynchophorus ferrugineus*, *Parlatoria blanchardi*, *Oligonychus afrasiaticus*, *Oryctes elegans* |
| Agrumes | 5 | *Ceratitis capitata*, *Aonidiella aurantii*, *Planococcus citri*, *Phyllocnistis citrella*, *Aleurothrixus floccosus* |
| Vigne | 4 | *Lobesia botrana*, *Planococcus ficus*, *Empoasca vitis*, *Tetranychus urticae* |
| Céréales | 5 | *Mayetiola destructor*, *Schizaphis graminum*, *Zabrus tenebrioides*, *Eurygaster integriceps*, *Rhopalosiphum padi* |
| Général | 2 | *Locusta migratoria*, *Schistocerca gregaria* |

*Pour les descriptions morphologiques, cycles biologiques et méthodes de lutte détaillées, se référer aux fiches en Annexe, sections A1 à A40.*

### 9.2.3. Cohérence avec la revue bibliographique

La liste retenue reflète les conclusions de la revue de littérature : les ordres les mieux représentés sont les Hémiptères (15 espèces) et les Lépidoptères (10 espèces), suivis des Coléoptères (6 espèces) et des Diptères (5 espèces), conformément à leur prédominance dans l'entomofaune nuisible méditerranéenne décrite en section 1.2. Les Thysanoptères (3 espèces) et les Acariens (1 espèce, *Tetranychus urticae*) complètent la liste. Les espèces vectores de virus phytopathogènes (*Bemisia tabaci*, *Myzus persicae*, *Frankliniella occidentalis*) ont été systématiquement incluses en raison du double impact — direct par ponction de sève, indirect par transmission virale — documenté dans la littérature (Boukhris-Bouhachem et al., 2007).

---

## 9.3. Constitution de la base d'images de référence

### 9.3.1. Sources de données

La constitution d'une base d'images annotées et représentatives des 40 espèces cibles est un prérequis commun aux deux approches : ces images auraient alimenté l'entraînement du CNN lors de l'étude de faisabilité, et elles servent aujourd'hui de **base de référence** pour contextualiser, comparer et vérifier les identifications de l'API Gemini (section 9.6.2). Trois sources complémentaires ont été mobilisées :

**IP102 — A Large-Scale Benchmark Dataset for Insect Pest Recognition** (Wu et al., 2019) : base de données de référence internationale comprenant 75 222 images réparties en 102 classes d'insectes ravageurs agricoles. Seules les classes correspondant aux 40 espèces cibles ont été extraites. Ce dataset constitue l'ossature principale de la base d'images.

**iNaturalist** : plateforme de sciences participatives permettant d'accéder à des observations géolocalisées en zone méditerranéenne (Espagne, Grèce, Maroc, Italie). Les images ont été sélectionnées en priorité dans une fenêtre géographique comparable au contexte tunisien (latitude 30–45°N, bioclimat méditerranéen et semi-aride), afin de maximiser la représentativité des conditions d'observation réelles.

**PlantVillage** (Hughes & Salathé, 2015) : utilisé pour les images de feuillage sain et les symptômes sur plantes, permettant de documenter la distinction entre plantes infestées et plantes en bonne santé.

### 9.3.2. Volume final et répartition

Après nettoyage (élimination des images floues, mal cadrées ou ambiguës) et contrôle qualité visuel, le corpus final retenu comprend **13 798 images** réparties comme suit :

| Jeu | Proportion | Nombre d'images |
|---|---|---|
| Entraînement | 70% | 9 659 |
| Validation | 15% | 2 070 |
| Test | 15% | 2 069 |

Ce découpage standard 70/15/15 a été défini lors de l'étude de faisabilité du CNN. Dans la solution finalement retenue, ces trois sous-ensembles ne servent plus à entraîner un modèle mais conservent une utilité : le plus grand constitue la **base de référence visuelle**, le jeu de validation sert à la **calibration des prompts d'identification**, et le jeu de test permet de **mesurer la qualité des identifications** rendues par l'API Gemini. La répartition est stratifiée par classe afin de garantir que chaque espèce est proportionnellement représentée. Chaque image est annotée avec l'espèce et la culture affectée, ce double étiquetage permettant le filtrage par culture lors de l'inférence.

#### Répartition par ordre taxonomique

La ventilation du corpus par ordre d'insectes (et acariens) met en évidence la prédominance des Hémiptères et des Lépidoptères, conformément à leur poids dans l'entomofaune nuisible méditerranéenne :

| Ordre | Espèces | Images | % du total | Moyenne / espèce |
|---|---|---|---|---|
| Hémiptères | 15 | 4 915 | 35,6 % | 328 |
| Lépidoptères | 10 | 4 579 | 33,2 % | 458 |
| Coléoptères | 6 | 1 917 | 13,9 % | 320 |
| Diptères | 5 | 1 349 | 9,8 % | 270 |
| Acariens | 1 | 535 | 3,9 % | 535 |
| Thysanoptères | 3 | 503 | 3,6 % | 168 |
| **Total** | **40** | **13 798** | **100 %** | **≈ 345** |

**Lecture de cette répartition.** Il convient de distinguer deux niveaux d'analyse, sous peine d'interprétation trompeuse. En *volume par ordre*, les Thysanoptères (503 images) et les Acariens (535 images) apparaissent comme les parents pauvres du corpus. Mais cette lecture n'est pas la bonne pour une reconnaissance *par espèce* : ce qui compte est la moyenne d'images par classe. Sous cet angle, la hiérarchie s'inverse :

- Les **Acariens** sont en réalité la catégorie la mieux dotée du jeu (535 images pour une seule classe, *Tetranychus urticae*). Cette espèce ne devrait donc poser aucun problème de couverture documentaire, malgré son faible poids en volume total.
- Les **Thysanoptères** constituent la véritable faiblesse du corpus : 168 images par espèce, le ratio le plus bas du jeu. Combiné au fait que les thrips sont minuscules et morphologiquement très proches les uns des autres, ce sont les espèces les plus exposées aux confusions d'identification.

### 9.3.3. Déséquilibre des classes et solutions adoptées

La collecte de données a mis en lumière un déséquilibre important entre espèces, reflétant à la fois la notoriété scientifique inégale des ravageurs et les difficultés pratiques de collecte photographique en Tunisie.

| Catégorie | Exemples d'espèces | Images disponibles |
|---|---|---|
| Classes bien documentées | *Tuta absoluta*, *Bemisia tabaci*, *Ceratitis capitata* | 400 – 700 images |
| Classes moyennement documentées | *Lobesia botrana*, *Schizaphis graminum*, *Prays oleae* | 150 – 400 images |
| Classes sous-représentées | *Rhynchophorus ferrugineus*, *Saissetia oleae*, *Oligonychus afrasiaticus* | 60 – 150 images |

Pour les espèces sous-représentées, deux mesures compensatoires étaient prévues dans l'étude de faisabilité du CNN :
- **Augmentation ciblée renforcée** : pour les classes de moins de 300 images, 6 à 8 transformations par image originale (contre 3 à 4 pour les classes bien représentées) ;
- **Pondération des pertes (*class weights*)** : la fonction de coût aurait été pondérée inversement à la fréquence de chaque classe, pénalisant davantage les erreurs sur les espèces rares.

Ces mesures relevaient de l'approche CNN. Dans la solution retenue (API Gemini), le déséquilibre du corpus n'affecte pas directement l'inférence — le modèle multimodal n'étant pas entraîné sur ce corpus — mais il reste pertinent pour la couverture de la base de référence et pour identifier les espèces les plus à risque de confusion.

### 9.3.4. Augmentation de données

L'augmentation de données est une technique qui consiste à générer artificiellement de nouvelles images à partir des images existantes, en appliquant des transformations qui simulent la variabilité des conditions de prise de vue réelles. Dans le contexte agricole, un même insecte peut être photographié sous des angles très différents, dans des conditions lumineuses variables et devant des fonds de végétation hétérogènes. Dans le cadre de l'étude de faisabilité du CNN, les transformations envisagées étaient :

- **Rotation aléatoire** (±30°) : simule les différentes orientations de l'insecte sur la plante ;
- **Retournement horizontal et vertical** : robustesse aux différentes positions de l'appareil ;
- **Variation de luminosité et de contraste** (facteur 0.6–1.4) : simule les conditions d'éclairage variables au champ (plein soleil, ombre sous feuillage, couverture nuageuse) ;
- **Zoom aléatoire** (0.8–1.2×) : représente les différentes distances de prise de vue ;
- **Légère distorsion de perspective** : simule un angle de prise de vue non orthogonal ;
- **Bruit gaussien** : simule les artefacts de capteurs de bas de gamme.

Ces transformations auraient été appliquées dynamiquement à l'entraînement, sans stockage préalable des images augmentées. Cette mesure visait à compenser la faible robustesse attendue du CNN aux conditions de terrain ; dans la solution retenue, elle n'est plus nécessaire, l'API Gemini étant nativement robuste à ces variations de prise de vue (section 9.6.2).

---

## 9.4. Étude de faisabilité d'un modèle de deep learning embarqué

> **Note méthodologique.** Cette section documente l'approche d'apprentissage profond *envisagée* lors de la phase exploratoire, ainsi que les raisons de son abandon. Le modèle n'a pas été entraîné ni déployé dans le cadre du projet ; les chiffres cités ci-dessous sont des **valeurs indicatives issues de la littérature** (et non des mesures réalisées sur nos données), destinées à justifier le choix d'architecture qui aurait été fait et, par contraste, le choix final de l'API Gemini.

### 9.4.1. Architecture candidate : EfficientNet-B3

Plusieurs architectures de réseaux de neurones convolutifs ont été comparées, sur la base de leurs caractéristiques publiées, au regard des contraintes du projet : précision suffisante pour 40 classes, taille compatible avec un smartphone d'entrée de gamme (objectif < 15 MB) et latence d'inférence inférieure à 300 ms.

Le tableau suivant rassemble les caractéristiques **rapportées dans la littérature** pour ces architectures (précision top-1 sur ImageNet, taille et latence typiques après quantification INT8) :

| Architecture | Paramètres (M) | Top-1 ImageNet (publié) | Taille (.tflite INT8) | Latence indicative |
|---|---|---|---|---|
| MobileNetV3-Large | 5,4 | 75,2% | ~6 MB | ~95 ms |
| EfficientNet-B0 | 5,3 | 77,1% | ~8 MB | ~110 ms |
| **EfficientNet-B3** | **12,0** | **81,6%** | **~12 MB** | **~180 ms** |
| ResNet-50 | 25,6 | 76,0% | ~48 MB | ~420 ms |
| InceptionV3 | 23,9 | 77,9% | ~43 MB | ~390 ms |

*Valeurs indicatives issues des publications d'origine (Tan & Le, 2019 ; Howard et al., 2019) et d'ordres de grandeur de latence rapportés pour un processeur de type Qualcomm Snapdragon 665, courant sur les smartphones d'entrée de gamme distribués en Tunisie.*

**EfficientNet-B3** (Tan & Le, 2019) aurait constitué le meilleur compromis précision/taille pour ce projet : un gain de précision notable par rapport à MobileNetV3 pour un surcoût de taille modéré, jugé acceptable au regard des appareils cibles.

EfficientNet est une famille de réseaux dont l'architecture est mise à l'échelle de manière composée (profondeur, largeur et résolution), plutôt que d'augmenter une seule dimension comme le faisaient les approches précédentes. Cette approche permet d'atteindre des performances élevées avec un nombre de paramètres maîtrisé (Tan & Le, 2019).

### 9.4.2. Transfer learning depuis ImageNet

Entraîner un réseau de neurones profond depuis zéro nécessiterait plusieurs millions d'images annotées — un volume inaccessible pour un projet académique centré sur 40 espèces d'insectes. La technique du **transfer learning** (apprentissage par transfert) permet de contourner cette limitation en réutilisant les poids d'un modèle pré-entraîné sur ImageNet (1,28 million d'images, 1 000 classes).

L'intuition biologique est la suivante : les premières couches du réseau, qui apprennent à détecter des contours, des textures et des formes élémentaires, sont largement invariantes au domaine — qu'il s'agisse de reconnaître un chat ou un insecte. Seules les couches supérieures, qui combinent ces caractéristiques pour former des représentations de haut niveau, doivent être ré-apprises pour la tâche spécifique (LeCun et al., 2015).

### 9.4.3. Tête de classification personnalisée

Le backbone EfficientNet-B3 pré-entraîné est complété par une tête de classification adaptée aux 40 classes cibles :

```
EfficientNet-B3 (backbone, pré-entraîné ImageNet)
    └─ GlobalAveragePooling2D
    └─ Dense(512, activation='relu')
    └─ Dropout(0.4)
    └─ Dense(256, activation='relu')
    └─ Dropout(0.3)
    └─ Dense(40, activation='softmax')   ← 40 classes de ravageurs
```

Les couches Dropout réduisent le surapprentissage (*overfitting*) en désactivant aléatoirement une fraction des neurones lors de l'entraînement, forçant le réseau à apprendre des représentations redondantes et plus robustes.

### 9.4.4. Stratégie et hyperparamètres d'entraînement envisagés

L'entraînement aurait été mené en deux phases successives, selon une stratégie de fine-tuning progressive :

**Phase 1 — Entraînement de la tête de classification (15 epochs)**
Le backbone EfficientNet-B3 est entièrement gelé. Seules les couches de la tête de classification sont entraînées. Cette phase permet d'initialiser la tête à des valeurs raisonnables avant d'autoriser la modification des poids du backbone.

| Hyperparamètre | Valeur |
|---|---|
| Optimiseur | Adam |
| Taux d'apprentissage | 1×10⁻³ |
| Taille de batch | 32 |
| Fonction de perte | categorical crossentropy |
| Régularisation | Dropout (0.4 / 0.3) |

**Phase 2 — Fine-tuning bout-en-bout (35 epochs)**
Les 30 dernières couches du backbone sont dégelées et entraînées conjointement avec la tête, avec un taux d'apprentissage très réduit pour ne pas détruire les représentations pré-apprises.

| Hyperparamètre | Valeur |
|---|---|
| Optimiseur | Adam |
| Taux d'apprentissage | 1×10⁻⁵ |
| Scheduler | ReduceLROnPlateau (facteur 0.5, patience 5) |
| Arrêt précoce | patience = 10 epochs |
| Checkpointing | sauvegarde du meilleur modèle (validation accuracy) |

Cet entraînement aurait été conduit sur un environnement de type Google Colab (GPU NVIDIA Tesla T4). Il n'a toutefois pas été mené : l'analyse de faisabilité (section 9.5) a conduit à écarter cette piste avant la phase d'entraînement effective, au profit de l'API Gemini.

---

## 9.5. Évaluation de la piste deep learning et raisons de son abandon

### 9.5.1. Métriques qui auraient servi à l'évaluation

Un modèle de classification de ce type aurait été évalué sur un jeu de test (15% des données, non vu à l'entraînement) selon les métriques classiques de la reconnaissance d'images :

- **Précision top-1** : proportion d'images pour lesquelles l'espèce correcte est la prédiction principale ;
- **Précision top-3** : proportion d'images pour lesquelles l'espèce correcte figure parmi les 3 meilleures prédictions — métrique pertinente dans le contexte applicatif, où les 3 résultats les plus probables sont présentés à l'agriculteur ;
- **Précision, Rappel, F1-score macro** : métriques calculées classe par classe puis moyennées, robustes au déséquilibre entre classes ;
- **Matrice de confusion** : visualisation des confusions entre espèces.

### 9.5.2. Performances attendues d'après la littérature

D'après les travaux publiés sur des jeux de données comparables (IP102 et sous-ensembles ; Wu et al., 2019), une architecture EfficientNet ajustée par transfert peut atteindre, **en conditions de laboratoire**, des précisions top-1 de l'ordre de 80 à 88 % sur quelques dizaines de classes d'insectes. Ces ordres de grandeur, encourageants sur le papier, doivent cependant être nuancés par deux réserves majeures, qui ont pesé décisivement dans le choix de ne pas poursuivre cette voie (sections 9.5.3 et 9.5.4). Aucune de ces valeurs n'a été mesurée dans le cadre du présent projet : elles ne sont citées qu'à titre indicatif.

### 9.5.3. Confusions attendues entre espèces proches

Indépendamment du modèle, certaines confusions sont *intrinsèques à la tâche* et prévisibles dès l'analyse morphologique : elles concernent des espèces très proches visuellement ou photographiées au même stade de développement :

- *Bemisia tabaci* et *Trialeurodes vaporariorum* (aleurodes de morphologie similaire au stade adulte) ;
- *Frankliniella occidentalis* et *Thrips tabaci* (deux espèces de thrips de très petite taille, difficiles à distinguer sur image) ;
- *Spodoptera littoralis* et *Spodoptera exigua* (larves morphologiquement proches en début de développement).

Ces confusions sont biologiquement cohérentes et peuvent être atténuées par le filtrage par culture : *Trialeurodes vaporariorum* est principalement associée aux cultures sous abri, tandis que *Bemisia tabaci* est présente en plein champ — distinction que le filtre par culture exploite dans le post-traitement, quelle que soit la méthode d'inférence. Les espèces les plus difficiles à identifier restent celles qui sont à la fois petites, peu contrastées et faiblement documentées (thrips, certains acariens, cochenilles), tandis que les espèces présentant des caractères distinctifs marqués (*Rhynchophorus ferrugineus*, *Tuta absoluta*, *Bactrocera oleae*) sont les plus aisément reconnaissables.

### 9.5.4. Obstacle décisif : l'écart aux conditions réelles de terrain

La réserve déterminante tient à l'**écart de distribution** (*domain shift*) entre les images des bases de données (IP102, iNaturalist), souvent nettes et bien cadrées, et les photographies réellement prises par des agriculteurs avec des smartphones d'entrée de gamme : arrière-plans végétaux complexes, insectes partiellement masqués ou en mouvement, échelles très variables, reflets et qualité de capteur médiocre. Sur ce type d'images, un modèle entraîné sur des bases standardisées voit ses performances chuter fortement par rapport au laboratoire, tout particulièrement pour les espèces de petite taille (thrips, aleurodes, acariens) et les stades larvaires — un phénomène bien documenté que l'augmentation de données n'atténue que partiellement.

Ce risque, conjugué à la lourdeur d'un modèle embarqué (entraînement puis ré-entraînement à chaque évolution du périmètre d'espèces, conversion et requantification TFLite, gestion des versions sur le parc d'appareils), a conduit à **ne pas engager l'entraînement** d'un CNN et à réorienter l'inférence de production vers une solution multimodale, décrite dans la section suivante.

---

## 9.6. Du déploiement embarqué envisagé à la solution retenue

### 9.6.1. Contraintes de déploiement de l'option embarquée

Le déploiement d'un CNN sur smartphone aurait imposé une étape de conversion au format **TensorFlow Lite (.tflite)**, format d'inférence standard sur Android et iOS, suivie d'une **quantification post-entraînement INT8** (remplacement des poids flottants 32 bits par des entiers 8 bits). Cette chaîne réduit typiquement la taille du modèle d'un facteur 3 à 4 et accélère l'inférence sur processeurs mobiles, au prix d'une perte de précision généralement marginale (de l'ordre de quelques dixièmes de point sur des architectures comme EfficientNet-B3, d'après la littérature).

Ces étapes — entraînement, conversion, quantification, intégration de l'artefact dans les *assets* de l'application, puis maintenance des versions — illustrent le coût et la rigidité d'une chaîne embarquée. **Aucun modèle `.tflite` n'a été produit** : l'étude s'est arrêtée à l'analyse de faisabilité (section 9.5), au profit de l'approche décrite ci-dessous.

### 9.6.2. Moteur d'inférence en production : API Gemini Vision (multimodale)

Au terme de l'étude de faisabilité, l'inférence visuelle de production a été confiée à l'**API Gemini** de Google (modèle multimodal *Gemini 2.5 Flash*), capable d'analyser directement une image et de raisonner sur son contenu plutôt que de la classer dans un ensemble figé de 40 catégories. Ce choix répond directement à l'écart de robustesse anticipé sur le terrain (section 9.5.4) :

- **Robustesse aux conditions réelles** : pré-entraîné sur des corpus d'images incomparablement plus vastes et hétérogènes que notre dataset, le modèle multimodal généralise nettement mieux aux arrière-plans complexes, aux variations d'éclairage et aux angles de prise de vue rencontrés au champ ;
- **Raisonnement contextuel** : au-delà de la simple classification, le modèle prend en compte la culture sélectionnée par l'agriculteur et les indices visuels de dégâts pour affiner son diagnostic et l'expliciter en langage naturel ;
- **Maintenance allégée** : aucune phase de ré-entraînement ni de reconversion n'est nécessaire pour faire évoluer le périmètre des espèces ou améliorer les réponses ; le guidage s'effectue par *prompt engineering*, à l'image de l'assistant AgroBot (section 9.7.5).

**Rôle du dataset constitué.** Le corpus de 13 798 images décrit en section 9.3 n'a pas été abandonné avec la piste CNN. L'effort de collecte, de nettoyage et de curation de plusieurs milliers d'images a servi à **enrichir et fiabiliser le système** dans son ensemble : constitution d'un jeu de référence pour l'évaluation des identifications, calibration et test des prompts d'identification soumis au modèle multimodal (sélection d'exemples visuels représentatifs par espèce), et alimentation des fiches visuelles de comparaison présentées à l'utilisateur dans la bibliothèque. Cet investissement en données reste donc au cœur de la qualité de l'outil, même si l'inférence elle-même ne repose plus sur un réseau entraîné en interne.

**Modèle économique.** L'usage de l'API Gemini en production implique une consommation facturée à la requête. Pour disposer d'un volume d'utilisation suffisant lors des phases de développement, de test et de démonstration — au-delà des quotas restreints de l'offre gratuite — un **accès payant à l'API a été souscrit**, garantissant la disponibilité du service et un débit de requêtes adapté aux essais sur le terrain.

**Connectivité et confidentialité.** Ce choix comporte une contrepartie assumée : contrairement à l'inférence embarquée envisagée pour le CNN, l'analyse via l'API Gemini nécessite l'envoi de l'image aux serveurs de Google et une connexion Internet active au moment du scan. En revanche, la bibliothèque ravageurs, l'historique des analyses et les fiches détaillées restent entièrement consultables hors ligne (section 9.7.4). Cette dépendance réseau est rediscutée parmi les limites en section 9.8.

---

## 9.7. Développement de l'application mobile AgroScan

### 9.7.1. Choix du framework Flutter

L'application est développée avec **Flutter** (Google, version 3.19) et le langage **Dart** (version 3.3). Flutter est un framework open-source permettant de générer des applications natives Android et iOS à partir d'une seule base de code. Ce choix est justifié par :

- un écosystème riche de paquets pour les besoins du projet : `http` (appels à l'API Gemini), `image_picker` (acquisition d'images), `drift` (base SQLite) et `flutter_riverpod` (gestion d'état) ;
- des performances proches du natif grâce à la compilation vers du code machine (AOT compilation) ;
- la capacité à cibler simultanément les appareils Android (majoritaires en Tunisie) et iOS.

### 9.7.2. Architecture logicielle

L'application suit les principes de la **Clean Architecture**, structurée en trois couches indépendantes :

- **Couche Données** (*Data layer*) : accès à la base de données SQLite (Drift), appels à l'API Gemini via le client `http` (`GeminiInferenceRepository`), lecture des fichiers JSON de la bibliothèque ravageurs ;
- **Couche Domaine** (*Domain layer*) : logique métier — règles de filtrage par culture, calcul des statistiques, règles de recommandation de lutte ;
- **Couche Présentation** (*Presentation layer*) : interfaces utilisateur Flutter, gestion d'état via Riverpod 2.x.

### 9.7.3. Pipeline d'inférence côté application

Le module d'inférence (`GeminiInferenceRepository`) suit les étapes suivantes, implémentées en Dart :

1. **Acquisition de l'image** : via le plugin `image_picker` (prise de vue par l'appareil photo ou sélection depuis la galerie) ;
2. **Prétraitement** : redimensionnement et compression JPEG de l'image, puis encodage en base64 pour la transmission HTTP ;
3. **Filtrage par culture en amont** : la culture sélectionnée par l'agriculteur détermine la liste des espèces candidates (table de correspondance culture → identifiants de ravageurs hôtes) ; cette liste est injectée dans le prompt pour **restreindre le périmètre de réponse** du modèle ;
4. **Inférence** : envoi d'une requête HTTP à l'API Gemini contenant l'image encodée et le prompt d'identification ; le modèle multimodal renvoie une réponse structurée (JSON) listant les espèces les plus probables, avec un score de confiance et une justification ;
5. **Post-traitement** : analyse (*parsing*) de la réponse, extraction des 3 candidats les plus probables (top-3) et mise en correspondance avec les fiches ravageurs locales ;
6. **Vérification de pertinence** : si la confiance maximale est inférieure à un seuil défini, l'application affiche un avertissement invitant à reprendre la photo dans de meilleures conditions.

### 9.7.4. Persistance locale

La bibliothèque de données locales est gérée par **Drift** (anciennement Moor), un ORM SQLite pour Flutter. Le schéma de base de données comprend trois tables :

- `Scans` : historique des analyses (date, culture, espèce identifiée, score de confiance, chemin de l'image) ;
- `CachedPests` : cache local des 40 fiches ravageurs (chargées depuis `assets/data/pests.json` au premier lancement) ;
- `FavoritePests` : liste des ravageurs marqués comme favoris par l'utilisateur.

Ces données de persistance restent sur l'appareil de l'utilisateur : la bibliothèque, l'historique et les favoris sont consultables intégralement hors ligne. Seule l'étape de détection elle-même nécessite une connexion, l'image étant alors transmise à l'API Gemini (voir la discussion sur la confidentialité et la dépendance réseau en sections 9.6.2 et 9.8).

### 9.7.5. AgroBot : assistant conversationnel guidé par l'IA

AgroScan intègre **AgroBot**, un assistant conversationnel permettant à l'agriculteur d'obtenir des informations complémentaires sur les ravageurs, les méthodes de lutte, les seuils d'intervention et les bonnes pratiques agronomiques, sous forme de dialogue en langage naturel.

#### Choix technologique : API Gemini (Google)

AgroBot repose sur l'**API Gemini** de Google, un modèle multimodal de grande taille capable de comprendre et de générer du texte en langage naturel dans plusieurs langues, dont le français et l'arabe. AgroScan mobilise ainsi l'API Gemini pour deux usages complémentaires : l'**analyse visuelle** des images de ravageurs (section 9.6.2) et le **dialogue en langage naturel** de l'assistant. Le dialogue sur un domaine agronomique vaste et évolutif bénéficie de la profondeur sémantique d'un modèle pré-entraîné sur de larges corpus textuels scientifiques et agronomiques, sans qu'aucun modèle conversationnel ne soit à entraîner ni à héberger localement.

#### Cadrage et guidage du modèle (prompt engineering)

L'un des défis majeurs de l'intégration d'un LLM dans une application agricole grand public est de maîtriser le périmètre des réponses générées. Un modèle de langage généraliste non contraint peut produire des réponses hors sujet, inexactes dans un contexte agronomique, voire potentiellement dangereuses (ex. : conseils phytosanitaires non adaptés aux réglementations tunisiennes). Pour y remédier, plusieurs mécanismes de contrôle ont été mis en place :

**Prompt système restrictif.** Un prompt système (*system prompt*) est injecté en amont de chaque conversation et définit explicitement le rôle, les limites et le comportement d'AgroBot. Il précise que le modèle est un assistant exclusivement dédié à l'agriculture et à la protection des cultures, et qu'il doit refuser toute question hors de ce périmètre. Le modèle est également instruit de rappeler à l'utilisateur de consulter un technicien agronome ou un service de la DGSVCIA pour toute décision phytosanitaire engageant des produits homologués.

**Liste de thèmes autorisés et refus explicite.** Le prompt système définit une liste de domaines dans lesquels AgroBot est autorisé à répondre : identification des ravageurs, cycles biologiques, symptômes de dégâts, méthodes de lutte (culturale, biologique, chimique, intégrée), seuils économiques d'intervention, bonnes pratiques agricoles, et questions sur les cultures couvertes par l'application. En dehors de ces thèmes, AgroBot est formellement instruit de décliner poliment et de rediriger l'utilisateur.

**Contextualisation géographique.** Le prompt injecte systématiquement le contexte agricole tunisien (cultures présentes, réglementations locales, espèces endémiques) afin que les réponses générées soient pertinentes pour les conditions nord-africaines et non pour d'autres contextes agricoles.

**Injection de la culture sélectionnée.** Si l'utilisateur a préalablement sélectionné un type de culture dans l'application (tomate, olivier, etc.), cette information est automatiquement transmise dans le contexte de la conversation, permettant à AgroBot de proposer des réponses ciblées sans que l'agriculteur ait besoin de le préciser.

#### Justification de l'approche et sécurité

Ce choix de guidage strict du modèle répond à plusieurs impératifs :

- **Sécurité agronomique** : éviter que l'application recommande des traitements inadaptés, des doses incorrectes, ou des produits non homologués en Tunisie ;
- **Pertinence pour l'utilisateur** : un agriculteur utilisant une application de protection des cultures n'attend pas des réponses sur d'autres domaines ; la spécialisation améliore la confiance et la lisibilité de l'outil ;
- **Maîtrise des coûts d'API** : en limitant les échanges au domaine agricole, on réduit le volume de tokens générés et la consommation de l'API ;
- **Conformité éthique** : un LLM non contraint pourrait produire des contenus inappropriés dans le contexte d'une application destinée à des agriculteurs, souvent peu familiarisés avec les limitations des IA génératives.

### 9.7.6. Fonctionnalités de l'application

| Fonctionnalité | Description |
|---|---|
| Scan par culture | L'agriculteur sélectionne sa culture parmi 8 types avant l'analyse, ce qui restreint les espèces candidates |
| Résultats de l'analyse | Top-3 prédictions avec scores de confiance, résumé en français, lien vers la fiche ravageur |
| Bibliothèque hors ligne | 40 fiches ravageurs consultables sans connexion : morphologie, biologie, méthodes de lutte |
| Historique | Toutes les analyses sauvegardées localement avec statistiques (plantes saines / infestées, top 3 ravageurs détectés) |
| AgroBot | Assistant conversationnel IA (API Gemini) strictement limité aux thèmes agricoles et phytosanitaires par prompt engineering |
| Multilingue | Interface disponible en français, anglais et arabe |
| Thème adaptatif | Mode clair et mode sombre selon les préférences de l'utilisateur |

---

## 9.8. Limites et difficultés rencontrées

La réalisation de ce projet a mis en évidence plusieurs limites qui méritent d'être exposées avec honnêteté, dans une perspective d'amélioration future.

**Déséquilibre de la base d'images et espèces rares.** Comme décrit en section 9.3.3, plusieurs espèces présentes en Tunisie sont insuffisamment documentées photographiquement. *Oligonychus afrasiaticus* (acarien du palmier), *Saissetia oleae* (cochenille noire de l'olivier) et *Oryctes elegans* (rhinocère du palmier) disposent de moins de 250 images, ce qui fragilise la base de référence visuelle servant à fiabiliser et à comparer les identifications pour ces espèces. Ce constat invite à des collectes de terrain ciblées dans les principales zones de production tunisiennes.

**Variabilité des conditions d'éclairage au champ.** Toute identification visuelle peut perdre en fiabilité lorsque l'image est prise dans des conditions difficiles (contrejour, ombre partielle, reflets sur feuillage brillant). Le recours à un modèle multimodal robuste atténue ce problème par rapport à un CNN entraîné sur des images standardisées, sans toutefois l'éliminer entièrement.

**Confusion entre espèces morphologiquement proches.** Certaines confusions entre espèces de même genre ou de morphologie similaire (aleurodes, thrips, noctuelles en premier stade larvaire) sont inhérentes à la tâche : même un entomologiste expérimenté peut avoir besoin d'un examen microscopique pour les distinguer. La présentation de plusieurs candidats (top-3) plutôt que d'une seule réponse permet à l'agriculteur de ne pas prendre une décision sur la base d'une identification trop incertaine.

**Absence de représentation de la diversité génotypique locale.** Les images de référence proviennent en grande majorité d'observations réalisées en Europe du Sud et au Maroc. Des variations morphologiques liées aux populations locales tunisiennes (coloration, taille) ne sont pas garanties d'être bien couvertes par la base actuelle.

**Dépendance à un service tiers et confidentialité.** L'inférence de production repose sur l'API Gemini, un service externe : la pérennité, les conditions tarifaires et l'évolution du modèle échappent au contrôle du projet, et l'analyse implique la transmission de l'image aux serveurs du fournisseur. Cette dépendance est à mettre en regard de la simplicité de mise en œuvre et de la robustesse obtenue.

**Dépendance au réseau et coût de l'inférence en production.** Le passage à l'API Gemini pour l'inférence visuelle (section 9.6.2) a permis de résoudre l'écart de performance en conditions réelles, au prix de deux contreparties : la nécessité d'une connexion Internet au moment du scan — limitation réelle dans les zones rurales tunisiennes mal couvertes — et un coût d'usage facturé à la requête, qui pose la question du modèle économique d'un déploiement à grande échelle. Une piste d'évolution consisterait à recourir à un modèle multimodal embarqué (*on-device*) dès que les capacités des smartphones d'entrée de gamme le permettront, afin de retrouver le fonctionnement hors ligne du prototype tout en conservant la robustesse du modèle multimodal.

---

## 9.9. Récapitulatif des outils et de l'environnement de développement

**Outils effectivement employés dans l'application livrée :**

| Outil / Technologie | Version | Usage dans le projet |
|---|---|---|
| Flutter | 3.19 | Développement de l'application mobile |
| Dart | 3.3 | Langage de programmation de l'application |
| `http` | 1.6 | Appels à l'API Gemini (requêtes REST) |
| `image_picker` | 1.1 | Acquisition des images (appareil photo, galerie) |
| Drift (SQLite ORM) | 2.20 | Persistance locale (historique, bibliothèque, favoris) |
| flutter_riverpod | 2.5 | Gestion d'état réactive dans l'application |
| API Gemini (Google) | 2.5 Flash | Moteur d'inférence visuelle en production (détection des ravageurs) + assistant conversationnel AgroBot — **accès payant souscrit** |
| Git / GitHub | — | Versionnement du code source |
| Android Studio | — | Tests sur émulateur Android et débogage |

**Outils relevant de l'étude de faisabilité du CNN (envisagés, non employés dans la version livrée) :**

| Outil / Technologie | Rôle dans l'étude exploratoire |
|---|---|
| Python / TensorFlow / Keras | Cadre d'entraînement envisagé pour l'architecture CNN (non mis en œuvre) |
| TensorFlow Lite / quantification INT8 | Chaîne de conversion et d'optimisation qui aurait été nécessaire pour un déploiement embarqué |
| Google Colab (GPU NVIDIA T4) | Environnement d'entraînement pressenti |

*Ces technologies sont citées pour documenter la démarche comparative ayant conduit au choix de l'API Gemini ; aucun modèle n'a été entraîné ni intégré à l'application.*

---

## Références bibliographiques complémentaires à cette section

- Tan, M., & Le, Q. V. (2019). EfficientNet: Rethinking Model Scaling for Convolutional Neural Networks. *Proceedings of the 36th International Conference on Machine Learning (ICML)*.
- Wu, X., Zhan, C., Lai, Y.-K., Cheng, M.-M., & Yang, J. (2019). IP102: A Large-Scale Benchmark Dataset for Insect Pest Recognition. *Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR)*, 8787–8796.
- Hughes, D. P., & Salathé, M. (2015). An open access repository of images on plant health to enable the development of mobile disease diagnostics. *arXiv preprint arXiv:1511.08060*.
- LeCun, Y., Bengio, Y., & Hinton, G. (2015). Deep Learning. *Nature*, 521(7553), 436–444.
- Howard, A. G., et al. (2019). Searching for MobileNetV3. *Proceedings of the IEEE/CVF International Conference on Computer Vision (ICCV)*, 1314–1324.
