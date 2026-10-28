# Local smoothing for the Euclidean wave equation

A standalone Lean project containing the six comparator results and their complete local import closure from `openai/math`. Copy this directory anywhere to build it; it does not depend on the parent repository. The 2,261 OAI modules are unchanged upstream sources. `SOURCE.json` records their hashes and the source commit.

## Build

Install Lean's `elan` toolchain manager, Git, and the platform's C build tools. Run from this directory:

```sh
lake update
lake exe cache get
lake build
```

`lean-toolchain` pins Lean 4.34.1, and `lakefile.lean` pins Mathlib to `d13f23b723b8a846827a245b89c10fc7d3f11612`. The generated `lake-manifest.json` locks transitive dependencies. Network access is needed for initial dependency and cache downloads. The proof dependency closure is substantial, so the first build can take considerable time and memory.

Use the results in another Lean file with:

```lean
import LocalSmoothing
open OAI.Analysis.Fourier.LocalSmoothing.Comparator
#check euclidean_local_smoothing
```

## Results

All six declarations are in namespace `OAI.Analysis.Fourier.LocalSmoothing.Comparator`.

| Result | Declaration |
| --- | --- |
| Euclidean half-wave local smoothing | `euclidean_local_smoothing` |
| Bochner–Riesz multiplier bounds uniform in the radius | `bochner_riesz` |
| Spherical restriction in extension form | `spherical_restriction` |
| Kakeya maximal estimate | `kakeya_maximal` |
| Full Hausdorff dimension of Euclidean Kakeya sets | `kakeya` |
| Stein square-function estimate | `stein_square` |

The proof implementation is [Comparator.lean](OAI/Analysis/Fourier/LocalSmoothing/Comparator.lean). The independent reference statements are [LocalSmoothing.lean](ComparatorChallenges/LocalSmoothing.lean). These two modules deliberately declare the same names: do not import them together. The reference contains six upstream `sorry` placeholders; the default build imports the proof implementation.

## Verification

After building, print the axioms used by each result:

```sh
lake env lean Audit.lean
```

For independent comparator verification, install `comparator`, `landrun`, and `lean4export` and put them on `PATH`, then run:

```sh
lake build ComparatorChallenges.LocalSmoothing
lake env comparator ComparatorChallenges/LocalSmoothing.json
```

The unchanged comparator configuration permits only `propext`, `Quot.sound`, and `Classical.choice`. A successful build alone is not a report that independent comparator verification passed.

Check the packaged sources against their recorded upstream hashes:

```sh
python3 verify_sources.py
```

## Provenance and license

Extracted from `openai/math` commit `7ef5c0cc5` for the October 25, 2026 preprint *Local smoothing for the Euclidean wave equation*. Exact revision and SHA-256 hashes are in `SOURCE.json`. The upstream Lean [Apache 2.0 license](LICENSE) is included. Mathlib and its dependencies retain their own licenses.
