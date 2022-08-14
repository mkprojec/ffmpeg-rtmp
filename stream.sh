#! /bin/bash

VBR="1500k"
FPS="30"
QUAL="ultrafast"
RTMP_URL="rtmps://live-api-s.facebook.com:443/rtmp/"
RTMP_KEY="FB-548535630111633-0-AbxsW2huFgZWe4Tf"
VIDEO_SOURCE="videos/Code.mp4"
AUDIO_SOURCE="mp3/sound1.mp3"
AUDIO_ENCODER="aac"

ffmpeg \
 -stream_loop -1 \
 -re \
 -i "$VIDEO_SOURCE" \
 -thread_queue_size 512 \
 -stream_loop -1 \
 -i "$AUDIO_SOURCE" \
 -c:v libx264 -preset $QUAL -r $FPS -g $(($FPS *2)) -b:v $VBR \
 -c:a $AUDIO_ENCODER -threads 6 -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p \
 -fflags +shortest -max_interleave_delta 50000 \
 -f flv $RTMP_URL/$RTMP_KEY
