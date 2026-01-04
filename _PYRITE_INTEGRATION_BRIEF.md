# _pyrite Integration Brief - Complete Context for New Session

**Date:** 2026-01-04
**Purpose:** Comprehensive brief for integrating Empirica + NovaSystem into _pyrite
**Target Repo:** `/tmp/_pyrite` (or wherever _pyrite is located)
**Current Repo:** `/home/user/empirica`

---

## Executive Summary

**Goal:** Integrate three cognitive architectures into one unified framework in the _pyrite repository:

1. **_pyrite** (v0.8.0-alpha) - Repository management toolkit with work tracking, linting, epistemic metadata
2. **Empirica** - Epistemic self-awareness system with 13D vectors, CASCADE workflow, loop control
3. **NovaSystem** - Multi-agent orchestration with DCE/CAE/Domain Experts using turn-based conversations

**Strategy:** Pull Empirica and NovaSystem components into _pyrite, creating a unified CLI that combines:
- Work effort tracking (WE-YYMMDD-xxxx)
- Epistemic metadata validation
- CASCADE workflow (PREFLIGHT → CHECK → POSTFLIGHT)
- Multi-agent investigation (NovaProcess)
- Bootstrap context continuity

---

## Current State Overview

### 1. _pyrite (v0.8.0-alpha) - COMPLETED Phase 1

**Location:** `/tmp/_pyrite/` (primary) or user's local _pyrite repo

**Completed Work:**
- ✅ Epistemic metadata schema (know, uncertainty, context vectors)
- ✅ Epistemic linter (`tools/epistemic-linter/check.py` - 280 lines)
- ✅ CLI integration (`pyrite epistemic <file>`)
- ✅ Test work effort with epistemic metadata (WE-260104-epst)
- ✅ Git committed to branch `feature/epistemic-foundation`

**File Structure:**
```
_pyrite/
├── pyrite                          # CLI entry point (v0.8.0-alpha)
├── tools/
│   ├── obsidian-linter/            # Markdown linting
│   ├── github-health-check/        # GitHub integration check
│   ├── structure-check/            # Repo structure validation
│   └── epistemic-linter/           # ✅ NEW - Epistemic metadata validation
│       ├── check.py                # 280 lines, zero dependencies
│       └── README.md               # Comprehensive docs
├── _work_efforts/
│   ├── WE-260104-epst/             # ✅ NEW - Test work effort
│   │   └── index.md                # With epistemic metadata
│   ├── checkpoints/                # Session journals
│   └── devlog.md                   # Activity log
├── .claude/
│   └── skills/
│       └── SessionStart.md         # Session startup hook
└── AGENTS.md                       # AI agent instructions
```

**Epistemic Schema (Implemented):**
```yaml
epistemic:
  # Required vectors [0.0-1.0]
  know: 0.65          # Knowledge level
  uncertainty: 0.35   # Doubt/ambiguity
  context: 0.75       # Available information

  # Optional lists
  findings:           # Discoveries
    - "What was learned"
  unknowns:           # Open questions
    - "What remains unclear"
  dead_ends:          # Failed approaches
    - "What didn't work and why"
```

**CLI Commands Available:**
```bash
pyrite lint --scope _work_efforts --fix      # Markdown linting
pyrite health                                 # GitHub health check
pyrite structure --fix                        # Structure validation
pyrite epistemic <file>                       # ✅ NEW - Epistemic check
```

**Known Issues to Fix:**
1. Help system broken (--help treated as filename)
2. No automated tests for epistemic linter
3. Only tested on 1 file (our own test case)
4. 27 existing work efforts have no epistemic metadata
5. Fragile custom YAML parser (may need PyYAML)

---

### 2. Empirica - TO BE INTEGRATED

**Location:** `/home/user/empirica/`

**Key Components to Port:**

#### A. Epistemic Vectors (13D System)
**File:** `empirica/core/vectors/epistemic_vectors.py`

**13 Dimensions:**
```python
know         # Understanding level [0.0-1.0]
do           # Action capability [0.0-1.0]
context      # Available information [0.0-1.0]
clarity      # Question/goal sharpness [0.0-1.0]
coherence    # Internal consistency [0.0-1.0]
signal       # Relevance/noise ratio [0.0-1.0]
density      # Information density [0.0-1.0]
state        # Investigation phase [0.0-1.0]
change       # Rate of learning [0.0-1.0]
completion   # Task progress [0.0-1.0]
impact       # Significance [0.0-1.0]
uncertainty  # Doubt/ambiguity [0.0-1.0]
engagement   # Investment level [0.0-1.0]
```

