# Trust LLC — Business and Technical Plan

Building a business off the Interpreted Context Methodology (ICM) workspaces
(`prompt-harness`, `foia-public-records`, `insurance-claim`,
`municipal-dark-money-investigator`, `de-flock`, `home-search`).

This document captures the recommendation and the shippability analysis. It is a
planning artifact, not code. It assumes an engineer founder with AI and bot skills.

---

## 1. The core reframe

A conversational agent is a non-deterministic function over an unbounded input
space. That is hard to ship as a product because you cannot bound quality, cost, or
liability.

The workspaces are secretly the opposite: a **deterministic finite-state machine**
where each state delegates a bounded sub-task to a non-deterministic function (the
model). The determinism lives in `CONTEXT.md` routing and `progress.md`; the
non-determinism is confined to "given this stage's inputs, produce this stage's
artifact."

Shipping is the act of making that latent state machine explicit and authoritative
in code, then giving the model the smallest possible job at each node. This solves
three problems at once:

- **Cost** is bounded because each stage has a fixed context budget.
- **Quality** is testable because each stage has a fixed contract (inputs → artifact
  + acceptance criteria).
- **Liability** is controllable because state transitions require explicit human
  approval, not model judgment.

---

## 2. What the business actually sells

Not "access to a conversation." It sells **a guided case that produces
submission-ready work**.

| Piece | Where it lives today | What the customer buys |
|-------|----------------------|-------------------------|
| Procedure | `CONTEXT.md` stage chain | "This appeal / FOIA / audit, done right" |
| State | `progress.md`, `case-file.md` | Resume after a week, audit trail |
| Rules | `prompt-harness` discipline | Outputs you can defend |
| Deliverables | Packets, letters, dossiers | The thing they submit |
| Human gate | Checkpoints between stages | Liability boundary |

---

## 3. Recommended business shape

Primary: **vertical agent platforms for advocacy / accountability orgs (B2B first).**
Sell hosted versions of the workspaces to organizations that already spend money on
this work.

- Patient advocates / legal aid → `insurance-claim`
- Investigative journalists / watchdog NGOs → `municipal-dark-money-investigator`,
  `foia-public-records`
- Civil liberties groups / neighborhood orgs → `de-flock`

Why B2B first: these buyers have budget, urgent pain, and care about sources, audit
trails, and disclaimers, which the workspaces already build in. The unit economics
survive support cost in B2B (a trained internal user does not generate
consumer-grade tickets).

Second bet: **a "trust layer" for other AI products** — `prompt-harness` plus
source-grounding as embeddable infrastructure for teams that cannot afford
hallucinations.

Longer-term: **consumer freemium** on the open-source repos (hosted agent, deadline
bots, PDF packets, "send on my behalf").

### Suggested company structure

```text
Trust LLC (holding)
├── Product: hosted ICM workspaces (B2B first)
├── IP: prompt-harness + verified source registries per vertical
├── Services: custom workspace builds (short engagements, high margin)
└── Open source: community editions drive credibility and inbound leads
```

---

## 4. Data model (this is the actual product)

The business is a well-modeled `Case`.

```text
Case
├── id, vertical (insurance_claim | foia | municipal_audit | de_flock)
├── owner (user or org), jurisdiction
├── status (active | waiting_on_third_party | blocked | closed)
├── current_stage (enum — authoritative, NOT model-decided)
├── created_at, sla_clock[] (statutory deadlines)
│
├── Facts[]            ← structured extraction, each with a Source
├── Documents[]        ← uploaded + generated, versioned, hashed
├── Sources[]          ← verified registry entries (URL, retrieved_at, quote)
├── StageRuns[]        ← one per attempt at a stage (audit trail)
│   ├── stage, inputs_snapshot, model_id, prompt_version
│   ├── output_artifact_id, token_cost, latency
│   └── human_decision (approved | rejected | edited)
├── Deadlines[]        ← computed, drive the bot layer
└── Events[]           ← immutable log of everything that happened
```

Three rules that make it defensible:

1. A `Fact` without a `Source` cannot enter an artifact (the `08-give-sources` rule
   as a database constraint, not a hope about model behavior).
2. `current_stage` is owned by the backend. The model may propose "ready to
   advance," but the transition is a server-side action gated on
   `completion_criteria`.
3. `StageRuns` are immutable and store `model_id` + `prompt_version`, so prompt/model
   changes are diffable. This is the eval foundation and the legal audit trail at
   once.

This model is also the billing surface (per case, per stage, per active deadline),
the analytics surface (drop-off by stage), and the compliance surface (who approved
what, when, citing which source).

---

## 5. Agent orchestration

### Stage executor loop

```text
run_stage(case, stage):
  ctx   = build_context(stage)          # CONTEXT.md + references + ONLY relevant case state
  ins   = gather_required_inputs(case)  # block if missing; ask user in-stage
  plan  = planner_model(ctx, ins)       # what to produce, what sources needed
  facts = tool_layer(plan)              # web search, doc ingest, deadline calc
  draft = executor_model(ctx, facts)    # fill templates; strict, low-temp
  checks = acceptance_criteria(draft)   # every claim sourced? required sections present?
  if checks.fail: repair_loop()         # bounded retries, then escalate to human
  persist(StageRun, artifact)
  await human_approval()                # transition gate
```

### Planner / executor split

| Role | Temp | Job | Failure guarded against |
|------|------|-----|-------------------------|
| Planner | higher | Decide what's missing, strategize | Rigidity, missing an angle |
| Executor | ~0 | Fill templates, format, compute dates | Creativity — a hallucinated statute is catastrophic |

Push the executor toward **templates with slots** rather than free generation. A
FOIA request or appeal letter is mostly boilerplate plus case-specific facts. The
model fills slots; it does not author the legal skeleton. This is the biggest
reliability lever.

### Context assembly

- **Static per stage:** that stage's `CONTEXT.md` + `references/` (cache hard).
- **Dynamic per case:** a projection of `case-file.md` — only facts this stage needs.
- **Never:** other stages' internals (the repo already enforces "do NOT load other
  stages"; make it a retrieval boundary in code).

Use context caching for the static prefix, which is identical across all cases in a
vertical. That is where token cost collapses.

---

## 6. Reliability engineering

### Golden-case eval set

For each vertical, collect (synthetic + anonymized) inputs and define expected
behavior:

```text
GoldenCase: "step therapy denial, CA, PPO"
  stage_01 must classify: reason == "step_therapy"
  stage_04 must cite: relevant CA reg (from source registry)
  stage_07 packet must contain: [impact statement, clinical evidence, policy language]
  MUST NOT: cite a statute not in the verified registry
```

Run on every prompt change and model swap. This converts vibes-based development into
regression testing, and doubles as a sales asset.

### Hallucination containment (defense in depth)

1. Source-first generation — retrieve verified sources before drafting; the executor
   may only cite from the retrieved set.
2. Post-generation citation check — deterministic validator confirms every cited
   authority exists in `Sources[]`.
3. Structural acceptance criteria — required sections, computed deadlines, resolved
   recipient.
4. Human approval gate — the final backstop and liability firewall.

The `prompt-harness` stages (`07-ground-in-facts`, `08-give-sources`,
`12-no-guessing`, `15-never-lie`) are the specification for this stack. In the
product, layers 2–3 run as deterministic code, not model instructions.

### Model drift

Pin `model_id` per stage. Golden cases catch quality regressions before customers do.
Keep the executor swappable; be conservative swapping the planner.

---

## 7. Three runtimes from one IP

```text
                ┌───────────────────────────────┐
                │  Workspace Core (per vertical) │
                │  stages/, references/,         │
                │  source registry, templates    │
                └───────────────┬────────────────┘
        ┌───────────────────────┼───────────────────────┐
        ▼                       ▼                       ▼
  A. Kit runtime          B. Bundle runtime        C. Hosted runtime
  (Claude Code /          (prompt-harness PDF       (web app + server
   local agent)            + `>` trigger)            agent + DB)
  State: progress.md      State: in-thread          State: Case tables
  Human: the user         Human: the user           Human: approval UI + bots
```

- Tier A (Kit) — near-zero cost, exists today; job is credibility and inbound.
- Tier B (Bundle) — zero-install browser demo; job is "try it in 60 seconds."
- Tier C (Hosted) — the business; everything in sections 4–6 lives here.

A and B are functional marketing. C is where revenue and moat live.

---

## 8. Unit economics

Because context is stage-scoped and mostly cached, cost per case is a bounded,
predictable figure (order of dollars, not tens of dollars, at current frontier
pricing), not a runaway thread.

| Model | Charge | Variable cost | Margin driver |
|-------|--------|---------------|---------------|
| Per-case consumer | $99–$499 | single-digit $ tokens + storage | High if support stays low |
| Per-seat B2B | $500–$3k/mo | bounded × cases/seat | High; support amortized |
| API / white-label | per case/call | tokens only | Highest; no end-user support |

The hidden cost is **support, not tokens**. A confused consumer can erase the margin
of a single case. This is the quantitative argument for B2B first and for the bounded
stage UI (every blank chatbox is a support-ticket generator).

---

## 9. UX: making conversation shippable

Replace the blank box with **guided conversation**. Per stage screen:

- Left rail: the stage's job in one sentence + what is needed.
- Center: structured inputs (uploads, jurisdiction dropdowns, date pickers for the
  event that starts the SLA clock).
- Inline chat: scoped to this stage, seeded with 3–5 suggested prompts, not an open
  void.
- Footer: artifact preview + Approve & continue (locked until acceptance criteria
  pass).

This maps 1:1 to `22-stay-in-scope`, bounds cost, makes quality testable, and yields
structured analytics ("40% drop at stage 5") instead of "users seemed confused."

---

## 10. The bot layer (engineering edge, monetized)

Cases are temporal (statutory windows, filing deadlines, waiting on records). The
highest-value automation is time- and event-driven bots operating on `Deadlines[]`
and `Events[]`:

