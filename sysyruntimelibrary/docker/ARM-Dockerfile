FROM ubuntu:18.04
RUN echo deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main multiverse restricted universe > /etc/apt/sources.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main multiverse restricted universe >> /etc/apt/sources.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main multiverse restricted universe >> /etc/apt/sources.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main multiverse restricted universe >> /etc/apt/sources.list && \
	echo deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main multiverse restricted universe >> /etc/apt/sources.list && \
	echo deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main multiverse restricted universe >> /etc/apt/sources.list && \
	echo deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main multiverse restricted universe >> /etc/apt/sources.list && \
	echo deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main multiverse restricted universe >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y build-essential

# Start from a Bash prompt
CMD [ "/bin/bash" ]
