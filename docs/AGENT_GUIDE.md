# AI Agent & Team Collaboration Guide

Welcome! If you are an AI coding assistant (or a team member) working on this repository, **read this guide completely before writing any code**.

---

## 1. Mandatory Architecture Rules

1. **RAW SQL ONLY — NO ORMs Allowed:**
   - Never install or use SQLAlchemy, Peewee, Tortoise, Django ORM, or any query builder.
   - Always use `psycopg2` parameterized queries (`%s` or `%(name)s`). Never use Python f-strings (`f"SELECT ... {var}"`) for SQL values (SQL injection risk).
2. **Respect the Exact Schema in `docs/IMPLEMENTATION_PLAN.md`:**
   - Do not invent or rename tables, columns, or data types. Every table and column must match `docs/IMPLEMENTATION_PLAN.md` and the real `online_retail_II.xlsx` dataset.
3. **Strict Sequential Execution (`01` ➔ `75`):**
   - Everyone follows the **exact sequential order** in `docs/COMMIT_TRACKER.md`.
   - **Do NOT skip ahead** to later phases or pick random tasks out of order. Always take the **very first unchecked `[ ]` step** in `docs/COMMIT_TRACKER.md`.

---

## 2. Git Workflow (How Every Member & Agent Must Work)

1. **Sync with GitHub first:**
   ```bash
   git pull --rebase origin main
   ```
2. **Find the next step:**
   - Open `docs/COMMIT_TRACKER.md` and locate the **first unchecked `[ ]` item** in sequential order.
3. **Implement ONLY that single atomic step:**
   - Follow `docs/IMPLEMENTATION_PLAN.md` strictly.
   - Do not bundle multiple steps into one commit.
4. **Update `docs/COMMIT_TRACKER.md`:**
   - Mark that step as `[x]`.
5. **Commit & Push using the exact commit message from `docs/COMMIT_TRACKER.md`:**
   ```bash
   git add <changed-files> docs/COMMIT_TRACKER.md
   git commit -m "<exact message from COMMIT_TRACKER.md>"
   git push origin main
   ```
   *(If push is rejected because a teammate pushed just before you, run `git pull --rebase origin main` and then `git push origin main`.)*
