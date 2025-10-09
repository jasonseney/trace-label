# TRACE AI LABEL v0.1

**Transparent Reporting of AI Content & Editing**

---

## Why TRACE?

AI is everywhere in publishing. But right now, it’s hard to tell what’s been lightly edited by a model, what’s been co-authored, and what’s been fully generated. This leaves audiences guessing, creators exposed to skepticism, and platforms vulnerable to regulatory pressure.

TRACE aims to fix this with a simple, neutral **labeling system**. Think of it like a *nutrition label* for AI use: lightweight, consistent, and easy to adopt.

---

## Core Principles

1. **Simplicity first** — a single badge like `[TRACE U3]` tells the whole story at a glance.
2. **Neutral, not judgmental** — labels explain usage, not quality.
3. **Self-label today, platform support tomorrow** — the spec starts with creators, then grows into integrations.
4. **Tiered clarity** — six clear levels (U0–U5) cover the full spectrum of AI involvement.

---

## The Levels (U0–U5)

- **U0 — No AI**  
  Purely human-created.  
  *Example:* a hand-written poem, manually typed into a blog post.

- **U1 — Utility Assist**  
  AI tools used only for mechanical cleanup: spellcheck, grammar, color correction, noise reduction.  
  *Example:* stabilizing raw video footage with AI filters.

- **U2 — Assistive (Light)**  
  AI helps with small, supporting tasks: brainstorming, outlines, minor rewrites. The human leads the content.  
  *Example:* drafting a YouTube video outline with ChatGPT, but writing the script yourself.

- **U3 — Co-author**  
  AI generates substantial drafts or sections; the human reshapes and contributes original material.  
  *Example:* AI writes the first draft of a newsletter, human edits heavily and adds unique analysis.

- **U4 — Generative (Human-reviewed)**  
  Majority of the content is model-generated; a human curates, edits, and approves before publishing.  
  *Example:* AI image series for an art project, published after manual review.

- **U5 — Autonomous Publish**  
  An agent handles end-to-end generation and publishing with minimal human input.  
  *Example:* a bot that writes, formats, and posts daily market summaries without human edits.

---

## Using TRACE Labels

The simplest way to start is with **self-labeling**:

- Add the label in brackets wherever you publish.
- Examples:
  - Tweet: `New AI soundtrack is live! [TRACE U4]`
  - Social Media Photo: `Overlay on image with [TRACE U2]`  May indicate AI edits for object removal and caption help.
  - YouTube description: `Script and cut scenese co-authored with AI [TRACE U3 +PR]`

**Optional suffixes** add more transparency:

- `+PR` → **Prompt Revealed**. The creator has shared either the exact prompt used or a short description of how AI was instructed.  
  *Example:* A blog post with `+PR` might include “Prompt: summarize transcript into 500 words” or “Prompt summary: generated outline of key themes.”

- `+CR` → **Content Credentials Attached**. The output file or media includes cryptographic provenance metadata (for example, using C2PA content credentials).  
  *Example:* An image exported from Photoshop with C2PA metadata embedded.

- `+SR` → **Safety Review Performed**. A human or automated process checked the content for things like copyright, toxicity, or privacy issues before publishing.  
  *Example:* `[TRACE U4 +SR]` for a generative video that was screened for harmful imagery.

Example label with multiple suffixes:  
`[TRACE U4 +PR +SR]`

---

## JSON Metadata (for platforms & devs)

Every badge can be backed by structured metadata.  
Lightweight, optional at first — but ready for automation.

```json
{
  "trace": {
    "version": "0.1",
    "level": "U3",
    "modality": "text",
    "human": {
      "review": true,
      "authors": ["Jason S."]
    },
    "date": "2025-09-10",
    "ai": {
      "role": "coauthor",
      "method": "iterative",
      "models": ["disclosed"]
    },
    "safety": ["copyright"]
  }
}
```

### Field-by-field guidance