**Currently _pyrite uses 3 dimensions:** know, uncertainty, context
**Decision needed:** Expand to full 13D or keep minimal 3D?

#### B. CASCADE Workflow
**File:** `empirica/core/cascade/`

**Three Phases:**
```python
PREFLIGHT:
  - Establish epistemic baseline
  - Load bootstrap context from prior sessions
  - Identify knowledge gaps

CHECK (Gate Decision):
  - IF uncertainty > threshold → INVESTIGATE (loop back)
  - IF uncertainty ≤ threshold → PROCEED
  - IF know > 0.8 AND uncertainty < 0.2 → FINALIZE

POSTFLIGHT:
  - Measure learning delta (before vs. after)
  - Log findings/unknowns/dead-ends
  - Compress session to ~800 tokens for next bootstrap
```

**Integration Target:** `pyrite cascade preflight|check|postflight`

#### C. EpistemicLoopTracker
**File:** `empirica/core/sentinel/orchestrator.py` (lines 374-544)

**Status:** ⚠️ **WELL-DESIGNED BUT NEVER USED IN PRODUCTION**

**Purpose:** Prevent infinite investigation loops, enforce convergence

**Key Features:**
- Scope-based loop limits (global, per-agent, per-task)
- Convergence detection (epistemic delta < threshold)
- Automatic investigation termination

**Critical Finding:** This exists but is never instantiated in Empirica CLI!

**Decision needed:** Fix and integrate, or redesign?

#### D. Bootstrap Context
**File:** `empirica/core/bootstrap/`

**Purpose:** Session continuity - compress prior session to ~800 tokens

**Mechanism:**
1. Extract key findings/unknowns from previous session
2. Summarize epistemic state
3. Inject as context in next PREFLIGHT

**Integration Target:** `pyrite session start --resume <session-id>`

#### E. Cognitive Phase Detection
**File:** `empirica/core/signaling.py`

**Phases:**
```python
NOETIC    # Planning, abstract thinking
THRESHOLD # Investigation, exploration
PRAXIC    # Execution, action
```

**Function:** `infer_cognitive_phase_from_vectors(vectors) -> CognitivePhase`

**Uses vectors to determine:** Should we keep investigating or start building?

---

### 3. NovaSystem - DESIGNED, TO BE IMPLEMENTED

**Location (personas):** `/home/user/empirica/empirica/personas/` (just created)

**Multi-Agent Architecture:**

#### Design Research Completed ✅

Researched frameworks:
- **CrewAI**: Role-based teams, deterministic backbone, coordinator-worker pattern
- **AutoGen/AG2**: Conversation-based, event-driven, human-in-loop
- **LangGraph**: State machine graphs, supervisor pattern, hierarchical teams

**Unified Design Document:** `/home/user/empirica/NOVA_UNIFIED_DESIGN.md`

#### Chosen Patterns:

1. **Supervisor Pattern** (from LangGraph) - DCE coordinates all personas
2. **Role-Based Teams** (from CrewAI) - Clear persona definitions
3. **Conversation-Based** (from AutoGen) - Turn-based dialogue
4. **Deterministic Backbone** (from CrewAI) - Fixed orchestration flow
5. **Epistemic Gates** (unique to NovaSystem) - Self-regulated investigation depth

#### Persona Definitions Created ✅

**Core Personas:**
- `/home/user/empirica/empirica/personas/core/DCE.md` - Discussion Continuity Expert (Coordinator)
- `/home/user/empirica/empirica/personas/core/CAE.md` - Critical Analysis Expert (Critic)

**Domain Experts Needed:**
- `security.md` - Security analysis
- `architecture.md` - System design
- `performance.md` - Efficiency/scalability
- `testing.md` - QA and reliability

#### Conversation Flow:

```
1. PREFLIGHT (Epistemic Baseline)
   └─ Load bootstrap, establish know/uncertainty/context

2. DCE UNPACK (Coordinator)
   └─ Clarify question, identify needed expertise

3. EXPERTS ANALYZE (Workers - Parallel)
   ├─ Security Expert
   ├─ Architecture Expert
   └─ Performance Expert

4. DCE SYNTHESIZE (Coordinator)
   └─ Integrate expert perspectives, preliminary recommendation

5. CAE CRITIQUE (Quality Gate)
   └─ Challenge assumptions, identify blind spots

6. CHECK GATE (Epistemic Decision)
   ├─ IF uncertainty > 0.6 → INVESTIGATE (loop)
   └─ ELSE → PROCEED

7. DCE FINAL (Coordinator)
   └─ Incorporate CAE feedback, final recommendation

8. POSTFLIGHT (Learning Delta)
   └─ Log findings/unknowns, persist state
```

