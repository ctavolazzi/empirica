# Quick Start: Install Empirica into _pyrite

**Goal:** Install Empirica modules into _pyrite with proper MIT license attribution

---

## Step 1: Run Installation Script

```bash
cd /home/user/empirica

# If _pyrite is at /tmp/_pyrite:
./INSTALL_EMPIRICA_TO_PYRITE.sh /tmp/_pyrite

# Or specify custom path:
./INSTALL_EMPIRICA_TO_PYRITE.sh /path/to/_pyrite
```

## What the Script Does

1. ✅ **Copies Empirica core modules:**
   - `empirica/core/vectors/` → Epistemic vectors (13D)
   - `empirica/core/cascade/` → CASCADE workflow
   - `empirica/core/sentinel/` → EpistemicLoopTracker
   - `empirica/core/bootstrap/` → Session continuity
   - `empirica/core/signaling.py` → Cognitive phase detection

2. ✅ **Copies NovaSystem personas:**
   - `tools/nova-process/personas/core/DCE.md`
   - `tools/nova-process/personas/core/CAE.md`

3. ✅ **Creates attribution:**
   - `empirica/ATTRIBUTION.md` with full MIT license
   - Credits Empirica Team properly

4. ✅ **Creates stubs:**
   - `empirica/__init__.py` for Python imports

---

## Step 2: Verify Installation

```bash
cd /tmp/_pyrite  # or your _pyrite path

# Check directory structure
ls -la empirica/core/
ls -la tools/nova-process/personas/

# Read attribution
cat empirica/ATTRIBUTION.md

# Verify current _pyrite version
./pyrite --version  # Should show v0.8.0-alpha
```

---

## Step 3: Start Integration (in _pyrite repo)

Now you can start a new Claude session in _pyrite with this prompt:

```
I'm integrating Empirica and NovaSystem into _pyrite.

Phase 1 (COMPLETE):
- ✅ Epistemic linter (tools/epistemic-linter/)
- ✅ CLI integration (pyrite epistemic)

Phase 2 (JUST INSTALLED):
- ✅ Empirica core modules copied to empirica/
- ✅ NovaSystem personas copied to tools/nova-process/personas/
- ✅ Attribution documented in empirica/ATTRIBUTION.md

Next tasks:
1. Integrate Empirica into pyrite CLI (pyrite cascade, pyrite session)
2. Build NovaProcess orchestrator (tools/nova-process/orchestrate.py)
3. Create .pyrite/sessions.db for state persistence
4. Test unified workflow

Key files:
- Integration brief: _PYRITE_INTEGRATION_BRIEF.md (to be copied)
- NovaSystem design: NOVA_UNIFIED_DESIGN.md (to be copied)
- Current CLI: ./pyrite

Let's build the pyrite cascade and pyrite nova commands!
```

---

## Step 4: Copy Documentation (Optional)

```bash
# From empirica repo, copy design docs to _pyrite
cp /home/user/empirica/_PYRITE_INTEGRATION_BRIEF.md /tmp/_pyrite/
cp /home/user/empirica/NOVA_UNIFIED_DESIGN.md /tmp/_pyrite/
```

---

## What You Get

After installation, _pyrite will have:

```
_pyrite/
├── empirica/                    # ✅ Empirica core (embedded)
│   ├── ATTRIBUTION.md           # ✅ MIT license + credits
│   ├── __init__.py              # ✅ Python package
│   └── core/
│       ├── vectors/             # 13D epistemic tracking
│       ├── cascade/             # PREFLIGHT/CHECK/POSTFLIGHT
│       ├── sentinel/            # Loop control
│       ├── bootstrap/           # Session continuity
│       └── signaling.py         # Cognitive phase detection
├── tools/
│   ├── epistemic-linter/        # ✅ From Phase 1
│   └── nova-process/
│       └── personas/            # ✅ DCE/CAE persona definitions
│           ├── core/            # DCE.md, CAE.md
│           ├── experts/         # (to be created)
│           └── README.md        # ✅ Persona documentation
├── pyrite                       # CLI (to be enhanced)
└── _work_efforts/               # Work tracking

TO CREATE:
- tools/nova-process/orchestrate.py  # NovaProcess orchestrator
- .pyrite/sessions.db                # SQLite state storage
- Updated pyrite CLI with cascade/nova/session commands
```

---

## License Compliance

✅ **MIT License Compliant**

- Empirica is MIT licensed (very permissive)
- Full license text in `empirica/ATTRIBUTION.md`
- Credits Empirica Team prominently
- Modifications (if any) will be documented in ATTRIBUTION.md

---

## Next CLI Commands to Build

```bash
# CASCADE workflow (from Empirica)
pyrite cascade preflight --we WE-YYMMDD-xxxx
pyrite cascade check --we WE-YYMMDD-xxxx
pyrite cascade postflight --we WE-YYMMDD-xxxx

# NovaProcess multi-agent investigation
pyrite nova "Question to investigate?"
pyrite nova --experts security,architecture "Specific question?"
pyrite nova -v "Verbose output?"

# Session management (from Empirica bootstrap)
pyrite session start
pyrite session resume <session-id>
pyrite session list
pyrite session show <session-id>
```

---

## Support

- **Empirica:** https://github.com/Nubaeon/empirica
- **Integration Guide:** `_PYRITE_INTEGRATION_BRIEF.md`
- **NovaSystem Design:** `NOVA_UNIFIED_DESIGN.md`

---

**Ready to integrate! 🚀**
