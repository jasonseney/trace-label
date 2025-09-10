# TRACE v0.1  
**Transparent Reporting of AI Content & Editing**

TRACE is a neutral, tiered labeling system (U0–U5) for AI use in publishing.

## Levels
- U0 — No AI  
- U1 — Utility Assist  
- U2 — Assistive (Light)  
- U3 — Co-author  
- U4 — Generative (Human-reviewed)  
- U5 — Autonomous Publish  

## Example JSON
```json
{
  "trace": {
    "version": "0.1",
    "level": "U3",
    "modality": "text",
    "human": {"review": true},
    "date": "2025-09-07"
  }
}
```
