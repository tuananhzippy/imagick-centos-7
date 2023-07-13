#!/bin/bash

sudo yum update -y
sudo yum groupinstall -y "Development Tools"
sudo yum install -y epel-release

sudo yum install -y libjpeg-devel libpng-devel libtiff-devel freetype-devel libwmf-devel ghostscript-devel djvulibre-devel librsvg2-devel libfftw3-devel lcms2-devel pango-devel libxml2-devel fftw3-devel djvulibre-devel gperftools-devel graphviz-devel libgsf-devel jbig2dec-devel jemalloc-devel openjpeg2-devel libraqm-devel LibRaw-devel libzip-devel bzip2-devel x265-devel libaom-devel 
sudo yum install -y libtool-ltdl-devel lzma-sdk-devel OpenEXR-devel perl-devel
sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm

vi ~/.bash_profile
# Thêm đoạn sau vào cuối cùng của file
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig"
source ~/.bash_profile

cd /root

wget https://github.com/strukturag/libde265/releases/download/v1.0.11/libde265-1.0.11.tar.gz
tar xf libde265-1.0.11.tar.gz
cd libde265-1.0.11
./autogen.sh
./configure
make
sudo make install
sudo ldconfig

cd ..

wget https://github.com/strukturag/libheif/releases/download/v1.15.2/libheif-1.15.2.tar.gz
tar xf libheif-1.15.2.tar.gz
cd libheif-1.15.2
./autogen.sh
./configure
make
sudo make install
sudo ldconfig

cd ..

wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.1.0.tar.gz
tar xf libwebp-1.1.0.tar.gz
cd libwebp-1.1.0
./configure
make
sudo make install
sudo ldconfig

# Kiểm tra xem libde265 & libheif
pkg-config --exists --print-errors libde265
pkg-config --exists --print-errors libheif

# Nếu không có thông báo hiện ra --> thành công
# Nếu có thông báo hiện ra --> chưa thành công. Thực hiện các bước sau để fix

sudo find / -name "libheif.pc" 2>/dev/null

# Nếu hiển thị như bên dưới là OK. Cần
# /root/libheif-1.12.0/libheif.pc
# /usr/local/lib/pkgconfig/libheif.pc

wget https://www.imagemagick.org/download/ImageMagick.tar.gz
tar xf ImageMagick.tar.gz
cd ImageMagick-*
./configure \
  --with-bzlib=yes \
  --with-djvu=yes \
  --with-dps=yes \
  --with-fftw=yes \
  --with-flif=yes \
  --with-fontconfig=yes \
  --with-fpx=yes \
  --with-freetype=yes \
  --with-gslib=yes \
  --with-gvc=yes \
  --with-heic=yes \
  --with-jbig=yes \
  --with-jemalloc=yes \
  --with-jpeg=yes \
  --with-jxl=yes \
  --with-lcms=yes \
  --with-lqr=yes \
  --with-lzma=yes \
  --with-magick-plus-plus=yes \
  --with-openexr=yes \
  --with-openjp2=yes \
  --with-pango=yes \
  --with-perl=yes \
  --with-png=yes \
  --with-raqm=yes \
  --with-raw=yes \
  --with-rsvg=yes \
  --with-tcmalloc=yes \
  --with-tiff=yes \
  --with-webp=yes \
  --with-wmf=yes \
  --with-x=yes \
  --with-xml=yes \
  --with-zip=yes \
  --with-zlib=yes \
  --with-zstd=yes \
  --with-gcc-arch=native
make
sudo make install
convert -version

# kiểm tra xem đã cài đặt thành công modules chưa 
# Version: ImageMagick 7.1.1-9 Q16-HDRI x86_64 21158 https://imagemagick.org
# Copyright: (C) 1999 ImageMagick Studio LLC
# License: https://imagemagick.org/script/license.php
# Features: Cipher DPC HDRI Modules OpenMP(3.1) 
# Delegates (built-in): cairo djvu fftw fontconfig freetype heic jng jpeg lcms ltdl lzma pangocairo png rsvg tiff webp wmf x xml zlib
# Compiler: gcc (4.8)

# Issues: https://github.com/strukturag/libheif/issues/800