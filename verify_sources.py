"""Verify the vendored upstream files without needing the parent repository."""
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parent
manifest = json.loads((root / 'SOURCE.json').read_text())
failures = []
for name, expected in manifest['sha256'].items():
    path = root / name
    if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != expected:
        failures.append(name)
if failures:
    raise SystemExit('Missing or modified upstream files:\n' + '\n'.join(failures))
print(f"Verified {len(manifest['sha256'])} upstream files at {manifest['revision']}")
