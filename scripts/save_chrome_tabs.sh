#!/bin/bash
# Save web pages as HTML through the user's own Google Chrome (macOS only).
#
# For sites that show a bot check to automated browsers but load normally for a
# person. Use only with the user's go-ahead: it opens tabs in their Chrome.
# It does not solve CAPTCHAs — a page that still shows a check is reported as BLOCKED.
#
# Usage:
#   save_chrome_tabs.sh <outdir> name=url [name=url ...]
# Example:
#   save_chrome_tabs.sh pages ro-wl=https://ro.co/weight-loss/ hims-ed=https://www.hims.com/sexual-health
#
# Output: <outdir>/<name>.html   Then: python3 -I extract_text.py <outdir>

set -u
if [ "$#" -lt 2 ]; then
  echo "usage: $0 <outdir> name=url [name=url ...]" >&2; exit 2
fi
if ! command -v osascript >/dev/null 2>&1; then
  echo "This script needs macOS (osascript) and Google Chrome." >&2; exit 1
fi

mkdir -p "$1"
D="$(cd "$1" && pwd)"; shift

for pair in "$@"; do
  name="${pair%%=*}"; url="${pair#*=}"
  res=$(osascript <<OSA
tell application "Google Chrome"
  if (count of windows) = 0 then make new window
  set theTab to make new tab at end of tabs of front window with properties {URL:"$url"}
  delay 3
  set n to 0
  repeat while n < 14
    set ttl to title of theTab
    if (loading of theTab is false) and (ttl does not contain "Just a moment") and (ttl is not "") then exit repeat
    delay 2
    set n to n + 1
  end repeat
  set ttl to title of theTab
  if ttl contains "Just a moment" or ttl contains "Captcha" or ttl contains "Access denied" then
    close theTab
    return "BLOCKED: " & ttl
  end if
  delay 2
  save theTab in POSIX file "$D/$name.html" as "only html"
  set finalUrl to URL of theTab
  delay 1
  close theTab
  return "OK: " & ttl & " | " & finalUrl
end tell
OSA
)
  echo "$name -> $res"
done

sleep 2
ls -la "$D" | awk 'NR>1 {print $5, $9}'
