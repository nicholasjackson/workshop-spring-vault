FROM ghcr.io/jumppad-labs/vscode:base-v0.4.0

ARG TARGETARCH
ARG VAULT_VERSION=1.15.6
ARG JDK_VERSION=21
ARG GRADLE_VERSION=8.7

# Install default packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    curl \
    wget \
    zip \
    git \
    jq \
    build-essential \
    postgresql-client

# Clean packages
RUN rm -rf /var/lib/apt/lists/*

# Install Java
RUN if [ "${TARGETARCH}" = "amd64" ]; then TARGETARCH="x64"; \
  wget https://download.oracle.com/java/${JDK_VERSION}/latest/jdk-${JDK_VERSION}_linux-${TARGETARCH}_bin.deb; \
  dpkg -i jdk-${JDK_VERSION}_linux-${TARGETARCH}_bin.deb; \
  mv /usr/lib/jvm/jdk-${JDK_VERSION}-oracle-x64 /opt/java; fi

RUN if [ "${TARGETARCH}" = "arm64" ]; then TARGETARCH="aarch64"; \
  mkdir -p /tmp/java; \
  wget https://download.oracle.com/java/${JDK_VERSION}/latest/jdk-${JDK_VERSION}_linux-${TARGETARCH}_bin.tar.gz; \
  tar -xzf jdk-${JDK_VERSION}_linux-${TARGETARCH}_bin.tar.gz -C /tmp/java; \
  mv $(find /tmp/java -mindepth 1 -maxdepth 1 -type d) /opt/java; fi

# Install Vault
RUN wget -O vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_${TARGETARCH}.zip && \
  unzip vault.zip && \
  mv vault /usr/local/bin

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" && \
  mv ./kubectl /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip && \
  unzip -d /tmp/gradle /tmp/gradle.zip && \
  mv /tmp/gradle/ /usr/local/bin/

# Install VSCode extensions
RUN code-server --install-extension hashicorp.terraform && \
    code-server --install-extension hashicorp.hcl && \
    code-server --install-extension github.github-vscode-theme && \
    code-server --install-extension pkief.material-icon-theme && \
    code-server --install-extension vscjava.vscode-java-pack

ENV PATH="${PATH}:/opt/java/bin"
ENV JAVA_HOME="/opt/java"