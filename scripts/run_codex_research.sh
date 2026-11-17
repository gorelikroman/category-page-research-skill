#!/bin/bash
# Run a research prompt through Codex CLI with web search and save the answer as markdown.
#
# Usage:
#   run_codex_research.sh <prompt.txt> <out.md> [model]
#   run_codex_research.sh --resume <session-id> <out.md> [model]
#
# - One run at a time: parallel runs on a large model exhaust the usage limit.
# - Default model: the small one at low reasoning effort (search and extraction need no more).
#   Set CODEX_MODEL or pass a third argument when the model lineup changes.
# - Read-only sandbox: Codex searches and answers, it does not touch files.
# - The log is written next to the output as <out>.log; the session id for --resume is in it.
#
# Run it in the background; a pass over 30-40 threads takes several minutes.

set -u
MODEL_DEFAULT="${CODEX_MODEL:-gpt-6-luna}"
TAIL="Do not write any files; return the whole document as your final message."
FINISH="Stop searching now. Using only what you have already found in this session, write the complete final markdown document exactly as specified in the original task. If a section has little evidence, say so in one line instead of searching more."

if ! command -v codex >/dev/null 2>&1; then
  echo "codex CLI not found. Use the ChatGPT / Gemini route instead." >&2; exit 1
fi

if [ "${1:-}" = "--resume" ]; then
  [ "$#" -ge 3 ] || { echo "usage: $0 --resume <session-id> <out.md> [model]" >&2; exit 2; }
  SESSION="$2"; OUT="$3"; MODEL="${4:-$MODEL_DEFAULT}"
  mkdir -p "$(dirname "$OUT")"
  codex --search exec --skip-git-repo-check -s read-only -m "$MODEL" \
    -c model_reasoning_effort='"low"' -o "$OUT" resume "$SESSION" "$FINISH" \
    > "$OUT.log" 2>&1 < /dev/null
else
  [ "$#" -ge 2 ] || { echo "usage: $0 <prompt.txt> <out.md> [model]" >&2; exit 2; }
  PROMPT_FILE="$1"; OUT="$2"; MODEL="${3:-$MODEL_DEFAULT}"
  [ -s "$PROMPT_FILE" ] || { echo "prompt file is empty or missing: $PROMPT_FILE" >&2; exit 2; }
  mkdir -p "$(dirname "$OUT")"
  codex --search exec --skip-git-repo-check -s read-only -m "$MODEL" \
    -c model_reasoning_effort='"low"' -o "$OUT" "$(cat "$PROMPT_FILE")

$TAIL" > "$OUT.log" 2>&1 < /dev/null
fi

if [ -s "$OUT" ]; then
  echo "done: $OUT ($(wc -c < "$OUT" | tr -d ' ') bytes)"
else
  echo "no output. Check $OUT.log"
  grep -i -m1 "usage limit" "$OUT.log" && echo "usage limit hit: wait or top up, then --resume"
  grep -i -m1 -E "session id|session:" "$OUT.log"
  exit 1
fi
