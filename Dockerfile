# checkm
# VERSION       1.1.18
# docker build -t c00cjz00/checkm:v1.1.18 .

## 安裝來源
FROM ubuntu:20.04

## 維護人員
MAINTAINER Allen Chaung summerhill001@gmail.com


## 工作目錄
WORKDIR /workspace

## 更新系統
RUN apt-get update && apt-get -y update
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y build-essential python3 python3-pip python3-dev wget curl unzip
RUN pip3 -q install pip --upgrade
RUN pip3 install --upgrade pip
RUN pip3 install pooch

# conda
ENV PATH="/opt/miniconda3/bin:${PATH}"
ARG PATH="/opt/miniconda3/bin:${PATH}"
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version
RUN conda update -n base -c defaults conda -y

## CheckM 安裝來源
RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda install numpy matplotlib -y
RUN conda install hmmer prodigal pplacer -y
RUN pip3 install pysam
RUN pip3 install checkm-genome
