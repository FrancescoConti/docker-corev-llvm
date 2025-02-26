#!/bin/bash
open -a Docker
docker image tag fconti/corev-llvm:latest fconti/corev-llvm:arm64
docker push fconti/corev-llvm:arm64
