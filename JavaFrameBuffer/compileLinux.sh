#!/bin/sh

jniResult=libFrameBufferJNI.so

jniJdkHeader=/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt/include
jniSysHeader=/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt/include/linux

rm "$jniResult" 2>/dev/null

echo "javah"
javah -d src/main/c  -classpath bin org.tw.pi.framebuffer.FrameBuffer
rm src/main/c/org_tw_pi_framebuffer_FrameBuffer_ScreenPanel.h
rm src/main/c/org_tw_pi_framebuffer_FrameBuffer_UpdateThread.h


echo "gcc"
gcc -Wall -O2 -o "$jniResult" -shared -I "$jniJdkHeader"  -I "$jniSysHeader" -I src/main/c src/main/c/FrameBuffer.c 

echo
ls -l "$jniResult"

javac -classpath src/main/java src/main/java/org/tw/pi/framebuffer/*.java

echo "done"