- **`trace.version`** — Spec version. Stick to `"0.1"` for now; future changes will bump this for safe migrations.
- **`trace.level`** — One of `U0–U5`. If torn between two, pick the **higher** level.
- **`trace.modality`** — Primary type: `"text" | "image" | "audio" | "video" | "multimodal"`.
- **`trace.human.review`** — `true` if a human approved the final asset. Optional `authors` lets you credit people/orgs.
- **`trace.date`** — ISO 8601 date of publication/labeling (e.g., `2025-09-10`). Useful for audits and moderation windows.
- **`trace.ai.role`** — How AI participated: `utility | assistive | coauthor | generative | autonomous`.
- **`trace.ai.method`** — Process shape: `single_prompt | iterative | template | finetuned | agentic_pipeline`.
- **`trace.ai.models`** — Simple disclosure for v0.1. Use an array of strings (e.g., model family names) or `"disclosed"/"undisclosed"` if you prefer generic labeling now.
- **`trace.safety`** — Which checks ran before publishing (e.g., `copyright`, `privacy`, `toxicity`). Keep it short.

> **Tip:** v0.1 is intentionally lightweight. Start with the fields above. Platforms can add richer, optional detail using the extension block below.

---

### Optional extension block (for richer detail)

To support power users and platform integrations without burdening creators, add an optional `ext` namespace:

```json
{
  "trace": {
    "version": "0.1",
    "level": "U3",
    "modality": "text",
    "human": { "review": true },
    "date": "2025-09-10",
    "ai": { "role": "coauthor", "method": "iterative", "models": ["disclosed"] },
    "safety": ["copyright"],

    "ext": {
      "apps": [
        { "name": "ChatGPT", "provider": "OpenAI", "version": "2025-09", "mode": "web" }
      ],
      "models": [
        {
          "name": "gpt-5-thinking",
          "provider": "OpenAI",
          "version": "2025-08-15",
          "id": "openai:gpt-5-thinking:2025-08-15",
          "usage": { "share": "majority", "purpose": "drafting" }
        }
      ],
      "pipeline": [
        { "step": "transcription", "app": "Whisper", "version": "large-v3" },
        { "step": "summarization", "model": "gpt-5-thinking", "iterations": 3 }
      ],
      "data": { "sources": ["original", "licensed"], "retrieval": { "used": false } },
      "prompt": {
        "disclosure": "summary",
        "summary": "Draft first-pass newsletter from transcript; keep jokes; 700–900 words."
      },
      "provenance": { "type": "none" }
    }
  }
}
```

---

### Schema choices that help adoption

- **Keep core simple** — Only the fields above are needed for v0.1 self-labeling.
- **Enums where clarity matters** — Use enums for `level`, `modality`, and `prompt.disclosure`; keep tool/model names as free text.
- **Dates/versions as strings** — Model versioning is messy; don’t over-constrain.
- **Everything in `ext` is optional** — Rich detail for platforms, zero friction for creators.
- **Allow vendor/custom fields** — Permit `x-` prefixed keys (e.g., `"x-runway"`) or a `vendor` sub-object for proprietary identifiers.
- **Privacy by default** — Don’t include secrets, PII, or full prompts unless intentionally disclosed (`+PR`). Prefer summaries and external URIs for long details.

---

## For Creators

- **Trust your audience**: show exactly how you use AI, without stigma.
- **Protect your work**: get ahead of “is this AI?” accusations.
- **Simple to start**: just add `[TRACE Ux]` — no tools required.

---

## For Platforms & Engineers

- **Schema-ready**: plug-in JSON metadata for structured transparency.
- **Future-proof**: aligns with emerging standards like C2PA “content credentials.”
- **Flexible integration**: attach TRACE labels to exports, posts, or media manifests.

---

## Adoption Path

- **Today**: Self-labeling by creators.
- **Next**: Plugins and platform integrations auto-generate labels.
- **Future**: Provenance links (C2PA, signed manifests) ensure verifiable labeling.

---

## Contribute

TRACE is open and versioned. v0.1 is deliberately simple — the spec will evolve with community input.

Ways to contribute:

- **Creators**: start labeling your work and share feedback.
- **Developers**: test the schema, build prototypes, suggest improvements.
- **Platforms**: pilot integrations, align with your content policies.

Open issues, propose updates, or join the discussion in [GitHub Issues](./issues).

---

⚡ **Transparency only works if we do it together. Start by labeling your next post `[TRACE Ux]`.**