#### Implementation Needed:

**Files to Create:**
```
_pyrite/tools/nova-process/
├── orchestrate.py              # NovaProcess orchestrator
├── personas/
│   ├── core/
│   │   ├── DCE.md              # ✅ Created in empirica
│   │   └── CAE.md              # ✅ Created in empirica
│   └── experts/
│       ├── security.md         # TO CREATE
│       ├── architecture.md     # TO CREATE
│       ├── performance.md      # TO CREATE
│       └── testing.md          # TO CREATE
└── README.md
```

**Orchestrator Design:**
```python
class Persona:
    """Loads .md definition, executes LLM calls"""
    def __init__(self, path: Path)
    def analyze(self, context: str) -> str

class EpistemicState:
    """Tracks know/uncertainty/context across turns"""
    know: float
    uncertainty: float
    context: float
    findings: List[str]
    unknowns: List[str]

class NovaProcess:
    """Main orchestrator"""
    def __init__(self, personas: Dict[str, Persona])
    def run(self, question: str) -> Dict[str, Any]
    def preflight(self) -> None
    def check_gate(self) -> bool  # True = proceed, False = investigate
    def postflight(self) -> Dict[str, Any]
```

**CLI Integration Target:**
```bash
pyrite nova "Should we refactor authentication?"
pyrite nova --experts security,architecture "Implement OAuth?"
pyrite nova --resume session-123 "Continue analysis"
pyrite nova -v "What's best caching strategy?"  # verbose mode
```

---

## Integration Architecture (The Vision)

```
┌─────────────────────────────────────────────────────────────┐
│ _pyrite CLI (Unified Entry Point)                          │
│ ├─ pyrite lint             (existing)                       │
│ ├─ pyrite health           (existing)                       │
│ ├─ pyrite structure        (existing)                       │
│ ├─ pyrite epistemic        (✅ Phase 1 complete)            │
│ ├─ pyrite cascade          (→ from Empirica)                │
│ ├─ pyrite nova             (→ from NovaSystem)              │
│ └─ pyrite session          (→ from Empirica bootstrap)      │
└─────────────────────────────────────────────────────────────┘
                             ▼
        ┌────────────────────┴────────────────────┐
        │                                         │
        ▼                                         ▼
┌───────────────────┐                  ┌───────────────────┐
│ Empirica Core     │                  │ NovaSystem        │
│ (Embedded)        │                  │ (Embedded)        │
├───────────────────┤                  ├───────────────────┤
│ • 13D vectors     │                  │ • DCE (coord)     │
│ • CASCADE         │◄────────────────►│ • CAE (critic)    │
│ • Loop tracker    │  Epistemic State │ • Domain experts  │
│ • Bootstrap       │                  │ • Orchestrator    │
└───────────────────┘                  └───────────────────┘
        │                                         │
        └────────────────────┬────────────────────┘
                             ▼
                  ┌────────────────────┐
                  │ .pyrite/sessions.db│
                  │ (SQLite)           │
                  ├────────────────────┤
                  │ • Sessions         │
                  │ • Epistemic states │
                  │ • Findings         │
                  │ • Unknowns         │
                  │ • Transcripts      │
                  └────────────────────┘
```

---

## Phase 2 Implementation Plan

### Week 1-2: Embed Empirica Core

**1. Create Empirica Directory in _pyrite:**
```bash
mkdir -p _pyrite/empirica/core/{vectors,cascade,sentinel,bootstrap}
```

**2. Port Key Modules:**
- `epistemic_vectors.py` → `_pyrite/empirica/core/vectors/`
- `cascade_workflow.py` → `_pyrite/empirica/core/cascade/`
- `loop_tracker.py` → `_pyrite/empirica/core/sentinel/`
- `bootstrap.py` → `_pyrite/empirica/core/bootstrap/`
- `signaling.py` → `_pyrite/empirica/core/`

