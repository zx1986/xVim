# Merge Refactor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Merge the `refactor` branch into `master` to unify macOS and Ubuntu configurations.

**Architecture:** Use standard Git merge workflow. The `refactor` branch has already been updated with the latest `master` changes, so the merge should be clean.

**Tech Stack:** Git, Makefile.

---

### Task 1: Prepare Master Branch

**Files:**
- Modify: `master` branch (checkout and pull)

- [ ] **Step 1: Switch to master branch**

Run: `git checkout master`
Expected: `Switched to branch 'master'`

- [ ] **Step 2: Pull latest changes from origin**

Run: `git pull origin master`
Expected: `Already up to date` (or successful pull)

### Task 2: Merge Refactor Branch

**Files:**
- Modify: `master` branch (merge `refactor`)

- [ ] **Step 1: Merge refactor branch into master**

Run: `git merge refactor`
Expected: `Updating ...` followed by a list of file changes and `Fast-forward` or a merge commit message.

- [ ] **Step 2: Resolve conflicts (if any)**

Run: `git status`
Expected: `nothing to commit, working tree clean`

### Task 3: Post-Merge Verification

**Files:**
- Read: `Makefile`
- Read: `nvim/` (check existence)
- Read: `macos/config` (check absence)

- [ ] **Step 1: Verify new directory structure**

Run: `ls -d nvim && ls -d macos/config ubuntu/config`
Expected: `nvim` exists; `macos/config` and `ubuntu/config` should NOT exist (ls should fail for them).

- [ ] **Step 2: Verify Makefile functionality**

Run: `make help`
Expected: Output showing the new unified targets (e.g., `init`, `clean`, `update`).

### Task 4: Push to Origin

**Files:**
- Modify: `origin/master` (push)

- [ ] **Step 1: Push merged master to origin**

Run: `git push origin master`
Expected: `To ... [new branch] master -> master`
