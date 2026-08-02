# prompt-harness

A prompt-hardening pipeline. Ask a question, get back a disciplined answer in one
fixed format -- the same on any model, any device, any tool.

For the full pipeline and how it works, see [CLAUDE.md](CLAUDE.md) and
[CONTEXT.md](CONTEXT.md).

## Using it in a browser chat (duck.ai, Gemini, etc.)

These tools accept a single file upload, not a folder. `bundle.ps1` flattens the
whole workspace into one file so you can upload it.

**Every time you want to use it:**

1. Upload **`prompt-harness-bundle.pdf`** to the chat.
2. In the same message, type `>` then your question. Example:
   `> How far is the Moon from Earth?`
3. Send. You get the final answer only.

That's the whole thing to remember: **`>` then your question.**

**Which chat to use -- and why they differ:**

The same bundle behaves differently on each tool, for two reasons: one can browse the
live web and the other cannot, and each treats an uploaded file differently.

- **duck.ai with Claude Haiku 4.5** -- follows the workspace rules most faithfully, so
  you get the most disciplined, in-scope, correctly formatted answer. It cannot browse
  the live web, so "give sources" is satisfied from what the model already knows rather
  than from fresh citations. Pick a *non-reasoning* model in duck.ai's menu -- reasoning
  models leak their thinking into the answer.
- **Google Gemini** -- browses the live web, so answers come backed by real sources and
  clickable links, but it is looser on the fixed format. It also treats the uploaded
  bundle as a *document to cite*: it adds page markers like `(p. 3)` and gathers sources
  into numbered footnotes. That is great for sourcing, and it is also why its format is
  less strict than duck.ai's. Run it in its browsing ("personalized") mode.

**Rule of thumb:** duck.ai for the most disciplined, in-format answer; Gemini when you
want the answer grounded in live web sources with links.

## Regenerating the bundle

Only needed if you edit the workspace. From this folder, in PowerShell:

```
./bundle.ps1 -Pdf
```

This rewrites `prompt-harness-bundle.txt` and `prompt-harness-bundle.pdf` (a dense
2-column, ~13-page layout that fits duck.ai's 15-page limit). It warns if a file is
empty or an unfilled `{{PLACEHOLDER}}` would ship. Options:

- `./bundle.ps1` -- text bundle only, no PDF.
- `./bundle.ps1 -Root ../other-workspace -Pdf` -- bundle a different workspace.
- `./bundle.ps1 -IncludeOutputs` -- also include the stages' `output/` drafts.

## Why it's built this way

Browser chats treat an uploaded file as *reference data to describe*, not commands
to obey -- so a forceful "do this" header gets ignored or refused as a suspected
override. The working design: keep the file's header quiet and descriptive, define
`>` as the trigger inside it, and let the authority to *run* come from your typed
`>` message. The delivery rules (answer only, stay in scope, no follow-up trailer,
authoritative sources) are attached to what `>` means, so your one keystroke
carries them. Some polish still depends on the model you pick, not the prompt.