**3. Integrate with CLI:**
```python
# In pyrite CLI
def cmd_cascade(args):
    """Run CASCADE workflow phases"""
    phase = args[0] if args else 'preflight'
    # PREFLIGHT / CHECK / POSTFLIGHT

def cmd_session(args):
    """Manage sessions with bootstrap context"""
    # start / resume / list / show
```

**4. Create Sessions Database:**
```sql
-- .pyrite/sessions.db
CREATE TABLE sessions (
    id TEXT PRIMARY KEY,
    question TEXT,
    epistemic_state TEXT,  -- JSON
    transcript TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE findings (
    session_id TEXT,
    finding TEXT,
    persona TEXT,
    created_at TIMESTAMP
);

CREATE TABLE unknowns (
    session_id TEXT,
    unknown TEXT,
    persona TEXT,
    created_at TIMESTAMP
);

CREATE TABLE epistemic_snapshots (
    session_id TEXT,
    phase TEXT,  -- PREFLIGHT / CHECK / POSTFLIGHT
    vectors TEXT,  -- JSON (all 13D or 3D)
    created_at TIMESTAMP
);
```

**5. Test Integration:**
```bash
# Create new work effort with CASCADE
pyrite cascade preflight --we WE-260105-test
# ... do work ...
pyrite cascade check --we WE-260105-test
# ... continue or finalize ...
pyrite cascade postflight --we WE-260105-test
```

---

### Week 2-3: Embed NovaSystem

**1. Copy Persona Files:**
```bash
cp empirica/empirica/personas/core/* _pyrite/tools/nova-process/personas/core/
```

**2. Create Missing Domain Experts:**
- `security.md`
- `architecture.md`
- `performance.md`
- `testing.md`

**3. Build Orchestrator:**

**File:** `_pyrite/tools/nova-process/orchestrate.py`

