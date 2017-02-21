#!/bin/bash

killall ffmpeg
rm /usr/local/nginx/html/rtmp-hls/hls/*
ffmpeg -y -i http://localhost:10102/tiviturk.m3u8 -c:v libx264 -b:a 128k -vf "scale=480:trunc(ow/a/2)*2" -tune zerolatency -preset veryfast -crf 29  -vprofile baselin$
          -hls_flags delete_segments  -hls_list_size 8 -hls_segment_filename "/usr/local/nginx/html/rtmp-hls/hls/livelow%d.ts" /usr/local/nginx/html/rtmp-hls/hls/low.$
          -c:v libx264 -b:a 128k -vf "scale=720:trunc(ow/a/2)*2" -tune zerolatency -preset veryfast -crf 29  -vprofile baseline -acodec aac -strict -2 -framerate 20  \
          -hls_flags delete_segments  -hls_list_size 8 -hls_segment_filename "/usr/local/nginx/html/rtmp-hls/hls/livemid%d.ts" /usr/local/nginx/html/rtmp-hls/hls/mid.$
          -c:v libx264 -b:a 128k -vf "scale=1280:trunc(ow/a/2)*2" -tune zerolatency -preset veryfast -crf 29  -vprofile baseline -acodec aac -strict -2 -framerate 20 $
          -hls_flags delete_segments  -hls_list_size 8 -hls_segment_filename "/usr/local/nginx/html/rtmp-hls/hls/livehd720%d.ts" /usr/local/nginx/html/rtmp-hls/hls/hd$

cat /tmp/ffmpids 


