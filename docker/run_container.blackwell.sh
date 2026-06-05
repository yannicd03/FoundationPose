#!/bin/bash
# Launch the Blackwell FoundationPose container, headless (EGL offscreen).
# Mounts /home so both the FoundationPose repo and the kip-pose-detection scene
# data (/home/yannic/code/kip-pose-detection/foundationpose/...) are visible.
docker rm -f foundationpose 2>/dev/null
FPDIR=$(cd "$(dirname "$0")/.." && pwd)
docker run --gpus all --env NVIDIA_DISABLE_REQUIRE=1 -it --network=host \
  --name foundationpose --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
  -v /home:/home -v /tmp:/tmp --ipc=host \
  -e PYOPENGL_PLATFORM=egl -e OPENCV_IO_ENABLE_OPENEXR=1 \
  foundationpose:blackwell bash -c "cd '$FPDIR' && bash"
