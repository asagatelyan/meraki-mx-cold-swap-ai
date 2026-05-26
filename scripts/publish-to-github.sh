#!/usr/bin/env bash
# Publish meraki-mx-cold-swap-ai to GitHub (run locally — never commit tokens).
#
# Usage:
#   export GH_TOKEN='ghp_xxxxxxxx'   # classic PAT, or github_pat_... fine-grained
#   ./scripts/publish-to-github.sh
#
# Do NOT paste git error lines into the terminal — only run this script.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

OWNER="asagatelyan"
REPO_NAME="meraki-mx-cold-swap-ai"
REMOTE_URL="https://github.com/${OWNER}/${REPO_NAME}.git"

GH_TOKEN="$(printf '%s' "${GH_TOKEN:-}" | tr -d '[:space:]')"

if [[ -z "${GH_TOKEN}" ]]; then
  echo "ERROR: GH_TOKEN is not set." >&2
  echo "  export GH_TOKEN='ghp_your_token_here'" >&2
  exit 1
fi

# Classic PAT (ghp_) uses 'token'; fine-grained (github_pat_) uses 'Bearer'
if [[ "${GH_TOKEN}" == ghp_* ]] || [[ "${GH_TOKEN}" == gho_* ]]; then
  AUTH_HEADER="Authorization: token ${GH_TOKEN}"
else
  AUTH_HEADER="Authorization: Bearer ${GH_TOKEN}"
fi

api_curl() {
  curl -fsSL \
    -H "${AUTH_HEADER}" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "$@"
}

verify_token() {
  local body code
  body="$(mktemp)"
  code="$(curl -s -o "${body}" -w "%{http_code}" \
    -H "${AUTH_HEADER}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/user")"

  if [[ "${code}" == "200" ]]; then
    local login
    login="$(grep -m1 '"login"' "${body}" | sed 's/.*"login": "\([^"]*\)".*/\1/')"
    echo "GitHub API OK (logged in as: ${login})"
    rm -f "${body}"
    return 0
  fi

  echo "ERROR: GitHub rejected your token (HTTP ${code})." >&2
  echo "" >&2
  echo "Fix:" >&2
  echo "  1. Create a new token: https://github.com/settings/tokens" >&2
  echo "  2. Classic PAT: enable scope  repo  (full control of private repositories)" >&2
  echo "     OR fine-grained: Repository access + Contents Read/Write + Metadata Read" >&2
  echo "  3. export GH_TOKEN='paste_new_token_here'" >&2
  echo "  4. Run: ./scripts/publish-to-github.sh" >&2
  echo "" >&2
  echo "Do not paste old tokens or git error messages into the shell." >&2
  rm -f "${body}"
  exit 1
}

create_repo_if_needed() {
  local code
  code="$(curl -s -o /dev/null -w "%{http_code}" \
    -H "${AUTH_HEADER}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${OWNER}/${REPO_NAME}")"

  case "${code}" in
    200)
      echo "Repository already exists on GitHub"
      ;;
    404)
      echo "Creating repository ${OWNER}/${REPO_NAME} ..."
      api_curl -X POST \
        -d "{\"name\":\"${REPO_NAME}\",\"description\":\"AI-first Meraki MX cold-swap wizard (unofficial community project)\",\"private\":false,\"auto_init\":false}" \
        "https://api.github.com/user/repos" >/dev/null
      echo "Repository created"
      ;;
    *)
      echo "ERROR: Cannot access repo (HTTP ${code}). Check token scopes." >&2
      exit 1
      ;;
  esac
}

setup_remote_and_push() {
  if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "${REMOTE_URL}"
  else
    git remote add origin "${REMOTE_URL}"
  fi

  local push_url="https://x-access-token:${GH_TOKEN}@github.com/${OWNER}/${REPO_NAME}.git"

  echo "Pushing main ..."
  if ! git push "${push_url}" main 2> >(tee /tmp/git-push-err.$$ >&2); then
    if grep -q "without \`workflow\` scope" /tmp/git-push-err.$$ 2>/dev/null; then
      echo "" >&2
      echo "ERROR: Your token needs the workflow scope to push .github/workflows/" >&2
      echo "  Classic PAT: enable  repo  AND  workflow" >&2
      echo "  Fine-grained:  Administration: Read and write  OR  Workflows: Read and write" >&2
      echo "  https://github.com/settings/tokens" >&2
      echo "Then: export GH_TOKEN='...' && ./scripts/publish-to-github.sh" >&2
    fi
    rm -f /tmp/git-push-err.$$
    exit 1
  fi
  rm -f /tmp/git-push-err.$$

  if ! git rev-parse v0.1.0 >/dev/null 2>&1; then
    git tag v0.1.0
  fi
  echo "Pushing tag v0.1.0 ..."
  git push "${push_url}" v0.1.0 2>/dev/null || git push "${push_url}" v0.1.0 --force

  git remote set-url origin "${REMOTE_URL}"
  git branch --set-upstream-to=origin/main main 2>/dev/null || true
}

main() {
  echo "=== Publish ${OWNER}/${REPO_NAME} ==="
  verify_token
  create_repo_if_needed
  setup_remote_and_push
  echo ""
  echo "Done: https://github.com/${OWNER}/${REPO_NAME}"
  echo "Revoke or delete the token if it was single-use."
}

main "$@"
