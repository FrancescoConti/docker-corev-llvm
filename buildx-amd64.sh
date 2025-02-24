#!/bin/bash
docker buildx build --build-arg TMPDIR=/scratch/fconti/tmp --platform linux/amd64 -t fconti/corev-llvm -f Dockerfile --load .
