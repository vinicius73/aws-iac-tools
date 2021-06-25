FROM amazon/aws-cli:2.2.14

WORKDIR /project
RUN mkdir -p /project

RUN yum -y install unzip

RUN cd /tmp && \
  curl https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip --output terraform.zip && \
  unzip terraform.zip && \
  mv terraform /usr/local/bin/ && \
  rm -rf /tmp/* && \
  terraform --version

RUN echo "alias ll='ls -l'" >> /root/.bashrc && \
  echo "complete -C /usr/local/bin/terraform terraform" >> /root/.bashrc && \
  echo 'PS1="\n\[\e[0;31m\]┌─[\[\e[0m\]\[\e[1;33m\]\u\[\e[0m\] ܁\[\e[1;36m\]\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[0;31m\]]\n\[\e[0;31m\]└─\e[0;31m\]$ \[\e[0m\]"' >> /root/.bashrc

ENTRYPOINT ["bash"]
