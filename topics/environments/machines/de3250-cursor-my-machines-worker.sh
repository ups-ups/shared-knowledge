#!/bin/sh
# DE3250 の Cursor My Machines worker を起動する。
# 正本はこのファイル。実体は ~/.local/bin/cursor-my-machines-worker に置く。
# 認証は agent login 済みの ~/.config/cursor/auth.json を使う。鍵は書かない。
#
# 未設定時は shared-knowledge を、ターミナルで動かしていたのと同じ
# `agent worker start`（追加フラグなし）で起動する。
# corp-analysis は unit から CURSOR_WORKER_DIR / CURSOR_WORKER_DATA_DIR /
# CURSOR_WORKER_NAME を渡す。data dir を分けるのは、同じ data dir の
# worker.lock を二つ同時に取れないため。
set -eu

agent=/home/k/.local/bin/agent
workdir=${CURSOR_WORKER_DIR:-/home/k/src/shared-knowledge}
data_dir=${CURSOR_WORKER_DATA_DIR:-}
name=${CURSOR_WORKER_NAME:-}

if [ -n "$data_dir" ]; then
  # IDE 起動（--worker-dir）と、このスクリプトの起動の両方に一致させる。
  pattern="--worker-dir ${workdir}"
else
  # `worker start` で終わる CLI だけ。IDE の corp-analysis worker には一致させない。
  pattern='/\.local/bin/agent --use-system-ca .*/index\.js worker start$'
fi

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

# パターンが `--` で始まるので、pgrep のオプション区切りが必要。
if pgrep -u "$(id -u)" -f -- "$pattern" >/dev/null 2>&1; then
  echo "worker already running for $workdir; waiting to take over" >&2
  while pgrep -u "$(id -u)" -f -- "$pattern" >/dev/null 2>&1; do
    sleep 15
  done
fi

cd "$workdir"
set -- worker
if [ -n "$data_dir" ]; then
  mkdir -p "$data_dir"
  set -- "$@" --data-dir "$data_dir" --worker-dir "$workdir"
fi
if [ -n "$name" ]; then
  set -- "$@" --name "$name"
fi
set -- "$@" start

echo "starting agent worker in $workdir" >&2
exec "$agent" "$@"
