#! /bin/bash

VBR="1500k"
FPS="30"
QUAL="ultrafast"
YOUTUBE_URL="rtmp"
YOUTUBE_KEY="your key"
VIDEO_SOURCE="your video (mp4)"
AUDIO_SOURCE="your mp3"
AUDIO_ENCODER="aac"

ffmpeg \
 -stream_loop -1 \
 -re \
 -i "$VIDEO_SOURCE" \
 -thread_queue_size 512 \
 -i "$AUDIO_SOURCE" \
 -c:v libx264 -preset $QUAL -r $FPS -g $(($FPS *2)) -b:v $VBR \
 -c:a $AUDIO_ENCODER -threads 6 -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p \
 -fflags +shortest -max_interleave_delta 50000 \
 -f flv $YOUTUBE_URL/$YOUTUBE_KEY
