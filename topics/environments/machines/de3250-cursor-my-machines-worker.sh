#!/bin/sh
# DE3250 の Cursor My Machines worker を、ターミナルで動かしていたのと同じ形で起動する。
# 正本はこのファイル。実体は ~/.local/bin/cursor-my-machines-worker に置く。
# 認証は agent login 済みの ~/.config/cursor/auth.json を使う。鍵は書かない。
set -eu

agent=/home/k/.local/bin/agent
workdir=/home/k/src/shared-knowledge
# Cursor IDE が globalStorage から起動する別 worker には一致させない。
pattern='/\.local/bin/agent --use-system-ca .*/index\.js worker start$'

if [ ! -x "$agent" ]; then
  echo "missing $agent" >&2
  exit 1
fi
if [ ! -d "$workdir" ]; then
  echo "missing $workdir" >&2
  exit 1
fi

i=0
while [ "$i" -lt 60 ]; do
  if getent hosts api2.cursor.sh >/dev/null 2>&1; then
    break
  fi
  i=$((i + 1))
  sleep 2
done

if pgrep -u "$(id -u)" -f "$pattern" >/dev/null 2>&1; then
  echo "CLI worker already running; waiting to take over" >&2
  while pgrep -u "$(id -u)" -f "$pattern" >/dev/null 2>&1; do
    sleep 15
  done
fi

echo "starting agent worker in $workdir" >&2
cd "$workdir"
exec "$agent" worker start
