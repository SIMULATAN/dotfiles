git clone --single-branch --branch next-yshui --depth=1 https://github.com/vcyzteen/picom.git
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build install
