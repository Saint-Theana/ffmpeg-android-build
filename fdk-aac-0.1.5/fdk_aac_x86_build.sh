# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

NDK_HOME=/opt/android-ndk-r21d
ANDROID_API=android-21
ABI=21


ANDROID_BIN=$NDK_HOME/toolchains/llvm/prebuilt/linux-aarch64/bin/

CROSS_COMPILE=${ANDROID_BIN}/i686



CPU=x86


CFLAGS=" "

FLAGS="--enable-static --host=i686-linux --target=android  --disable-asm"

export CXX="${CROSS_COMPILE}-linux-android$ABI-clang++-fake"

export CXXFLAGS=$CFLAGS

export CFLAGS=$CFLAGS

export CC="${CROSS_COMPILE}-linux-android$ABI-clang-fake"

export AR="${CROSS_COMPILE}-linux-android-ar-fake"

export RANLIB="${CROSS_COMPILE}-linux-android-ranlib-fake"

export LD="${CROSS_COMPILE}-linux-android-ld-fake"

export AS="${CROSS_COMPILE}-linux-android$ABI-clang-fake"


./configure $FLAGS \
--enable-pic \
--enable-strip \
--prefix=/var/ffmpeg/$CPU

make clean
make -j8
make install
