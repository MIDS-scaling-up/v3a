#!/bin/sh

IMG='pt'
docker run --privileged --gpus all --ipc=host --rm -v /data:/data -e DISPLAY -v /tmp:/tmp -ti ${IMG} bash
