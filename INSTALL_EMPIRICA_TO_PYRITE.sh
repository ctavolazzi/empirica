#!/usr/bin/env bash
#
# Install Empirica into _pyrite with proper attribution
#
# This script copies Empirica core modules into _pyrite and adds
# proper MIT license attribution crediting the Empirica Team.
#

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Empirica → _pyrite Integration${NC}"
echo -e "${BLUE}========================================${NC}"
echo

# Check if _pyrite path is provided
PYRITE_PATH="${1:-/tmp/_pyrite}"

if [ ! -d "$PYRITE_PATH" ]; then
    echo -e "${YELLOW}Error: _pyrite directory not found at: $PYRITE_PATH${NC}"
    echo "Usage: $0 /path/to/_pyrite"
    exit 1
fi

echo -e "${GREEN}✓${NC} _pyrite found at: $PYRITE_PATH"
echo

# Source directory (current empirica repo)
EMPIRICA_SRC="$(cd "$(dirname "$0")" && pwd)"
echo -e "${GREEN}✓${NC} Empirica source: $EMPIRICA_SRC"
echo

# Create directory structure in _pyrite
echo -e "${BLUE}Creating directory structure...${NC}"

mkdir -p "$PYRITE_PATH/empirica/core/vectors"
mkdir -p "$PYRITE_PATH/empirica/core/cascade"
mkdir -p "$PYRITE_PATH/empirica/core/sentinel"
mkdir -p "$PYRITE_PATH/empirica/core/bootstrap"
mkdir -p "$PYRITE_PATH/empirica/core/signaling"
mkdir -p "$PYRITE_PATH/tools/nova-process/personas/core"
mkdir -p "$PYRITE_PATH/tools/nova-process/personas/experts"

echo -e "${GREEN}✓${NC} Directories created"
echo

# Copy Empirica core modules
echo -e "${BLUE}Copying Empirica core modules...${NC}"

# Vectors
if [ -f "$EMPIRICA_SRC/empirica/core/vectors/epistemic_vectors.py" ]; then
    cp "$EMPIRICA_SRC/empirica/core/vectors/epistemic_vectors.py" "$PYRITE_PATH/empirica/core/vectors/"
    echo -e "${GREEN}✓${NC} vectors/epistemic_vectors.py"
fi

# CASCADE
if [ -d "$EMPIRICA_SRC/empirica/core/cascade" ]; then
    cp -r "$EMPIRICA_SRC/empirica/core/cascade/"* "$PYRITE_PATH/empirica/core/cascade/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} cascade/ (workflow)"
fi

# Sentinel (Loop tracker)
if [ -f "$EMPIRICA_SRC/empirica/core/sentinel/orchestrator.py" ]; then
    cp "$EMPIRICA_SRC/empirica/core/sentinel/orchestrator.py" "$PYRITE_PATH/empirica/core/sentinel/"
    echo -e "${GREEN}✓${NC} sentinel/orchestrator.py (EpistemicLoopTracker)"
fi

# Bootstrap
if [ -d "$EMPIRICA_SRC/empirica/core/bootstrap" ]; then
    cp -r "$EMPIRICA_SRC/empirica/core/bootstrap/"* "$PYRITE_PATH/empirica/core/bootstrap/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} bootstrap/ (session continuity)"
fi

# Signaling
if [ -f "$EMPIRICA_SRC/empirica/core/signaling.py" ]; then
    cp "$EMPIRICA_SRC/empirica/core/signaling.py" "$PYRITE_PATH/empirica/core/"
    echo -e "${GREEN}✓${NC} signaling.py (cognitive phase detection)"
fi

# Copy __init__.py files
if [ -f "$EMPIRICA_SRC/empirica/__init__.py" ]; then
    cp "$EMPIRICA_SRC/empirica/__init__.py" "$PYRITE_PATH/empirica/"
    echo -e "${GREEN}✓${NC} empirica/__init__.py"
fi

if [ -f "$EMPIRICA_SRC/empirica/core/__init__.py" ]; then
    cp "$EMPIRICA_SRC/empirica/core/__init__.py" "$PYRITE_PATH/empirica/core/"
    echo -e "${GREEN}✓${NC} empirica/core/__init__.py"
fi

echo

# Copy NovaSystem personas
echo -e "${BLUE}Copying NovaSystem personas...${NC}"

if [ -f "$EMPIRICA_SRC/empirica/personas/core/DCE.md" ]; then
    cp "$EMPIRICA_SRC/empirica/personas/core/DCE.md" "$PYRITE_PATH/tools/nova-process/personas/core/"
    echo -e "${GREEN}✓${NC} DCE.md (Discussion Continuity Expert)"
fi

if [ -f "$EMPIRICA_SRC/empirica/personas/core/CAE.md" ]; then
    cp "$EMPIRICA_SRC/empirica/personas/core/CAE.md" "$PYRITE_PATH/tools/nova-process/personas/core/"
    echo -e "${GREEN}✓${NC} CAE.md (Critical Analysis Expert)"
fi

echo

# Create ATTRIBUTION.md
echo -e "${BLUE}Creating attribution file...${NC}"

cat > "$PYRITE_PATH/empirica/ATTRIBUTION.md" << 'ATTR_EOF'
# Empirica Attribution

This directory contains code from the **Empirica** project, used under the MIT License.

## Source

- **Project:** Empirica - Epistemic Vector-Based Functional Self-Awareness Framework
- **Repository:** https://github.com/Nubaeon/empirica
- **Version:** 1.2.3 (as of 2026-01-04)
- **Authors:** Empirica Team
- **License:** MIT License

