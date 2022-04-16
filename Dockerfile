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
RUN apt-get install -y build-essential python3 python3-pip python3-dev wget curl unzip git
RUN pip3 -q install pip --upgrade
RUN pip3 install --upgrade pip
RUN pip3 install pooch
RUN pip3 install jupyterlab
RUN jupyter notebook --generate-config

## 複製 jupyter_notebook_config
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# 安裝 Miniconda
ENV PATH="/opt/miniconda3/bin:${PATH}"
ARG PATH="/opt/miniconda3/bin:${PATH}"
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version
RUN conda update -n base -c defaults conda -y

## 安裝 CheckM 
RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda config --add channels fastchan
RUN conda install fastai -y

## 安裝並啟動系統穩定性套件
## Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

## 啟動jupyter notebook
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir=/workspace"]

