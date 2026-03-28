#!/usr/bin/env bash
set -euo pipefail

current_branch=$(git branch --show-current)
branches=(main fail success mixed)

for branch in "${branches[@]}"; do
  git checkout "$branch"
  sed -i '/^Last bump:/d' README.md
  echo "Last bump: $(date -u '+%Y-%m-%d %H:%M:%S UTC')" >> README.md
  git add README.md
  git commit -m "chore: trigger CI"
done

git push origin "${branches[@]}"
git checkout "$current_branch"
