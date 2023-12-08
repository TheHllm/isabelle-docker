## Dockerfile for Isabelle2023

FROM ubuntu
SHELL ["/bin/bash", "-c"]

# packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && \
  apt-get install -y curl less libfontconfig1 libgomp1 openssh-client perl pwgen rlwrap texlive-bibtex-extra texlive-fonts-extra texlive-font-utils texlive-latex-extra texlive-science && \
  apt-get clean && \
  useradd -m isabelle && (echo isabelle:isabelle | chpasswd)

USER isabelle

# Isabelle
WORKDIR /home/isabelle
RUN curl https://isabelle.in.tum.de/dist/Isabelle2023_linux.tar.gz -o Isabelle2023_linux.tar.gz && tar xzf Isabelle2023_linux.tar.gz && \
  mv Isabelle2023 Isabelle && \
  perl -pi -e 's,ISABELLE_HOME_USER=.*,ISABELLE_HOME_USER="\$USER_HOME/.isabelle",g;' Isabelle/etc/settings && \
  perl -pi -e 's,ISABELLE_LOGIC=.*,ISABELLE_LOGIC=HOL,g;' Isabelle/etc/settings && \
  Isabelle/bin/isabelle build -o system_heaps -b HOL && \
  rm Isabelle2023_linux.tar.gz && \
  curl -L https://github.com/isabelle-prover/isabelle-linter/archive/refs/tags/Isabelle2023-v1.0.0.tar.gz -o  isabelle-linter.tar.gz && \
  tar xzf isabelle-linter.tar.gz && rm -rf isabelle-linter.tar.gz && \
  Isabelle/bin/isabelle components -u isabelle-linter-Isabelle2023-v1.0.0

ENTRYPOINT ["Isabelle/bin/isabelle"]
