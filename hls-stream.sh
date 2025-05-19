#!/bin/bash
DISPLAY=$1
# continuously grab the X11 framebuffer, encode to HLS with low-latency settings
ffmpeg -f x11grab -r 24 -s 1920x1080 -i ${DISPLAY} \
  -c:v libx264 -preset veryfast -g 48 -keyint_min 48 \
  -sc_threshold 0 -b:v 2M -maxrate 2M -bufsize 4M \
  -f hls \
    -hls_time 2 \
    -hls_list_size 3 \
    -hls_flags delete_segments+program_date_time \
    /var/www/html/stream.m3u8