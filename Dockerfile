FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y texlive-full openjdk-18-jre wget && \
    wget https://isabelle.in.tum.de/dist/Isabelle2023_linux.tar.gz && \
    tar xvf Isabelle2023_linux.tar.gz && \
    rm -rf Isabelle2023_linux.tar.gz

ENTRYPOINT ["/Isabelle2023/bin/isabelle"]
