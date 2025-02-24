#
# Stage 1: building GVSOC & PULP GCC on non-Linux platforms
#
FROM ubuntu:24.04 AS builder
RUN apt update && apt upgrade -y
ENV TZ=Europe/Rome

RUN DEBIAN_FRONTEND=noninteractive apt-get update

# install deps
RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends --allow-unauthenticated \
build-essential

RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends --allow-unauthenticated \
git \
doxygen \
python3-pip \
libsdl2-dev \
curl \
cmake \
ccache \
ninja-build

#gtkwave \
#libsndfile1-dev \
#rsync \
#autoconf \
#automake \
#texinfo \
#libtool \
#pkg-config \
#libsdl2-ttf-dev
#
## install deps (GCC)
#RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends --allow-unauthenticated \
#autotools-dev \
#libmpc-dev \
#libmpfr-dev \
#libgmp-dev \
#gawk \
#bison \
#flex \
#gperf \
#patchutils \
#bc \
#zlib1g-dev \
#ninja-build
#
## # Set the locale, because Vivado crashes otherwise
## ENV LANG=en_US.UTF-8
## ENV LANGUAGE=en_US:en
# ENV LC_ALL=en_US.UTF-8

WORKDIR /app/

# clone LLVM
RUN git clone https://github.com/openhwgroup/corev-llvm-project.git
RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends --allow-unauthenticated \
cmake \
ccache \
lld

# build CMake
RUN cd corev-llvm-project && cmake -S llvm -B build -G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_CCACHE_BUILD=On \
-DLLVM_BUILD_TESTS=Off \
-DLLVM_TARGETS_TO_BUILD=RISCV \
-DLLVM_ENABLE_PROJECTS="clang;lld" \
-DLLVM_ENABLE_LIBCXX=Off \
-DBUILD_SHARED_LIBS=Off \
-DLLVM_BUILD_EXAMPLES=Off \
-DLLVM_ENABLE_BINDINGS=Off \
-DLLVM_ENABLE_WARNINGS=On \
-DLLVM_USE_LINKER=lld \
-DLLVM_OPTIMIZED_TABLEGEN=On
RUN cd corev-llvm-project && cmake --build build
