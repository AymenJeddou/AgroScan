# AgroScan

Application mobile **Flutter** de détection des ravageurs agricoles en Afrique
du Nord (Tunisie, Maroc, Algérie). On photographie une feuille, une plante ou un
insecte, et l'application identifie, via Google Gemini, lequel des 40 ravageurs
connus il s'agit, puis affiche des conseils de traitement et une fiche complète.
Disponible en **français, anglais et arabe**, avec mode clair et sombre.

## Fonctionnalités

- Analyse par IA (Gemini 2.5 Flash) adaptée à la culture scannée
- Bibliothèque de 40 ravageurs : taxonomie, cycle de vie, symptômes, dégâts,
  prévention, lutte biologique / chimique / mécanique
- Filtres par culture, ordre, milieu et statut (favoris, quarantaine, polyphage)
- Historique des analyses local (hors-ligne, Drift / SQLite)
- 3 langues (FR / EN / AR) et thème sombre

## Prérequis

- Flutter SDK (Dart `^3.11.3`)
- Une clé API Google Gemini — https://aistudio.google.com/app/apikey

## Installation

```bash
git clone https://github.com/AymenJeddou/AgroScan.git
cd AgroScan
flutter pub get
```

## Configuration de la clé API

La clé n'est **jamais** stockée dans le code source : elle est injectée à la
compilation via `--dart-define`.

```bash
# Copier le modèle puis y coller votre vraie clé
cp key.env.example key.env        # PowerShell : Copy-Item key.env.example key.env
# éditer key.env -> GEMINI_KEY=votre_vraie_cle
```

> `key.env` est ignoré par Git et ne doit jamais être commité.

## Lancer en mode débogage

```bash
flutter run --dart-define=GEMINI_KEY=votre_vraie_cle
```

## Construire un APK de test

Le script lit la clé depuis `key.env`, génère des APK séparés par architecture
et obfusque le code :

```powershell
.\build_release.ps1
```

Sortie : `build/app/outputs/flutter-apk/`
À partager : **`app-arm64-v8a-release.apk`** (compatible avec la quasi-totalité
des téléphones récents).

## Synchronisation cloud (optionnelle)

L'historique reste local par défaut. Pour activer la synchronisation Supabase,
ajoutez à la commande `flutter run` / `flutter build` :

```bash
--dart-define=SUPABASE_URL=https://votre-projet.supabase.co --dart-define=SUPABASE_ANON_KEY=votre_cle_anon
```

Sans ces deux valeurs, Supabase n'est pas initialisé et l'application reste 100 % hors-ligne.

## Outils (`tools/`)

- `compress_pest_images.py <dossier_dataset>` : redimensionne et compresse les
  photos du dataset vers `assets/images/pests/` (nécessite Pillow)
- `patch_pests_json.py` : met à jour `assets/data/pests.json` avec les chemins
  d'images générés (`pest_image_mapping.json`)

## Architecture & stack

- **Clean Architecture**, structure par fonctionnalité (`feature-first`)
- UI : Flutter (Dart) · État : Riverpod · IA : Gemini 2.5 Flash (HTTP)
- Base locale : Drift / SQLite

## Note de sécurité

L'APK de release contient la clé compilée (obfusquée). L'obfuscation n'est pas du
chiffrement : une personne déterminée peut toujours l'extraire. C'est acceptable
pour partager des builds de test en privé, mais **ne publiez pas** l'APK ni la
clé. Pour une diffusion large, déplacez la clé derrière un backend.
