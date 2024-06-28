FROM debian:trixie-20231218
ARG JOB_HOST_GNU_TYPE_PACKAGE
ARG JOB_HOST_ARCH
COPY 99ignore-release-date /etc/apt/apt.conf.d/99ignore-release-date
RUN apt-get update
RUN apt-get install --no-install-recommends -qy golang-go
# golang-google-protobuf go-md2man-v2  golang-blackfriday-v2 golang-dbus golang-github-checkpoint-restore-go-criu golang-github-cilium-ebpf golang-github-containerd-console golang-github-coreos-go-systemd  golang-github-cyphar-filepath-securejoin golang-github-docker-go-units  golang-github-moby-sys golang-github-mrunalp-fileutils  golang-github-opencontainers-selinux golang-github-opencontainers-specs  golang-github-urfave-cli  golang-github-vishvananda-netlink  golang-github-vishvananda-netns  golang-gocapability-dev golang-golang-x-sys golang-google-protobuf  golang-logrus
COPY debian.sources /etc/apt/sources.list.d/debian.sources
RUN apt-get update
RUN apt-mark hold libc6
RUN apt-get install -qy --no-install-recommends ca-certificates golang-github-containerd-ttrpc-dev
RUN apt-mark hold golang-github-containerd-ttrpc-dev
RUN apt-get install -qy --no-install-recommends binutils-$JOB_HOST_GNU_TYPE_PACKAGE gcc-$JOB_HOST_GNU_TYPE_PACKAGE g++-$JOB_HOST_GNU_TYPE_PACKAGE libc6-dev:$JOB_HOST_ARCH
