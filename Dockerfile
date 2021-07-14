FROM amazon/aws-cli:2.2.18 as dowloader

RUN yum -y install unzip

ARG TERRAFORM_VER=1.0.2

RUN cd /tmp && \
  curl https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip --output terraform.zip && \
  unzip terraform.zip && \
  mv terraform /usr/local/bin/ && \
  rm -rf /tmp/* && \
  terraform --version

FROM amazon/aws-cli:2.2.18

WORKDIR /project
RUN mkdir -p /project

COPY --from=dowloader --chown=root:root /usr/local/bin/terraform /usr/local/bin/terraform

RUN echo "alias ll='ls -l'" >> /root/.bashrc && \
  echo "complete -C /usr/local/bin/terraform terraform" >> /root/.bashrc && \
  echo 'PS1="\n\[\e[0;31m\]┌─[\[\e[0m\]\[\e[1;33m\]\u\[\e[0m\] ܁\[\e[1;36m\]\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[0;31m\]]\n\[\e[0;31m\]└─\e[0;31m\]$ \[\e[0m\]"' >> /root/.bashrc

ENV TF_PLUGIN_CACHE_DIR=/project/.terraform.d/plugin-cache

ENTRYPOINT ["bash"]
