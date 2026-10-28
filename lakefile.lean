import Lake
open Lake DSL

package localSmoothing where
  version := v!"0.1.0"
  fixedToolchain := true
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "d13f23b723b8a846827a245b89c10fc7d3f11612"

lean_lib OAI where
  roots := #[`OAI.Analysis.Fourier.LocalSmoothing.Comparator]
  globs := #[`OAI.+]

@[default_target] lean_lib LocalSmoothing

lean_lib ComparatorChallenges where
  roots := #[`ComparatorChallenges.LocalSmoothing]
