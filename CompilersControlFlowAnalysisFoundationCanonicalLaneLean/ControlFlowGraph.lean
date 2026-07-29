import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

abbrev BlockId := String
abbrev Label := String

inductive Instruction : Type where
  | assign (dst : String) (src : String) : Instruction
  | branch (cond : String) (tLabel fLabel : Label) : Instruction
  | jump (label : Label) : Instruction
  | ret (val : String) : Instruction
  | noop : Instruction
deriving Repr, DecidableEq

structure BasicBlock where
  id : BlockId
  label : Label
  instructions : List Instruction
  successors : List BlockId
deriving Repr, DecidableEq

structure ControlFlowGraph where
  blocks : List BasicBlock
  entry : BlockId
  exit : BlockId
deriving Repr, DecidableEq

def emptyCFG : ControlFlowGraph := {
  blocks := []
  entry := ""
  exit := ""
}

structure CFGProperty where
  reachabilityClosed : Prop
  dominanceClosed : Prop
  loopClosure : Prop
  sourceDefined : reachabilityClosed ∧ dominanceClosed ∧ loopClosure

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse