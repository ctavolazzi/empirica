# NovaSystem Unified Design - Multi-Agent Cognitive Architecture

**Date:** 2026-01-04
**Version:** 1.0.0
**Status:** Design Complete

---

## Framework Analysis Summary

### CrewAI - Role-Based Teams
**Strengths:**
- Clear role definition (agents have specific jobs)
- Deterministic backbone with intelligence where needed
- Task delegation built into framework
- Tools directly connected to agents
- Production-ready, fast execution

**Patterns:**
- Coordinator-Worker (planner breaks tasks for specialists)
- Collaborative Peer Group (agents refine each other's outputs)

**Limitations:**
- Constraining for complex orchestration beyond sequential/hierarchical
- Opinionated design limits customization

**When to Use:** Fast, production-ready team-based coordination

---

### AutoGen/AG2 - Conversational Agents
**Strengths:**
- Natural conversation-based interaction
- Strong human-in-the-loop support
- Event-driven architecture (AutoGen v0.4)
- Flexible multi-agent conversations

**Patterns:**
- Multi-agent dialogue
- Async event-driven communication
- Conversational state management

**Limitations:**
- Can be verbose for simple tasks
- AutoGen/AG2 split creates ecosystem fragmentation

**When to Use:** Human interaction, conversational workflows

---

### LangGraph - State Machine Graphs
**Strengths:**
- Fine-grained control over flow and state
- Flexible workflow patterns (single, multi-agent, hierarchical, sequential)
- Agents as graph nodes with transition logic
- Hierarchical teams (agents containing sub-agents)

**Patterns:**
- Supervisor Pattern (coordinator + specialized agents)
- Orchestrator-Worker
- Hierarchical Teams (nested agent graphs)

**Limitations:**
- More complex to set up initially
- Requires graph thinking/design

**When to Use:** Complex orchestration, custom control flow, stateful workflows

---

## Unified Design Principles

### 1. **State Management** (from LangGraph)
- Maintain explicit conversation state
- Track epistemic vectors across turns
- Persist state for continuity

### 2. **Role-Based Personas** (from CrewAI)
- Each agent has clear role definition
- Specialized capabilities per persona
- Tools/resources connected to personas

### 3. **Conversation-Based Flow** (from AutoGen)
- Turn-based dialogue between personas
- Natural information exchange
- Support for human-in-the-loop

### 4. **Deterministic + Intelligent** (from CrewAI)
- Deterministic orchestration backbone
- Intelligence applied at specific decision points
- Predictable flow with adaptive reasoning

### 5. **Hierarchical Coordination** (from LangGraph)
- DCE as supervisor/coordinator
- Domain experts as specialized workers
- CAE as quality gate/critic

### 6. **Epistemic Awareness** (unique to NovaSystem)
- Track knowledge vectors (know, uncertainty, context)
- Log findings/unknowns/dead-ends
- CASCADE workflow (PREFLIGHT → CHECK → POSTFLIGHT)

---

## NovaSystem Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ NovaProcess Orchestrator (Supervisor Pattern)              │
│ • Stateful conversation management                          │
│ • Turn-based execution                                      │
│ • Epistemic tracking                                        │
└─────────────────────────────────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        ▼                    ▼                    ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│ DCE          │    │ Domain       │    │ CAE          │
│ (Coordinator)│◄──►│ Experts      │◄──►│ (Critic)     │
│              │    │ (Workers)    │    │              │
└──────────────┘    └──────────────┘    └──────────────┘
        │                   │                    │
        └───────────────────┴────────────────────┘
                             │
                             ▼
                  ┌────────────────────┐
                  │ Epistemic State    │
                  │ • know             │
                  │ • uncertainty      │
                  │ • context          │
                  │ • findings         │
                  │ • unknowns         │
                  └────────────────────┘
```

---

## Conversation Flow (Unified Pattern)

### Standard Flow:
```
1. PREFLIGHT (Epistemic Baseline)
   ├─ Load prior context (bootstrap)
   ├─ Establish initial know/uncertainty/context
   └─ Identify knowledge gaps

2. DCE UNPACK (Coordinator)
   ├─ Clarify question/task
   ├─ Identify needed expertise
   └─ Frame investigation scope

3. EXPERTS ANALYZE (Workers - Parallel)
   ├─ Security Expert → security implications
   ├─ Architecture Expert → system design
   ├─ Performance Expert → efficiency concerns
   └─ [Domain-specific analysis]

4. DCE SYNTHESIZE (Coordinator)
   ├─ Integrate expert perspectives
   ├─ Identify conflicts/gaps
   └─ Form preliminary recommendation

5. CAE CRITIQUE (Quality Gate)
   ├─ Challenge assumptions
   ├─ Identify blind spots
   ├─ Stress-test reasoning

6. CHECK GATE (Epistemic Decision)
   ├─ IF uncertainty > 0.6 → INVESTIGATE (loop)
   ├─ IF uncertainty ≤ 0.6 → PROCEED
   └─ IF know > 0.8 AND uncertainty < 0.2 → FINALIZE

7. DCE FINAL (Coordinator)
   ├─ Incorporate CAE feedback
   ├─ Final recommendation
   └─ Document findings/unknowns

8. POSTFLIGHT (Learning Delta)
   ├─ Measure epistemic change
   ├─ Log findings/unknowns/dead-ends
   └─ Persist session state
```

---

## Design Patterns Applied

### 1. **Supervisor Pattern** (LangGraph)
- DCE acts as supervisor coordinating all personas
- Domain experts are specialized workers
- Clear delegation and synthesis

### 2. **Collaborative Peer Group** (CrewAI)
- Experts provide parallel analysis
- DCE synthesizes peer outputs
- CAE provides peer review

### 3. **Conversation-Based** (AutoGen)
- Turn-based dialogue
- Natural information flow
- Explicit message passing

### 4. **State Machine Control** (LangGraph)
- PREFLIGHT → UNPACK → ANALYZE → SYNTHESIZE → CRITIQUE → CHECK → FINAL → POSTFLIGHT
- State transitions based on epistemic gates
- Loop control via CHECK gate

### 5. **Deterministic Backbone** (CrewAI)
- Fixed conversation flow
- Predictable orchestration
- Intelligence applied at specific turns (not everywhere)

---

## Implementation Components

### 1. Persona Definition Files
**Location:** `.pyrite/personas/{core,experts}/`

**Core Personas:**
- `DCE.md` - Discussion Continuity Expert (Coordinator)
- `CAE.md` - Critical Analysis Expert (Critic)

**Domain Experts:**
- `security.md` - Security Expert
- `architecture.md` - Architecture Expert
- `performance.md` - Performance Expert
- `testing.md` - Testing Expert

**Format:**
```markdown
---
role: Security Expert
expertise: [security, vulnerabilities, threat modeling]
tools: [static analysis, OWASP guidelines]
---

# Security Expert Persona

You are a security expert specializing in...

## Capabilities
- Threat modeling
- Vulnerability assessment
- Security best practices

## Analysis Approach
1. Identify attack surfaces
2. Assess threat vectors
3. Recommend mitigations
```

### 2. NovaProcess Orchestrator
**Location:** `tools/nova-process/orchestrate.py`

**Core Classes:**
- `Persona` - Loads .md definition, executes LLM calls
- `NovaProcess` - Orchestrates conversation flow
- `EpistemicState` - Tracks know/uncertainty/context

**Key Methods:**
- `run(question)` - Execute full Nova Process
- `preflight()` - Establish baseline
- `check_gate()` - Epistemic decision
- `postflight()` - Learning delta

### 3. CLI Integration
**Command:** `pyrite nova <question>`

**Examples:**
```bash
# Run Nova Process on a question
pyrite nova "Should we refactor the authentication system?"

# Run with specific experts
pyrite nova --experts security,architecture "How to implement OAuth?"

# Resume from prior session
pyrite nova --resume session-123 "Continue analysis"

# Verbose mode (show all turns)
pyrite nova -v "What's the best caching strategy?"
```

### 4. State Persistence
**Location:** `.pyrite/sessions.db` (SQLite)

**Schema:**
```sql
CREATE TABLE sessions (
    id TEXT PRIMARY KEY,
    question TEXT,
    state TEXT,  -- JSON epistemic state
    transcript TEXT,  -- Full conversation
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
```

---

## Key Design Decisions

### 1. **Personas as Prompts (not Code)**
- **Why:** Flexibility, easy to edit, version control
- **Pattern:** CrewAI role definition + LangGraph agent nodes
- **Format:** Markdown with YAML frontmatter

### 2. **Turn-Based (not Fully Autonomous)**
- **Why:** Predictability, explainability, cost control
- **Pattern:** AutoGen conversation + CrewAI deterministic backbone
- **Flow:** Fixed orchestration sequence

### 3. **Epistemic Gates (not Just Task Completion)**
- **Why:** Self-aware investigation depth
- **Pattern:** Unique to NovaSystem (from Empirica)
- **Mechanism:** CHECK gate uses know/uncertainty thresholds

### 4. **Hierarchical but Not Nested**
- **Why:** Simpler implementation, clear roles
- **Pattern:** LangGraph supervisor + CrewAI coordinator-worker
- **Structure:** DCE coordinates, but experts don't spawn sub-agents

### 5. **Stateful but File-Based First**
- **Why:** Transparency, debuggability, simplicity
- **Pattern:** LangGraph state management
- **Storage:** SQLite for persistence, JSON for portability

---

## What We're Leaving Out (Consciously)

### From CrewAI:
- ❌ Full autonomous task planning (too unpredictable)
- ❌ Complex inter-agent delegation chains
- ✅ Role-based design
- ✅ Coordinator-worker pattern

### From AutoGen:
- ❌ Fully autonomous multi-agent chat (no clear endpoint)
- ❌ Complex human-in-the-loop flows (v1 can be async)
- ✅ Conversation-based interaction
- ✅ Message-passing architecture

### From LangGraph:
- ❌ Fully custom graph construction (too complex)
- ❌ Nested hierarchical teams (over-engineering)
- ✅ State machine flow control
- ✅ Supervisor pattern
- ✅ Stateful execution

---

## Success Metrics

| Metric | Target | Why |
|--------|--------|-----|
| Turn count | < 10 per question | Cost control, speed |
| Epistemic convergence | > 80% questions | Effective investigation |
| Time to first answer | < 30 seconds | User experience |
| State persistence | 100% | Continuity across sessions |
| Persona extensibility | New expert in < 10 min | Flexibility |

---

## Next Steps

1. ✅ Research complete
2. ✅ Unified design complete
3. **→ Create persona .md files**
4. **→ Build orchestrator**
5. **→ Integrate CLI**
6. **→ Test with sample questions**

---

## Sources

- [Agent Orchestration 2026: LangGraph, CrewAI & AutoGen Guide](https://iterathon.tech/blog/ai-agent-orchestration-frameworks-2026)
- [CrewAI Documentation](https://docs.crewai.com/)
- [GitHub - crewAIInc/crewAI](https://github.com/crewAIInc/crewAI)
- [LangGraph: Multi-Agent Workflows](https://blog.langchain.com/langgraph-multi-agent-workflows/)
- [GitHub - microsoft/autogen](https://github.com/microsoft/autogen)
- [AutoGen, AG2, and Semantic Kernel: Complete Guide](https://towardsai.net/p/machine-learning/autogen-ag2-and-semantic-kernel-complete-guide)

---

**Design Status: COMPLETE**
**Ready for Implementation: YES**
**Epistemic Self-Assessment:**
```yaml
know: 0.82
uncertainty: 0.18
context: 0.88
findings:
  - "Supervisor pattern + Conversation-based flow is optimal"
  - "Epistemic gates provide unique self-regulation"
  - "Personas as prompts offer best flexibility/simplicity tradeoff"
completion: 1.0
```
