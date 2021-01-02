# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

#!/bin/bash
# NDK的路径，根据自己的安装位置进行设置
NDK_HOME=/opt/android-ndk-r21d
# 编译针对的平台，可以根据自己的需求进行设置
# 这里选择最低支持android-14, arm架构，生成的so库是放在
# libs/armeabi文件夹下的，若针对x86架构，要选择arch-x86
# 工具链的路径，根据编译的平台不同而不同
# arm-linux-androideabi-4.9与上面设置的PLATFORM对应，4.9为工具的版本号，
# 根据自己安装的NDK版本来确定，一般使用最新的版本
ANDROID_BIN=$NDK_HOME/toolchains/llvm/prebuilt/linux-aarch64/bin/

CROSS_COMPILE=${ANDROID_BIN}/i686


CPU=x86

PREFIX=/var/ffmpeg/$CPU


FDK_INCLUDE=$PREFIX/include

echo $FDK_INCLUDE
FDK_LIB=$PREFIX/lib
echo $FDK_LIB
X264_INCLUDE=$PREFIX/include

X264_LIB=$PREFIX/lib

FF_EXTRA_CFLAGS="-O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8 "
FF_CFLAGS="-O3 -Wall -pipe \
-ffast-math \
-fstrict-aliasing -Werror=strict-aliasing \
-Wno-psabi -Wa,--noexecstack \
-DANDROID  "

rm "./compat/strtod.o"
NDK_HOME=/opt/android-ndk-r21d
ANDROID_API=android-21
ABI=21




build_one(){
./configure \
--prefix=$PREFIX \
--enable-cross-compile \
--disable-runtime-cpudetect \
--enable-asm \
--arch=x86 \
--target-os=android \
--cc=${CROSS_COMPILE}-linux-android$ABI-clang-fake \
--cxx=${CROSS_COMPILE}-linux-android$ABI-clang++-fake \
--disable-stripping \
--nm=${CROSS_COMPILE}-linux-android-nm-fake  \
--extra-cflags="-I$X264_INCLUDE  -I$FDK_INCLUDE " \
--extra-ldflags="-L$FDK_LIB -L$X264_LIB -lm" \
--enable-gpl \
--enable-shared \
--disable-static \
--enable-version3 \
--enable-pthreads \
--enable-small \
--disable-iconv \
--enable-encoders \
--enable-libx264 \
--enable-neon \
--enable-yasm \
--enable-libfdk_aac \
--enable-encoder=libx264 \
--enable-encoder=libfdk_aac \
--enable-encoder=mjpeg \
--enable-encoder=png \
--enable-nonfree \
--enable-muxers \
--enable-decoders \
--enable-demuxers \
--enable-parsers \
--enable-protocols \
--enable-zlib \
--enable-avfilter \
--disable-outdevs \
--disable-ffprobe \
--disable-ffplay \
--disable-ffmpeg \
--disable-debug \
--disable-ffprobe \
--disable-ffplay \
--disable-ffmpeg \
--disable-postproc \
--disable-avdevice \
--disable-symver \
--disable-stripping \
--extra-cflags="$FF_EXTRA_CFLAGS  $FF_CFLAGS" \
--extra-ldflags="  "
}
build_one



make clean
make -j4
make install

