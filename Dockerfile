FROM debian:stable-slim

RUN apt-get update && apt-get install -y git less sudo curl wget unzip vim procps openssh-server \
    libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 \
    libarchive13 libxi6 libxtst6 bzip2

RUN mkdir /var/run/sshd
RUN echo 'root:admin' | chpasswd
RUN echo 'PermitRootLogin yes'   >> /etc/ssh/sshd_config.d/jupyter.conf
RUN echo 'AddressFamily any'     >> /etc/ssh/sshd_config.d/jupyter.conf
RUN echo 'ListenAddress 0.0.0.0' >> /etc/ssh/sshd_config.d/jupyter.conf
RUN echo 'PermitTunnel yes'      >> /etc/ssh/sshd_config.d/jupyter.conf

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN useradd -m jupyter -s /bin/bash
RUN echo 'jupyter:jupyter' | chpasswd
RUN usermod -aG sudo jupyter

RUN mkdir -p /home/jupyter/.ssh
RUN chown jupyter:jupyter /home/jupyter/.ssh
RUN chmod 700 /home/jupyter/.ssh
COPY ssh_keys/jupyter_rsa.pub /home/jupyter/.ssh/authorized_keys
RUN chown jupyter.jupyter /home/jupyter/.ssh/authorized_keys
RUN chmod 600 /home/jupyter/.ssh/authorized_keys

RUN mkdir -p /home/jupyter/workdir
RUN chown jupyter.jupyter /home/jupyter/workdir
WORKDIR /home/jupyter/workdir

COPY script/setup_anaconda_env.sh /setup_anaconda_env.sh
RUN chown jupyter.jupyter /setup_anaconda_env.sh
RUN chmod 777 /setup_anaconda_env.sh
RUN sudo -u jupyter /setup_anaconda_env.sh 2>&1| tee /home/jupyter/setup_anaconda_env.sh.log

COPY script/install_anaconda_modules.sh /install_anaconda_modules.sh
RUN chown jupyter.jupyter /install_anaconda_modules.sh
RUN chmod 777 /install_anaconda_modules.sh
RUN sudo -u jupyter /install_anaconda_modules.sh 2>&1| tee /home/jupyter/install_anaconda_modules.sh.log

EXPOSE 22
EXPOSE 8888

COPY script/start_jupyter_lab.sh /start_jupyter_lab.sh
RUN chmod 777 /start_jupyter_lab.sh

COPY script/startup.sh /startup.sh
RUN chmod 744 /startup.sh
CMD ["/startup.sh"]
