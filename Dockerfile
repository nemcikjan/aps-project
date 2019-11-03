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
    time

RUN wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.80.tar.xz

RUN unxz -v linux-4.19.80.tar.xz

RUN tar xvf linux-4.19.80.tar

COPY ./.config linux-4.19.80/

ENTRYPOINT [ "/bin/bash", "/usr/bin/time -o time_file_docker make --directory ./linux-4.19.80" ]