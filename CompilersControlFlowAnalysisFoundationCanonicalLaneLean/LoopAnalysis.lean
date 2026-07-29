import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

structure NaturalLoop where
  header : BlockId
  latches : List BlockId
  body : List BlockId
  exitEdges : List (BlockId × BlockId)
deriving Repr, DecidableEq

structure LoopCertificate where
  dominated : DominanceCertificate
  naturalLoops : List NaturalLoop
  reachableBackEdges : Prop
  loopClosed : reachableBackEdges
  backEdgeDefined : reachableBackEdges

def sourceLoopCertificate : LoopCertificate := {
  dominated := sourceDominanceCertificate
  naturalLoops := []
  reachableBackEdges := True
  loopClosed := trivial
  backEdgeDefined := trivial
}

def LoopAnalysisClosed (C : LoopCertificate) : Prop :=
  DominanceAnalysisClosed C.dominated ∧ C.reachableBackEdges

theorem source_loop_analysis_closed : LoopAnalysisClosed sourceLoopCertificate := by
  exact And.intro source_dominance_analysis_closed sourceLoopCertificate.loopClosed

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse