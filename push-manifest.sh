#!/bin/bash
docker manifest create fconti/corev-llvm:latest \
  --amend fconti/corev-llvm:arm64 \
  --amend fconti/corev-llvm:x86_64
docker manifest push fconti/corev-llvm:latest
