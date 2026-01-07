FROM registry.access.redhat.com/ubi9/ubi-init

# Install required packages
RUN dnf -y install \
      openssh-server \
      python3 \
      python3-dnf \
      sudo \
      iproute \
      hostname \
      procps-ng \
    && dnf -y clean all \
    && rm -rf /var/cache/dnf

# Create SSH host keys
RUN ssh-keygen -A

# Create ansible user
RUN useradd -m -s /bin/bash ansible \
    && echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible \
    && chmod 0440 /etc/sudoers.d/ansible

RUN echo "ansible:ansible" | chpasswd

# Enable sshd
RUN systemctl enable sshd

EXPOSE 22

CMD ["/sbin/init"]
