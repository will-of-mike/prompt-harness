# prompt-harness setup

Setup is already done. This file records the one choice the workspace has, so it can
be changed later.

Do not run this questionnaire in answer to a prompt. If someone asks a question, run
the pipeline and answer it. Only touch this file when the person explicitly asks to
change the workspace's setup.

This workspace has almost nothing to configure. Every rule is fixed. The only choice
is the shape of the final answer.

## Questions

1. **What format should the final answer use?**
   - Set in: the "Output format" section of
     `stages/99-put-it-all-together/references/final-checklist.md`
   - Input type: free text
   - Current value: `bullet points, one point per line`
   - Default: `bullet points, one point per line`
   - Example answers: `bullet points, one point per line`, `a short numbered list`,
     `one short paragraph, then a bullet list of next steps`

## Notes

- The prompt you want hardened is not a setup value. You type it fresh each session;
  stage `00-capture-the-prompt` reads it then.
- No `{{ }}` placeholder should remain anywhere in the workspace. `bundle.ps1` warns
  if one reaches the shipped bundle.
