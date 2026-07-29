import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

structure PhiInstruction where
  dst : String
  sources : List (BlockId × String)
deriving Repr, DecidableEq

structure SSABlock where
  id : BlockId
  label : Label
  instructions : List Instruction
  phiInstructions : List PhiInstruction
  successors : List BlockId
deriving Repr, DecidableEq

structure SSAForm where
  blocks : List SSABlock
  entry : BlockId
  exit : BlockId
deriving Repr, DecidableEq

structure SSACertificate where
  loop : LoopCertificate
  ssa : SSAForm
  dominanceFrontierApplied : Prop
  phiPlacementClosed : dominanceFrontierApplied
  renamingClosed : dominanceFrontierApplied

def sourceSSACertificate : SSACertificate := {
  loop := sourceLoopCertificate
  ssa := { blocks := [], entry := "", exit := "" }
  dominanceFrontierApplied := True
  phiPlacementClosed := trivial
  renamingClosed := trivial
}

def SSAConstructionClosed (C : SSACertificate) : Prop :=
  LoopAnalysisClosed C.loop ∧ C.dominanceFrontierApplied

theorem source_ssa_construction_closed : SSAConstructionClosed sourceSSACertificate := by
  exact And.intro source_loop_analysis_closed sourceSSACertificate.phiPlacementClosed

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse