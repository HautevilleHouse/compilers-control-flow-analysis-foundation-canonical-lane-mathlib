import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Vector

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

-- Basic types for control flow analysis

abbrev Label : Type := Fin 256
abbrev VarName : Type := String

-- A basic block is a sequence of instructions (represented by a string for simplicity)
structure BasicBlock where
  label : Label
  instructions : List String
  successors : List Label

def emptyBasicBlock : BasicBlock := {
  label := ⟨0, by decide⟩,
  instructions := [],
  successors := []
}

-- Control Flow Graph
structure ControlFlowGraph where
  entry : Label
  exit : Label
  blocks : List BasicBlock
  blocksNonempty : blocks ≠ []

def primitiveCFG : ControlFlowGraph := {
  entry := ⟨0, by decide⟩,
  exit := ⟨1, by decide⟩,
  blocks := [
    { label := ⟨0, by decide⟩, instructions := ["x := 1"], successors := [⟨1, by decide⟩] },
    { label := ⟨1, by decide⟩, instructions := ["return x"], successors := [] }
  ],
  blocksNonempty := by simp
}

-- Dominator relation: node a dominates node b if every path from entry to b goes through a
structure DominatorTree where
  dominators : Label → Label → Prop
  reflexive : ∀ l, dominators l l
  transitive : ∀ a b c, dominators a b → dominators b c → dominators a c
  entryDominates : ∀ l, dominators (primitiveCFG.entry) l
  properDominance : ∀ {a b}, a ≠ b → dominators a b → True

definition simpleDomTree : DominatorTree := {
  dominators := λ a b => a = b ∨ a = primitiveCFG.entry,
  reflexive := λ l => Or.inl rfl,
  transitive := λ a b c h1 h2 => 
    match h1, h2 with
    | Or.inl ha, Or.inl hb => Or.inl (ha.trans hb)
    | Or.inl ha, Or.inr hb => Or.inr hb
    | Or.inr ha, _ => Or.inr ha,
  entryDominates := λ l => Or.inr rfl,
  properDominance := λ h _ => trivial
}

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse