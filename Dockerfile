FROM debian

SHELL [ "/bin/bash", "-c" ]

RUN apt-get update && apt-get install -y \
    build-essential \
    libncurses-dev \
    bison \
    flex \
    libssl-dev \
    libelf-dev \
    bc \
    wget \
    time \
    curl

RUN wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.80.tar.xz

RUN unxz linux-4.19.80.tar.xz

RUN tar xf linux-4.19.80.tar

COPY ./.config linux-4.19.80/

COPY build-kernel_docker.sh .

ENTRYPOINT [ "./build-kernel_docker.sh"]

CMD ["/bin/exit"]