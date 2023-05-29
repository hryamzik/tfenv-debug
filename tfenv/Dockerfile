FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAGRUNT_VERSION=0.44.5
ENV TERRAFORM_VERSION=1.3.0
ENV TFENV_VERSION=3.0.0

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y software-properties-common gnupg \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 9578539176BAFBC6 \
    && add-apt-repository ppa:rmescandon/yq -y \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y \
    curl \
    git \
    gzip \
    jq \
    python3-pip \
    ssh \
    unzip \
    uuid-runtime \
    xmlstarlet \
    yq \
    && pip install jinja-cli \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -s -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf ./aws && rm awscliv2.zip \
    && aws --version \
    && apt-get remove software-properties-common gnupg -y \
    && apt autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* \
    && rm -rf /var/log/*.log

# source https://github.com/gruntwork-io/terragrunt
RUN cd /tmp \
    && curl -s -L https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_$(dpkg --print-architecture) --output terragrunt \
    && mv terragrunt /usr/bin/terragrunt \
    && chmod +x /usr/bin/terragrunt \
    && rm -rf /tmp/*

# source https://github.com/tfutils/tfenv
# note Add Tf version that are widely used (to save download time during pipeline runs). Non-listed version will be downloaded at runtime.
RUN cd /tmp \
    && git clone --depth 1 --branch v${TFENV_VERSION} https://github.com/tfutils/tfenv.git ~/.tfenv \
    && ln -s ~/.tfenv/bin/* /usr/bin/ \
    && tfenv init \
    && tfenv install 1.3.3 \
    && tfenv install 1.2.2 \
    && tfenv install 1.1.9 \
    && tfenv install 1.1.3 \
    && tfenv install 1.0.11 \
    && tfenv install 1.0.9 \
    && tfenv install 1.0.2 \
    && tfenv install 1.0.1 \
    && tfenv install 0.12.31 \
    && tfenv install ${TERRAFORM_VERSION} \
    && tfenv use ${TERRAFORM_VERSION} \
    && rm -rf /tmp/*

# COPY code /code/
WORKDIR /code/terragrunt/

CMD ["sleep", "infinity"]
