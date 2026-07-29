import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisFoundationCanonicalLaneLean

structure DataFlowLattice (α : Type) where
  bot : α
  top : α
  join : α → α → α
  le : α → α → Prop
  joinCommutative : ∀ a b, join a b = join b a
  joinAssociative : ∀ a b c, join (join a b) c = join a (join b c)
  joinIdempotent : ∀ a, join a a = a
  joinBot : ∀ a, join a bot = a
  joinTop : ∀ a, join a top = top

def transferFunction (block : BasicBlock) (inState : α) : α := inState

structure DataFlowProblem (α : Type) where
  cfg : ControlFlowGraph
  lattice : DataFlowLattice α
  direction : String -- "forward" or "backward"
  initialStates : BlockId → α
  transfer : BasicBlock → (α → α)
  meetOverPaths : Prop
  solutionUnique : Prop
  meetClosed : meetOverPaths
  uniqueClosed : solutionUnique

def sourceDataFlowProblem (α : Type) (L : DataFlowLattice α) : DataFlowProblem α := {
  cfg := emptyCFG
  lattice := L
  direction := "forward"
  initialStates := λ _ => L.bot
  transfer := λ block => transferFunction block
  meetOverPaths := True
  solutionUnique := True
  meetClosed := trivial
  uniqueClosed := trivial
}

end CompilersControlFlowAnalysisFoundationCanonicalLaneLean
end HautevilleHouse