**Core Implementation:**
```python
#!/usr/bin/env python3
"""
NovaProcess Orchestrator - Multi-agent investigation system
"""
import json
from pathlib import Path
from typing import Dict, List, Any
from dataclasses import dataclass, field

@dataclass
class EpistemicState:
    """Tracks epistemic state across conversation"""
    know: float = 0.0
    uncertainty: float = 1.0
    context: float = 0.0
    findings: List[str] = field(default_factory=list)
    unknowns: List[str] = field(default_factory=list)
    dead_ends: List[str] = field(default_factory=list)

    def to_dict(self) -> Dict[str, Any]:
        return {
            'know': self.know,
            'uncertainty': self.uncertainty,
            'context': self.context,
            'findings': self.findings,
            'unknowns': self.unknowns,
            'dead_ends': self.dead_ends
        }

class Persona:
    """Loads persona definition from .md file"""

    def __init__(self, path: Path):
        self.path = path
        self.name = path.stem
        self.role = ""
        self.expertise = []
        self.prompt = ""
        self._load()

    def _load(self):
        """Parse .md file with YAML frontmatter"""
        content = self.path.read_text()

        # Split frontmatter and body
        if content.startswith('---'):
            parts = content.split('---', 2)
            if len(parts) >= 3:
                # Parse YAML frontmatter (simple parsing)
                frontmatter = parts[1]
                self.prompt = parts[2].strip()

                # Extract key fields
                for line in frontmatter.split('\n'):
                    if line.startswith('role:'):
                        self.role = line.split(':', 1)[1].strip()
                    elif 'expertise' in line:
                        # Simple list parsing
                        pass  # TODO: proper YAML parsing

    def analyze(self, context: str, state: EpistemicState) -> str:
        """
        Execute persona analysis (placeholder for LLM call)

        In production: Call LLM API with persona prompt + context
        """
        # TODO: Real LLM integration
        # For now, placeholder
        return f"[{self.name} analysis of: {context}]"

class NovaProcess:
    """Main orchestrator for multi-agent investigation"""

    def __init__(self, persona_dir: Path):
        self.persona_dir = persona_dir
        self.personas = self._load_personas()
        self.state = EpistemicState()
        self.transcript = []

    def _load_personas(self) -> Dict[str, Persona]:
        """Load all persona definitions"""
        personas = {}

        # Load core personas
        core_dir = self.persona_dir / 'core'
        if core_dir.exists():
            for path in core_dir.glob('*.md'):
                persona = Persona(path)
                personas[persona.name] = persona

        # Load domain experts
        experts_dir = self.persona_dir / 'experts'
        if experts_dir.exists():
            for path in experts_dir.glob('*.md'):
                persona = Persona(path)
                personas[persona.name] = persona

        return personas

    def run(self, question: str) -> Dict[str, Any]:
        """
        Run full NovaProcess on a question

        Returns:
            {
                'recommendation': str,
                'epistemic_state': dict,
                'transcript': list,
                'findings': list,
                'unknowns': list
            }
        """
        # PREFLIGHT
        self.preflight()

        # 1. DCE UNPACK
        dce_unpack = self.personas['DCE'].analyze(question, self.state)
        self.transcript.append(('DCE', 'UNPACK', dce_unpack))

        # 2. EXPERTS ANALYZE (parallel in real implementation)
        expert_analyses = {}
        for name, persona in self.personas.items():
            if name not in ['DCE', 'CAE']:
                analysis = persona.analyze(question, self.state)
                expert_analyses[name] = analysis
                self.transcript.append((name, 'ANALYZE', analysis))

        # Update epistemic state (simple heuristic)
        self.state.know += 0.2
        self.state.uncertainty -= 0.2
        self.state.context += 0.3

        # 3. DCE SYNTHESIZE
        synthesis_context = f"Question: {question}\n\nExpert input: {expert_analyses}"
        dce_synthesis = self.personas['DCE'].analyze(synthesis_context, self.state)
        self.transcript.append(('DCE', 'SYNTHESIZE', dce_synthesis))

        # 4. CAE CRITIQUE
        cae_critique = self.personas['CAE'].analyze(dce_synthesis, self.state)
        self.transcript.append(('CAE', 'CRITIQUE', cae_critique))

        # Update epistemic state
        self.state.know += 0.1
        self.state.uncertainty -= 0.1

        # 5. CHECK GATE
        should_investigate = self.check_gate()

        if should_investigate:
            # In real implementation: loop back
            # For now: just note it
            self.state.unknowns.append("Further investigation recommended")

        # 6. DCE FINAL
        final_context = f"Synthesis: {dce_synthesis}\n\nCritique: {cae_critique}"
        dce_final = self.personas['DCE'].analyze(final_context, self.state)
        self.transcript.append(('DCE', 'FINAL', dce_final))

        # POSTFLIGHT
        delta = self.postflight()

        return {
            'recommendation': dce_final,
            'epistemic_state': self.state.to_dict(),
            'transcript': self.transcript,
            'findings': self.state.findings,
            'unknowns': self.state.unknowns,
            'learning_delta': delta
        }

    def preflight(self):
        """Establish epistemic baseline"""
        # Load bootstrap context if available
        # Initialize epistemic state
        pass

    def check_gate(self) -> bool:
        """
        Epistemic gate decision

        Returns:
            True if should INVESTIGATE (loop)
            False if should PROCEED
        """
        # Simple heuristic
        if self.state.uncertainty > 0.6:
            return True  # INVESTIGATE
        return False  # PROCEED

    def postflight(self) -> Dict[str, float]:
        """
        Measure learning delta

        Returns:
            {'know_delta': float, 'uncertainty_delta': float, ...}
        """
        # In real implementation: compare PREFLIGHT vs POSTFLIGHT state
        return {
            'know_delta': self.state.know,
            'uncertainty_delta': -self.state.uncertainty
        }

def main():
    import argparse

    parser = argparse.ArgumentParser(description='NovaProcess Orchestrator')
    parser.add_argument('question', help='Question to investigate')
    parser.add_argument('--verbose', '-v', action='store_true')

    args = parser.parse_args()

    # Find persona directory
    script_dir = Path(__file__).parent
    persona_dir = script_dir / 'personas'

    # Run NovaProcess
    nova = NovaProcess(persona_dir)
    result = nova.run(args.question)

    # Output
    if args.verbose:
        print(json.dumps(result, indent=2))
    else:
        print(result['recommendation'])

if __name__ == '__main__':
    main()
```

**4. Integrate with CLI:**
```python
# In pyrite CLI
def cmd_nova(args):
    """Run NovaProcess multi-agent investigation"""
    repo_root = get_repo_root()
    script = repo_root / "tools" / "nova-process" / "orchestrate.py"
    return run_tool(script, args)
```

**5. Test:**
```bash
pyrite nova "Should we refactor the authentication system?"
pyrite nova -v "What's the best caching strategy?"
```

---

### Week 3-4: Unification & Testing

**1. Unified Workflow:**
```bash
# Create work effort
pyrite cascade preflight --we WE-260105-auth

# Investigate with NovaProcess
pyrite nova "Should we refactor authentication?" --we WE-260105-auth

# Check epistemic state
pyrite cascade check --we WE-260105-auth

# Finalize
pyrite cascade postflight --we WE-260105-auth
```

**2. Fix Phase 1 Issues:**
- Implement proper --help support
- Add automated tests for epistemic linter
- Test on all 27 existing work efforts
- Add auto-fix mode for invalid vectors
- Consider PyYAML for robustness

**3. Create Comprehensive Tests:**
```python
# tests/test_nova_process.py
def test_nova_process_basic():
    """Test basic NovaProcess execution"""

def test_epistemic_gate():
    """Test CHECK gate logic"""

def test_bootstrap_continuity():
    """Test session resumption"""
```

**4. Documentation:**
- Update AGENTS.md with NovaProcess workflow
- Create comprehensive examples
- Document CLI usage patterns

---

## Key Design Decisions Summary

### 1. Epistemic Dimensions
**Decision needed:** 3D (know, uncertainty, context) vs. full 13D?

**Recommendation:** Start with 3D, expand to 13D incrementally
- Phase 2: Add 3D (completion, clarity, coherence)
- Phase 3: Full 13D if needed

### 2. EpistemicLoopTracker
**Issue:** Exists in Empirica but never used

**Recommendation:** Redesign for NovaProcess CHECK gate
- Integrate loop limits into CHECK phase
- Track investigation depth per work effort
- Enforce convergence

### 3. Personas as Prompts vs. Code
**Decision:** Markdown .md files with YAML frontmatter

**Rationale:**
- Easy to edit and version control
- Non-technical users can create personas
- Flexible, no code changes needed

### 4. LLM Integration
**Current:** Placeholder (returns mock responses)

**TODO:** Integrate real LLM API
- OpenAI API
- Anthropic Claude API
- Local models (Ollama, etc.)

**Decision:** Make LLM backend configurable

### 5. State Persistence
**Format:** SQLite (`.pyrite/sessions.db`)

**Why:**
- Lightweight, no external dependencies
- SQL queries for analysis
- Portable (single file)

---

## File Inventory (What Exists Where)

### In Empirica Repo (`/home/user/empirica/`)

**Created Today:**
- `/home/user/empirica/NOVA_UNIFIED_DESIGN.md` - Complete design doc
- `/home/user/empirica/empirica/personas/core/DCE.md` - DCE persona
- `/home/user/empirica/empirica/personas/core/CAE.md` - CAE persona
- `/home/user/empirica/_PYRITE_INTEGRATION_BRIEF.md` - This file

**Existing (to port):**
- `empirica/core/vectors/epistemic_vectors.py` - 13D vectors
- `empirica/core/cascade/` - CASCADE workflow
- `empirica/core/sentinel/orchestrator.py` - EpistemicLoopTracker (lines 374-544)
- `empirica/core/bootstrap/` - Session continuity
- `empirica/core/signaling.py` - Cognitive phase detection

### In _pyrite Repo (`/tmp/_pyrite/`)

**Completed (Phase 1):**
- `pyrite` - CLI v0.8.0-alpha
- `tools/epistemic-linter/check.py` - Epistemic metadata validator
- `tools/epistemic-linter/README.md` - Documentation
- `_work_efforts/WE-260104-epst/index.md` - Test work effort

**To Create (Phase 2):**
- `empirica/` - Embedded Empirica core
- `tools/nova-process/orchestrate.py` - NovaProcess orchestrator
- `tools/nova-process/personas/` - Persona definitions
- `.pyrite/sessions.db` - SQLite state database

---

## Success Metrics

| Metric | Target | Why |
|--------|--------|-----|
| CLI integration | All 3 systems in one CLI | Unified UX |
| Epistemic tracking | Work efforts → Sessions | Continuity |
| NovaProcess response time | < 30 seconds | Usability |
| Bootstrap compression | ~800 tokens | Cost efficiency |
| Persona extensibility | New expert in < 10 min | Flexibility |
| Test coverage | > 80% | Reliability |

---

## Commands to Run in New _pyrite Session

### 1. Navigate to _pyrite
```bash
cd /tmp/_pyrite  # or wherever _pyrite is
```

### 2. Check Current State
```bash
./pyrite --version  # Should show v0.8.0-alpha
./pyrite epistemic _work_efforts/WE-260104-epst/index.md  # Test existing
git branch  # Should be on feature/epistemic-foundation or similar
git log --oneline -5  # See recent commits
```

### 3. Verify Phase 1 Completion
```bash
# Test epistemic linter
./pyrite epistemic _work_efforts/WE-260104-epst/index.md

# Check for issues
python3 tools/epistemic-linter/check.py --help  # Should NOT error
```

### 4. Start Phase 2 (Empirica Integration)
```bash
# Create directory structure
mkdir -p empirica/core/{vectors,cascade,sentinel,bootstrap}

# Copy Empirica modules from /home/user/empirica/
# (see file paths above)
```

### 5. Start Phase 2.5 (NovaSystem Integration)
```bash
# Create NovaProcess directory
mkdir -p tools/nova-process/personas/{core,experts}

# Copy persona files from /home/user/empirica/empirica/personas/
cp /home/user/empirica/empirica/personas/core/* tools/nova-process/personas/core/
```

---

## Questions to Resolve

### Technical
1. **3D vs 13D epistemic vectors?** Start with 3D, expand later
2. **LLM backend?** OpenAI, Anthropic, Ollama, or configurable?
3. **EpistemicLoopTracker redesign?** Integrate into CHECK gate or separate?
4. **YAML parser?** Keep custom or switch to PyYAML?
5. **Session storage?** SQLite only or also JSON export?

### Process
1. **Git strategy?** New branch or continue `feature/epistemic-foundation`?
2. **Testing approach?** Unit tests first or integration tests first?
3. **Migration path?** How to upgrade existing 27 work efforts?
4. **Documentation?** Update incrementally or all at end?

---

## Epistemic Self-Assessment of This Brief

```yaml
know: 0.88
uncertainty: 0.12
context: 0.95
findings:
  - "Phase 1 (_pyrite epistemic linter) is complete and committed"
  - "NovaSystem design is complete with persona definitions created"
  - "Empirica core modules are identified and ready to port"
  - "Integration architecture is well-defined"
  - "All three systems can unify cleanly via _pyrite CLI"
unknowns:
  - "Should we use 3D or 13D epistemic vectors in Phase 2?"
  - "Which LLM backend should be the default?"
  - "How to handle EpistemicLoopTracker redesign?"
completion: 0.95
```

**This brief is COMPREHENSIVE and READY for use in a new _pyrite session.**

---

## Quick Start Prompt for New Session

**Copy-paste this into new _pyrite session:**

```
I'm working on integrating three cognitive architectures into _pyrite:

1. _pyrite (v0.8.0-alpha) - Repository management with epistemic metadata (Phase 1 COMPLETE)
2. Empirica - 13D epistemic vectors, CASCADE workflow, loop control (TO INTEGRATE)
3. NovaSystem - Multi-agent orchestration with DCE/CAE/experts (TO IMPLEMENT)

Phase 1 (COMPLETE):
- ✅ Epistemic linter (tools/epistemic-linter/check.py)
- ✅ CLI integration (pyrite epistemic <file>)
- ✅ Test work effort (WE-260104-epst)
- ✅ Git committed to feature/epistemic-foundation

Phase 2 (NEXT):
- Embed Empirica core modules (vectors, cascade, bootstrap)
- Build NovaProcess orchestrator (multi-agent investigation)
- Integrate via pyrite CLI (cascade, nova, session commands)
- Create .pyrite/sessions.db for state persistence

I have a comprehensive integration brief at:
/home/user/empirica/_PYRITE_INTEGRATION_BRIEF.md

Please read this brief and help me with Phase 2 integration. Start by:
1. Reviewing current _pyrite state
2. Creating empirica/ directory structure
3. Copying persona files from empirica repo
4. Building NovaProcess orchestrator

Key files to reference:
- Empirica personas: /home/user/empirica/empirica/personas/core/{DCE,CAE}.md
- Design doc: /home/user/empirica/NOVA_UNIFIED_DESIGN.md
- Current _pyrite CLI: ./pyrite

Let's build the unified cognitive architecture!
```

---

**End of Brief**

Sources:
- [Agent Orchestration 2026 Guide](https://iterathon.tech/blog/ai-agent-orchestration-frameworks-2026)
- [CrewAI Documentation](https://docs.crewai.com/)
- [LangGraph Multi-Agent Workflows](https://blog.langchain.com/langgraph-multi-agent-workflows/)
- [AutoGen Framework](https://github.com/microsoft/autogen)
