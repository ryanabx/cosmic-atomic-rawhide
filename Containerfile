ARG BASE_IMAGE="quay.io/fedora-ostree-desktops/base"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}

# Setup Copr repo
RUN wget https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-40/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_ryanabx-cosmic.repo

# Install cosmic desktop environment
RUN rpm-ostree install cosmic-desktop

# Install extras
RUN rpm-ostree install \
    gnome-keyring \
    power-profiles-daemon

RUN ostree container commit

RUN systemctl enable cosmic-greeter