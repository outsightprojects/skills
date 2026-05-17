---
name: Git Workflow
description: Standard git branching and commit workflow for feature development
category: development
triggers: ["/git", "/branch"]
version: "1.0"
author: Georg
tags: [git, workflow, branching]
---

# Git Workflow

## Branch Naming

- `feature/` — New features
- `fix/` — Bug fixes
- `refactor/` — Code refactoring

## Commit Messages

Use conventional commits:

```
feat(scope): add new feature
fix(scope): resolve bug
refactor(scope): restructure code
```

## Process

1. Create branch from `main`
2. Make atomic commits
3. Open PR for review
4. Squash merge to main
