ARG VERSION=20.04
FROM ubuntu:$VERSION


ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Los_Angeles
RUN <<EOF bash
  apt update -y 
  apt upgrade -y 
  
  # So that we don't get interactive messages
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
  # Install tzdata
  apt install -y tzdata 
  ln -fs /usr/share/zoneinfo/$TZ etc/localtime 
  dpkg-reconfigure --frontend nointeractive tzdata
  
  apt install -y build-essential g++ git autoconf automake autotools-dev \
    bison xxd curl flex gawk gdisk gperf libgmp-dev \
    libmpfr-dev libmpc-dev libz-dev libssl-dev libncurses-dev \
    libtool patchutils python screen unzip zlib1g-dev \
    libyaml-dev wget cpio bc dosfstools mtools  \
    device-tree-compiler git-lfs kpartx  \
    texinfo libglib2.0-dev libpixman-1-dev  \
    gcc-riscv64-linux-gnu \
    vim rsync
EOF
WORKDIR /vision-v2
COPY build.sh ./
COPY lvm2site.patch ./
COPY help-message ./
ENTRYPOINT  exec /bin/bash -rcfile /vision-v2/help-message

