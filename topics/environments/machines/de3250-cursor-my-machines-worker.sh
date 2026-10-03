#!/bin/sh
# DE3250 の Cursor My Machines worker を起動する。
# 正本はこのファイル。実体は ~/.local/bin/cursor-my-machines-worker に置く。
# 認証は ~/.config/cursor/worker.env の CURSOR_API_KEY。鍵はリポジトリに書かない。
#
# 未設定時は shared-knowledge を起動する。
# Computer Use とデスクトップ共有は両方の worker に付ける。
# ログイン中の XFCE を操作しないよう、unit 側で DISPLAY を外す。
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
  # 旧 `worker start` と、Computer Use 付きの起動の両方。
  # corp-analysis は --data-dir が入るのでここには一致しない。
  pattern='/\.local/bin/agent --use-system-ca .*/index\.js worker( --computer-use --share-desktop)? start$'
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
# フラグは start より前。--share-desktop の既定は view_and_control。
set -- "$@" --computer-use --share-desktop
set -- "$@" start

echo "starting agent worker in $workdir" >&2
exec "$agent" "$@"
