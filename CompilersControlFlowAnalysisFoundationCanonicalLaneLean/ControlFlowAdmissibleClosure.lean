import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

structure ControlFlowAdmissibleClass (A : AdmissibleClass) where
  bridgeClosed : bridgeClosed A
  gateClosed : gateClosed A

def ConstrainedControlFlowClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_control_flow_endgame (A : AdmissibleClass) : ConstrainedControlFlowClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse