#!/bin/sh

curl -L -O https://archive.apache.org/dist/arrow/arrow-22.0.0/apache-arrow-22.0.0.tar.gz

tar xvfz apache-arrow-22.0.0.tar.gz
cd apache-arrow-22.0.0

brew install apache-arrow

cmake -S cpp -B build \
      -DCMAKE_INSTALL_PREFIX=/tmp/local \
      -DARROW_DEPENDENCY_SOURCE=SYSTEM \
      -DARROW_ACERO=ON \
      -DARROW_COMPUTE=ON \
      -DARROW_CSV=ON \
      -DARROW_DATASET=ON \
      -DARROW_FILESYSTEM=ON \
      -DARROW_FLIGHT=ON \
      -DARROW_FLIGHT_SQL=ON \
      -DARROW_GANDIVA=ON \
      -DARROW_HDFS=ON \
      -DARROW_JSON=ON \
      -DARROW_ORC=OFF \
      -DARROW_PARQUET=ON \
      -DARROW_PROTOBUF_USE_SHARED=ON \
      -DARROW_S3=ON \
      -DARROW_WITH_BZ2=ON \
      -DARROW_WITH_ZLIB=ON \
      -DARROW_WITH_ZSTD=ON \
      -DARROW_WITH_LZ4=ON \
      -DARROW_WITH_SNAPPY=ON \
      -DARROW_WITH_BROTLI=ON \
      -DARROW_WITH_UTF8PROC=ON \
      -DARROW_INSTALL_NAME_RPATH=OFF \
      -DPARQUET_BUILD_EXECUTABLES=ON \
      -DARROW_MIMALLOC=ON \
      -DCMAKE_SHARED_LINKER_FLAGS=-Wl,-dead_strip_dylibs 

cmake --build build
cmake --install build

meson setup build c_glib std_meson_args
  
meson setup \
      --backend=ninja \
      --prefix=/tmp/local \
      --libdir=lib \
      --pkg-config-path=/tmp/local/lib/pkgconfig \
      c_glib.build \
      c_glib

meson compile -C c_glib.build --verbose
meson install -C c_glib.build


