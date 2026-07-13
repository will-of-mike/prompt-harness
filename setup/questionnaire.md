# prompt-harness setup

Answer the one question below. The onboarding agent fills the answer into the
workspace and then removes this leftover placeholder note.

This workspace has almost nothing to configure. Every rule is fixed. The only choice
is the shape of the final answer.

## Questions

1. **What format should the final answer use?**
   - Placeholder: `{{DEFAULT_OUTPUT_FORMAT}}`
   - Appears in: `stages/99-put-it-all-together/references/final-checklist.md`
   - Input type: free text
   - Default: `bullet points, one point per line`
   - Example answers: `bullet points, one point per line`, `a short numbered list`,
     `one short paragraph, then a bullet list of next steps`

## Notes

- The prompt you want hardened is not a setup value. You type it fresh each session;
  stage `00-capture-the-prompt` reads it then.
- After setup, scan the workspace for any remaining `{{` marks. Setup is done only
  when none remain.
