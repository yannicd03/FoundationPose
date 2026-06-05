#!/bin/bash
# Build ONLY the mycpp C++ extension (model-based path). Skips kaolin and
# bundlesdf (model-free / NeRF only), which the stock build_all.sh would try.
# Run once inside the container after first launch.
set -e
DIR=$(cd "$(dirname "$0")" && pwd)
cd "$DIR/mycpp" && mkdir -p build && cd build
cmake .. -DPYTHON_EXECUTABLE="$(which python)"
make -j"$(nproc)"
echo "[build_mycpp] done -> $DIR/mycpp/build"
