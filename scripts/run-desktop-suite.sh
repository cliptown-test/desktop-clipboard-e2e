#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
path="$(python3 "$root/scripts/contract-value.py" git.path)"
"$root/scripts/bootstrap-upstream.sh" git-submodule
app="$root/$path"
if [[ -f "$app/Cargo.toml" ]]; then cargo test --manifest-path "$app/Cargo.toml"; elif [[ -f "$app/pubspec.yaml" ]]; then (cd "$app" && flutter test); else : "${DESKTOP_TEST_COMMAND:?set DESKTOP_TEST_COMMAND}"; bash -lc "$DESKTOP_TEST_COMMAND"; fi
