FROM ubuntu:latest

ARG USERNAME="dev"
ENV USERNAME=${USERNAME}

RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sudo adduser ${USERNAME} --disabled-password  && \
    mkdir -p /home/${USERNAME}/.ssh && \
    mkdir -p /run/sshd && \
    touch /home/${USERNAME}/.ssh/authorized_keys

RUN echo "HostKeyAlgorithms +ssh-rsa" >>/etc/ssh/sshd_config && \
    echo "PubkeyAcceptedKeyTypes +ssh-rsa" >>/etc/ssh/sshd_config

COPY --chown=${USERNAME}:${USERNAME} ./docker-entrypoint.sh .

CMD ["./docker-entrypoint.sh"]
