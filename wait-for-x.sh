#!/bin/bash
for i in {1..10}; do
  if xdpyinfo -display :0 >/dev/null 2>&1; then
    exec x11vnc -display :0 -usepw -forever -shared
  fi
  sleep 1
done
echo "X server :0 not available"
exit 1 