## MIT License

```
MIT License

Copyright (c) 2024-2025 Empirica Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## What Was Integrated

The following Empirica components have been embedded into _pyrite:

### Core Modules

1. **Epistemic Vectors** (`empirica/core/vectors/`)
   - 13-dimensional epistemic tracking
   - Functions: `calculate_epistemic_vector()`, `assess_state()`

2. **CASCADE Workflow** (`empirica/core/cascade/`)
   - PREFLIGHT → CHECK → POSTFLIGHT phases
   - Epistemic gate logic

3. **Sentinel / Loop Tracker** (`empirica/core/sentinel/`)
   - EpistemicLoopTracker class
   - Investigation depth control
   - Convergence detection

4. **Bootstrap Context** (`empirica/core/bootstrap/`)
   - Session continuity across conversations
   - ~800 token compression of prior learnings

5. **Cognitive Signaling** (`empirica/core/signaling.py`)
   - Phase detection (NOETIC / THRESHOLD / PRAXIC)
   - Moon phase indicators (🌑→🌕)

## Integration Purpose

Empirica provides the **epistemic awareness foundation** for _pyrite's unified cognitive architecture:

- **_pyrite** handles repository management and work tracking
- **Empirica** provides epistemic self-awareness and learning measurement
- **NovaSystem** orchestrates multi-agent investigation

Together, they create AI agents that:
- Track what they know and don't know
- Self-regulate investigation depth
- Maintain learning continuity across sessions
- Collaborate through specialized personas

## Modifications

Any modifications to Empirica code in this repository are documented here:

- [List any changes made to adapt Empirica for _pyrite integration]

## Credits

Full credit to the Empirica Team for creating this foundational epistemic awareness framework.

If you use _pyrite with Empirica integration, please credit both projects:
- _pyrite: [repository URL]
- Empirica: https://github.com/Nubaeon/empirica

## Additional Resources

- **Empirica Documentation:** See original repository
- **Integration Guide:** See `_PYRITE_INTEGRATION_BRIEF.md`
- **NovaSystem Design:** See `NOVA_UNIFIED_DESIGN.md`
ATTR_EOF

echo -e "${GREEN}✓${NC} empirica/ATTRIBUTION.md created"
echo

# Create __init__.py stub if needed
if [ ! -f "$PYRITE_PATH/empirica/__init__.py" ]; then
    cat > "$PYRITE_PATH/empirica/__init__.py" << 'INIT_EOF'
"""
Empirica - Embedded epistemic awareness framework

This package contains core Empirica modules integrated into _pyrite.
See ATTRIBUTION.md for license and credits.
"""

__version__ = "1.2.3-embedded"
__attribution__ = "Empirica Team - MIT License"

# Re-export key components (to be implemented as integration progresses)
# from .core.vectors import calculate_epistemic_vector
# from .core.cascade import run_preflight, run_check, run_postflight
# from .core.bootstrap import load_session_context
INIT_EOF
    echo -e "${GREEN}✓${NC} empirica/__init__.py stub created"
fi

# Summary
echo
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Installation Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo
echo -e "${GREEN}Empirica modules installed to:${NC}"
echo "  $PYRITE_PATH/empirica/"
echo
echo -e "${GREEN}NovaSystem personas installed to:${NC}"
echo "  $PYRITE_PATH/tools/nova-process/personas/"
echo
echo -e "${GREEN}Attribution documented at:${NC}"
echo "  $PYRITE_PATH/empirica/ATTRIBUTION.md"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Review $PYRITE_PATH/empirica/ATTRIBUTION.md"
echo "  2. Integrate Empirica into pyrite CLI"
echo "  3. Build NovaProcess orchestrator"
echo "  4. Test unified workflow"
echo
echo -e "${BLUE}See _PYRITE_INTEGRATION_BRIEF.md for full integration guide${NC}"
echo
ATTR_EOF

chmod +x "$EMPIRICA_SRC/INSTALL_EMPIRICA_TO_PYRITE.sh"
echo -e "${GREEN}✓${NC} Installation script created and made executable"
echo

# Create README for NovaSystem personas
cat > "$PYRITE_PATH/tools/nova-process/personas/README.md" << 'README_EOF'
# NovaSystem Personas

This directory contains persona definitions for the NovaSystem multi-agent orchestration framework.

## Persona Types

### Core Personas

Located in `core/`:
- **DCE.md** - Discussion Continuity Expert (Coordinator)
- **CAE.md** - Critical Analysis Expert (Critic)

### Domain Experts

Located in `experts/`:
- **security.md** - Security Expert (threat modeling, vulnerabilities)
- **architecture.md** - Architecture Expert (system design, patterns)
- **performance.md** - Performance Expert (scalability, efficiency)
- **testing.md** - Testing Expert (QA, reliability)

## Persona Format

Personas are defined in Markdown with YAML frontmatter:

```markdown
---
role: Expert Name
short_name: ABBR
expertise:
  - skill 1
  - skill 2
tools:
  - tool 1
responsibility: what this persona does
pattern: supervisor | worker | critic
---

# Full Persona Definition

Instructions for how this persona analyzes questions...
```

## Creating New Personas

1. Create new .md file in `experts/`
2. Use existing personas as template
3. Define clear role and expertise
4. Specify analysis approach
5. Test with NovaProcess orchestrator

## Integration

Personas are loaded by the NovaProcess orchestrator (`../orchestrate.py`) and participate in turn-based conversations to investigate questions.

See `../README.md` for full NovaProcess documentation.
README_EOF

echo -e "${GREEN}✓${NC} NovaSystem personas README created"
echo
