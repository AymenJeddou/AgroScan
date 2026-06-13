"""
Patches pests.json: sets image_url to local asset path for first image,
adds local_images array for all images.
"""
import json
from pathlib import Path

ROOT = Path(r"C:\Users\whotf\OneDrive\Bureau\InsectDetectionProject")
PESTS_JSON = ROOT / "assets" / "data" / "pests.json"
MAPPING_JSON = Path(__file__).parent / "pest_image_mapping.json"

with open(PESTS_JSON, encoding="utf-8") as f:
    pests = json.load(f)

with open(MAPPING_JSON, encoding="utf-8") as f:
    mapping = json.load(f)

patched = 0
for pest in pests:
    key = pest["scientific_name"].lower().replace(" ", "_")
    images = mapping.get(key, [])
    if images:
        pest["image_url"] = images[0]
        pest["local_images"] = images
        patched += 1
    else:
        print(f"WARNING: no images found for {pest['scientific_name']} (key={key})")

with open(PESTS_JSON, "w", encoding="utf-8") as f:
    json.dump(pests, f, ensure_ascii=False, indent=2)

print(f"Patched {patched}/40 pests in pests.json")
