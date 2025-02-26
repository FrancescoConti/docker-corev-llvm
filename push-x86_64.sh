#!/bin/bash
open -a Docker
docker image tag fconti/corev-llvm:latest fconti/corev-llvm:x86_64
docker push fconti/corev-llvm:x86_64
