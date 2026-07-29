import canonicalLaneMathlib.AdmissibleClass
import CompilersControlFlowAnalysisFoundationCanonicalLaneLean.FixedPointSolver

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

def ConstrainedCFAClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_cfa_closure (A : AdmissibleClass) :
    ConstrainedCFAClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse