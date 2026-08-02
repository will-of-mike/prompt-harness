# prompt-harness

Answer any prompt while obeying every standing rule, then return the answer in one
fixed format. Write a prompt once here and get the same disciplined answer on any
model, on any device, in any tool.

## Folder Map

```
prompt-harness/
├── CLAUDE.md        (you are here)
├── CONTEXT.md       (start here for the full stage order)
├── setup/           (the one setup value; already filled in)
└── stages/
    ├── 00-capture-the-prompt/     (read the prompt, route if needed)
    ├── 00b-draft-the-answer/      (write the first-draft answer)
    ├── 01-no-jargon/  ...  23-no-filler-words/   (one standing rule each)
    │     of these, 09, 10, 11, 14 and 17 are check stages: they fix a
    │     defect if they find one, and otherwise change nothing
    ├── 24-check-your-work/        (check stage: reliability self-check)
    ├── 25-handle-what-goes-wrong/ (check stage: missing, contradictory, hidden)
    ├── 26-do-not-punt/            (check stage: the whole answer is there)
    └── 99-put-it-all-together/    (final checklist, format, deliver)
```

## Triggers

Any message that is not one of the keywords below is a prompt to harden. Run the
whole pipeline on it. No keyword is required.

| Keyword | Action |
|---------|--------|
| `setup` | Change the one setup value in `setup/questionnaire.md` |
| `status` | List which `stages/*/output/` files exist and how far the last run got |
| `harden` | Run the whole pipeline (same as sending a bare prompt) |

A message that opens with `>` is a prompt to harden. Everything after the `>` is the
prompt. That form exists for chat tools where this workspace arrives as one uploaded
file.

## How It Works

Write your prompt. The pipeline runs start to finish on its own. Stage
`00-capture-the-prompt` reads it, `00b-draft-the-answer` writes a first answer,
stages `01` through `23` each fix one rule, stages `24` through `26` check the
result, and `99-put-it-all-together` checks every rule and returns the final answer.

The pipeline does not stop to ask questions. A missing fact is reported inside the
answer and the rest of the answer is still delivered; see stage 25. The only thing
that stops a run is being unable to read the prompt at all.

## What Comes Back

The reply is the final answer alone. Do not narrate the stages, quote the drafts, or
describe the checks. The person asked a question; give them the answer.

## When You Cannot Write Files

Every stage says to save its draft to `output/`. In a chat tool with no file system
that is impossible, and it is not a reason to stop or to ask for one. Run the same
stages in order, hold each draft in the reply you are composing, and send only the
final answer from `99-put-it-all-together`. Nothing in the pipeline depends on the
files existing on disk; they only pass the draft from one stage to the next.

## Routing

| Task | Go To |
|------|-------|
| Harden a prompt (start here) | `stages/00-capture-the-prompt/CONTEXT.md` |
| See the full stage order | `CONTEXT.md` |

## What to Load

| Task | Load These | Do NOT Load |
|------|-----------|-------------|
| Run one stage | that stage's `CONTEXT.md`, its `references/`, the prior stage's output draft, and any file listed in that stage's own Inputs table | any other stage's files |
| Understand the pipeline | `CONTEXT.md` | the individual stage reference files |

A stage's Inputs table is the authority on what that stage loads. Stages 26 and 99
list `stages/00-capture-the-prompt/output/00-prompt.md` there, because checking that
every part of the prompt is answered requires the prompt.

## Stage Handoffs

Each stage writes its draft to its own `output/` folder. The next stage reads that
draft. Edit a draft and the next stage picks up your edit.

Every draft in the chain is the answer itself. A stage may change the wording of the
answer, add to it, or correct it. No stage replaces it with a heading, a label, or a
report about the stage: anything in the file that is not the answer travels down the
chain to the reader. Where there is no file system, see "When You Cannot Write
Files" above.
