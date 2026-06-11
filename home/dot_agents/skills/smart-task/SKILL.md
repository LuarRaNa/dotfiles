---
name: smart-task
description: Use when the user wants a structured Smart Task coding workflow with PLAN MODE and ACT MODE, explicit approval before edits, assumptions tracking, sub-agent context gathering, step-level verification, and faithful execution of an approved plan.
---

# Smart Task

Use this skill to run a structured collaboration workflow for coding tasks. The workflow has two modes:

- `PLAN MODE` default: understand the task, gather context, clarify, architect, and verify the plan.
- `ACT MODE`: execute the approved plan faithfully.

Follow higher-priority system and developer instructions. In conflicts, obey those higher-priority instructions first.

## Mode Rules

### Default Mode

Start every Smart Task in `PLAN MODE` unless the user has already provided an approved plan and then sent the standalone phrase `switch to ACT MODE`.

### Switching to ACT MODE

Enter `ACT MODE` only when the user sends the standalone phrase:

```text
switch to ACT MODE
```

Match this phrase case-insensitively. Do not enter `ACT MODE` because the user generally says to proceed, implement, continue, or similar.

When the plan is ready, say:

```text
Plan appears complete—awaiting: switch to ACT MODE
```

Then wait.

### Returning to PLAN MODE

If the user says:

```text
return to PLAN MODE
```

stop execution, summarize current state, open issues, completed work, and what must be replanned.

## PLAN MODE Responsibilities

In `PLAN MODE`, gather evidence and produce a plan. Do not edit files or run mutating commands. Avoid speculative implementation.

### 1. Context Survey

- Identify relevant files, components, tests, entrypoints, call sites, and framework conventions.
- Use concise summaries only.
- Use heuristics such as:
  - domain keyword search
  - entrypoints
  - framework conventions
  - related tests
  - existing call sites
- Do not dump entire large files unless the user explicitly requests `full file`.

### 2. Sub-agent Context Gathering

Use `spawn_agent` when context gathering can be parallelized or isolated without increasing risk.

Good uses:

- Search a specific subsystem for related files, patterns, tests, or call sites.
- Inspect framework conventions or entrypoints.
- Summarize large logs, diagnostics, or test failures.
- Request an independent review of the plan, risks, or proposed affected files.

Rules:

- Keep each sub-agent task narrow, concrete, and read-only during `PLAN MODE`.
- Provide all needed context, paths, keywords, constraints, and expected output format.
- Prefer sub-agents only when they reduce main-thread noise or save time through parallel work.
- Do not delegate vague, open-ended tasks such as “understand the codebase.”
- Treat sub-agent findings as summarized evidence. Verify critical claims before acting.

Expected sub-agent output:

1. Relevant files/components found
2. Key observations
3. Risks or uncertainties
4. Suggested tests or verification commands
5. Concise recommendation

### 3. Clarifications and Assumptions

- Ask only targeted, blocking questions.
- Maintain an `Assumptions Register` as a numbered list.
- Update assumption deltas in each plan revision.
- Resolve all blocking clarifications, or list explicit assumptions for user approval.

### 4. Constraints, Risks, and Security

When relevant and discoverable, note:

- dependencies and versions
- external APIs
- performance constraints
- memory constraints
- security concerns

Flag insecure or sensitive patterns such as:

- hardcoded secrets or credentials
- exposed tokens or API keys
- `eval`
- raw unparameterized SQL
- unsafe deserialization

Use placeholders such as `ENV_*` for secrets or environment-specific values.

### 5. Solution Architecture

- Present numbered steps using the `Plan Step Template` below.
- Chunk large tasks.
- Aim for 8–12 steps or fewer, grouping into phases if larger.
- For trivial tasks, use a compact plan with the same intent and omit fields that are clearly not applicable.

### 6. Testing and Verification

- Define per-step success tests with commands, expected output, or expected behavior.
- Include an `Overall Verification` section.
- If no existing test harness exists, propose lightweight commands, scripts, or manual checks.
- Document skipped tests with reason and risk.

### 7. Plan Readiness Checklist

Before asking for `ACT MODE`, ensure all applicable items are satisfied:

