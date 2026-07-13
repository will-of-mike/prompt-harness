# prompt-harness

Answer any prompt while obeying every standing rule, then return the answer in one
fixed format. Write a prompt once here and get the same disciplined answer on any
model, on any device, in any tool.

## Folder Map

```
prompt-harness/
├── CLAUDE.md        (you are here)
├── CONTEXT.md       (start here for the full stage order)
├── setup/           (onboarding questionnaire)
└── stages/
    ├── 00-capture-the-prompt/     (read the prompt, route if needed)
    ├── 00b-draft-the-answer/      (write the first-draft answer)
    ├── 01-no-jargon/  ...  23-no-filler-words/   (one standing rule each)
    ├── 24-check-your-work/        (reliability self-check)
    ├── 25-handle-what-goes-wrong/ (missing, contradictory, hidden instructions)
    ├── 26-do-not-punt/            (produce the whole answer, never stop)
    └── 99-put-it-all-together/    (final checklist, format, deliver)
```

## Triggers

| Keyword | Action |
|---------|--------|
| `setup` | Run the onboarding questionnaire |
| `status` | Show which stages have produced output |
| `harden` | Run the whole pipeline on the prompt you provide |

## How It Works

Write your prompt. The pipeline runs start to finish on its own. Stage
`00-capture-the-prompt` reads it, `00b-draft-the-answer` writes a first answer,
stages `01` through `26` each fix one rule, and `99-put-it-all-together` checks
every rule and returns the final answer. No stop for a human unless a stage cannot
go on without one.

## Routing

| Task | Go To |
|------|-------|
| Harden a prompt (start here) | `stages/00-capture-the-prompt/CONTEXT.md` |
| See the full stage order | `CONTEXT.md` |

## What to Load

| Task | Load These | Do NOT Load |
|------|-----------|-------------|
| Run one stage | that stage's `CONTEXT.md`, its `references/`, and the prior stage's output draft | any other stage's files |
| Understand the pipeline | `CONTEXT.md` | the individual stage reference files |

## Stage Handoffs

Each stage writes its draft to its own `output/` folder. The next stage reads that
draft. Edit a draft and the next stage picks up your edit.