- Deadline engine — compute statutory dates on stage completion; remind at day
  7/14/30.
- Follow-up drafter — when a third party is silent past the clock, auto-draft the
  follow-up/constructive-denial letter (queued for human approval).
- Response ingester — inbound PDF → OCR → extract determination + exemptions →
  advance the case.
- Opt-in dispatch (send) — the integration boundary in section 11.

These are executor-role workers on cron + a queue, not the conversational agent. That
keeps them cheap, testable, and a clean upsell (base tier prepares; automation tier
tracks and drafts).

---

## 11. Legal and regulatory posture

Prepare-only is the specific line that keeps each vertical out of a regulated
activity. Make it an architectural invariant, then relax it deliberately.

| Vertical | Regulatory line | Design consequence |
|----------|-----------------|--------------------|
| `insurance-claim` | Unauthorized practice of law + medicine | Output is a draft packet the patient submits; impact statement in their voice; clinical evidence cited, not diagnosed |
| `foia-public-records` | Low risk; requests are a citizen right | Safe to automate submission earliest — good first "send" integration |
| `municipal-dark-money-investigator` | Defamation, right of publicity | Every allegation traces to a public-record `Source`; "flag," never "accuse" |
| `de-flock` | Legal information vs advice | Templates + disclaimers; "consult an attorney" at litigation stage |

Cross-cutting once you host data:

- Data sensitivity — health data implies HIPAA-adjacent handling; encryption at rest,
  access logs, retention/deletion policy, BAAs if PHI is touched for orgs.
- Immutable audit trail — `Events[]` + `StageRuns[]` are the "who approved what,
  citing which source" record for compliance and defamation defense.
- Disclaimers as product — surfaced at the approval gate of consequential stages,
  logged as acknowledged.

Launch invariant: prepare-only. Treat "send on your behalf" as a later,
vertical-specific feature that starts with the lowest-risk vertical (FOIA), never
insurance.

---

## 12. Moat (honest assessment)

The model is not the moat. Durable advantages, ranked:

1. **Verified source registries per jurisdiction, kept fresh** (the repos already
   have `refresh` triggers and dated verification). Strongest moat; compounds over
   time.
2. **Procedural completeness** — recipients, IMR requests, paper-trail systems,
   escalation packets, campaign aggregation. Competitors ship the easy 60%.
3. **Case state over weeks/months** — resumption + deadline tracking raises switching
   cost.
4. **The eval/golden-case corpus** — proprietary quality new entrants cannot match on
   day one.
5. **Brand: "defensible AI output"** — a positioning wedge for Trust LLC in regulated
   verticals.

Not a moat: the chat UI, the base prompts, the general workflow idea. Compete on 1–4.

---

## 13. Build sequence (dependency-ordered)

1. Formalize the `Case`/`Stage` data model for one vertical (section 4).
2. Port one workspace's stages into the executor loop (section 5) behind a thin
   CLI/API — no UI yet.
3. Stand up the golden-case eval harness (section 6) before UI.
4. Add citation-validation + acceptance-criteria code (deterministic layers).
5. Build the guided-case UI (section 9).
6. Add the deadline/bot layer (section 10) — first paid upsell.
7. Add opt-in submission, starting with FOIA (section 11).
8. Only then add a second vertical, reusing 1–6 as a platform.

Prove reliability on one vertical before breadth.

---

## 14. Tech stack

- **Backend:** TypeScript (Node) or Python — whichever ships fastest; Node pairs with
  a Next.js UI.
- **DB:** Postgres. `Case`, `StageRun`, `Fact`, `Source`, `Event` relational; JSONB
  for artifact metadata. Transactions and audit integrity matter more than a
  vector-first design.
- **Object store:** S3/R2 for documents and packets, content-hashed and versioned.
- **Agent layer:** thin orchestration over a model provider; do not over-adopt a
  heavy agent framework — the state machine is the framework, the model is a
  callable.
- **Doc pipeline:** OCR → extraction → `Facts[]`; `pandoc` for PDF/DOCX export.
- **Bots:** job queue + scheduler on `Deadlines[]`.
- **Eval:** a plain test runner over golden cases, in CI on every prompt/model change.

The unglamorous parts (Postgres schema, doc ingestion, deadline math, export) are
most of the real work and where an engineer beats an AI-only competitor.

---

## 15. Bottom line

The workspaces are shippable because they are case engines wearing a conversation as
a UI. The job is to:

1. Make the state machine authoritative in code (not model-decided).
2. Confine the model to bounded, template-heavy, source-constrained sub-tasks.
3. Enforce `prompt-harness` rules as deterministic validators + approval gates.
4. Wrap it in a guided stage UI that kills the blank-box support burden.
5. Monetize the temporal bot layer (deadlines, follow-ups) as the upgrade.
6. Defend on living source registries + procedural completeness + case state.

The business ships as outcomes in a case container, operated by a scoped
conversation, upsold with automation, sold B2B-first because the unit economics
survive support there.