- [ ] Objectives clear
- [ ] Assumptions listed or explicitly `None`
- [ ] Blocking clarifications resolved, or explicit assumptions listed for approval
- [ ] Steps are sequential, or safe parallelism is noted
- [ ] Each non-trivial step includes Objective, Actions, Tools, Success Test, Risk/Mitigation, Rollback, Outputs, and Dependencies
- [ ] Security considerations addressed where relevant
- [ ] Per-step and overall verification defined
- [ ] No unresolved critical risks
- [ ] Plan length proportionate, succinct, and non-redundant

### 8. Plan Versioning

- Label plan versions `v1`, `v2`, etc.
- For each revision after `v1`, include a `Revision Delta` section with `+` and `-` bullets versus the previous version.

## ACT MODE Execution

In `ACT MODE`, execute the approved plan faithfully.

### 1. Create a Markdown Todo

Start with a Markdown todo list:

```markdown
- [ ] Step N — <Title>
```

Keep the approved order. Do not silently reorder steps.

### 2. Execute the Approved Plan

- Do not change scope silently.
- Do not reorder steps silently.
- If implementation details require adjustment, document it as:

```text
Deviation: <reason> / <impact> / <updated approach>
```

### 3. After Each Step

After each step:

- Mark it complete:

```markdown
- [x] Step N — <Title>
```

- Add a brief status summary.

### 4. Sub-agent Use in ACT MODE

Use sub-agents only for:

- independent validation
- log or test failure summarization
- review of completed changes
- disjoint implementation work explicitly included in the approved plan

Rules:

- Do not let sub-agents modify overlapping files.
- Do not let sub-agents expand scope without recording it in the `Scope Queue`.

### 5. Scope Additions

Log scope additions under `Scope Queue` with one of these statuses:

- `Pending`
- `Accepted`
- `Deferred`

### 6. Failures

- Attempt up to two tactical fixes for a failure.
- If still failing, or if an approved assumption becomes invalid, request a return to `PLAN MODE`.
- For a critical risk, stop, document current state, and propose either a targeted rollback or full rollback.

## Completion Criteria

Before completing `ACT MODE`, ensure:

- All original todos are complete, or removed only with explicit user approval.
- The final response includes:
  - Summary of Changes
  - Verification Evidence, such as command outputs, test summaries, or manual checks
  - Residual Limitations
  - Optional Additive Next Steps, only if clearly beneficial

## Style and Maintainability

- Match existing naming, formatting, and architectural patterns.
- Prefer the smallest change that correctly solves the task.
- Add comments only for non-obvious logic, constraints, or deviations.
- Document breaking changes and migration steps if applicable.
- Rollback guidance must target only changes made by the agent and avoid overwriting unrelated user work.

## Success Metrics

- `PLAN MODE`: readiness checklist satisfied and user approval received.
- `ACT MODE`: all feasible success tests pass, no unresolved high risks remain, and security posture is intact.

## Plan Step Template

Use this template for non-trivial plan steps:

```markdown
Step N: <Short Title>
Objective: <Goal>
Actions: <Ordered atomic actions>
Tools: <Tools/commands/scripts>
Success Test: <Command(s)/expected output/behavior>
Risk & Mitigation: <Top 1–3 risks, with mitigations>
Rollback: <Targeted revert steps for this step>
Estimate: <T-shirt size or time>
Outputs: <Files/artifacts modified/created>
Dependencies: <Prereq steps or external factors>
```

For trivial tasks, use a compact version that preserves the same intent.

## Sub-agent Prompt Template

Use this template when delegating narrow investigation or validation work:

```markdown
Task: <specific investigation>
Scope: <paths, keywords, components>
Constraints: Read-only unless explicitly allowed.
Return:
1. Relevant files/components
2. Key findings
3. Risks/unknowns
4. Suggested verification
5. Recommendation
```

## Interaction Notes

- Default to concise summaries and ask if more depth is needed.
- Ask only targeted questions when information is blocking.
- If idle waiting on the user after a question, state what is blocking.
- Avoid speculative code until `ACT MODE`.
- Do not use sub-agents by default for simple tasks. Use them only when they materially improve speed, focus, or confidence.
