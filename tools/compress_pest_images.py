"""
Compresses pest images from the dataset folder into Flutter assets.
- Resizes to max 900×900 px (preserves aspect ratio)
- Saves as JPEG quality 72 (~60-90 KB target)
- Outputs to assets/images/pests/{scientific_name_snake}/image_NN.jpg
- Prints a JSON mapping for pests.json patching
"""

import os
import sys
import json
import shutil
from pathlib import Path
from PIL import Image

# Usage: python tools/compress_pest_images.py <dataset_folder>
DATASET = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("dataset")
ASSETS_OUT = Path(__file__).resolve().parent.parent / "assets" / "images" / "pests"
MAX_DIM = 900
JPEG_QUALITY = 72

def folder_to_key(folder_name: str) -> str:
    """'01_Aonidiella_aurantii' → 'aonidiella_aurantii'"""
    parts = folder_name.split("_", 1)
    return parts[1].lower() if len(parts) > 1 else folder_name.lower()

def compress_image(src: Path, dst: Path):
    with Image.open(src) as img:
        img = img.convert("RGB")
        w, h = img.size
        if w > MAX_DIM or h > MAX_DIM:
            ratio = MAX_DIM / max(w, h)
            img = img.resize((int(w * ratio), int(h * ratio)), Image.LANCZOS)
        img.save(dst, "JPEG", quality=JPEG_QUALITY, optimize=True)

mapping = {}  # key (snake) → list of asset paths

folders = sorted(DATASET.iterdir())
for folder in folders:
    if not folder.is_dir():
        continue

    key = folder_to_key(folder.name)
    out_dir = ASSETS_OUT / key
    out_dir.mkdir(parents=True, exist_ok=True)

    images = sorted(
        [f for f in folder.iterdir() if f.suffix.lower() in (".jpg", ".jpeg", ".png", ".webp")],
        key=lambda f: f.name.lower(),
    )

    asset_paths = []
    for idx, src in enumerate(images, start=1):
        dst = out_dir / f"image_{idx:02d}.jpg"
        try:
            compress_image(src, dst)
            size_kb = dst.stat().st_size // 1024
            asset_paths.append(f"assets/images/pests/{key}/image_{idx:02d}.jpg")
            print(f"  [{idx}/{len(images)}] {src.name} -> image_{idx:02d}.jpg ({size_kb} KB)")
        except Exception as e:
            print(f"  ERROR {src.name}: {e}", file=sys.stderr)

    mapping[key] = asset_paths
    print(f"OK {folder.name} -> {key}/ ({len(asset_paths)} images)")

# Write mapping JSON next to this script for the patching step
out_json = Path(__file__).parent / "pest_image_mapping.json"
with open(out_json, "w", encoding="utf-8") as f:
    json.dump(mapping, f, indent=2, ensure_ascii=False)

print(f"\nDone. Mapping written to {str(out_json)}")
