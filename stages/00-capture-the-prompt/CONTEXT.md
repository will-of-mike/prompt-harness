# 00-capture-the-prompt

Read the prompt exactly and pass it forward. If the prompt names another workspace,
route there first.

## Inputs

| Source | File/Location | Section/Scope | Why |
|--------|--------------|---------------|-----|
| User | The prompt you type this session | Full prompt | The task to answer |
| Reference | `references/how-to-capture-and-route.md` | Full file | How to read the prompt exactly and how to route to another workspace |

## Process

1. Read the prompt one word at a time. Skip nothing.
2. If the prompt names another workspace, follow the routing section of
   `references/how-to-capture-and-route.md`, do the task there, and bring the result
   back as the captured prompt.
3. Do not answer the prompt yet. This stage only captures it.
4. Save the captured prompt to `output/00-prompt.md`. IMMEDIATELY continue to
   `00b-draft-the-answer`.

## Outputs

| Artifact | Location | Format |
|----------|----------|--------|
| Captured prompt | `output/00-prompt.md` | The prompt text under a "Prompt" heading; a "Route note" and "Result" heading as well if it routed to another workspace |
