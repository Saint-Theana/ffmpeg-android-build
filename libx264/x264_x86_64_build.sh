NDK_HOME=/opt/android-ndk-r21d
ANDROID_API=android-21
ABI=21


ANDROID_BIN=$NDK_HOME/toolchains/llvm/prebuilt/linux-aarch64/bin/

CROSS_COMPILE=${ANDROID_BIN}/x86_64



CPU=x86_64


CFLAGS=" "

FLAGS="--enable-static --host=x86_64-linux --target=android "

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
--disable-asm \
--extra-cflags="-Os -fpic -DX264_VERSION" \
--prefix=/var/ffmpeg/$CPU

make clean
make -j8
make install
