# fastai
# VERSION       2.5.6
## 安裝來源
FROM fastai/fastai:latest

## 維護人員
MAINTAINER Allen Chaung summerhill001@gmail.com

## 工作目錄
WORKDIR /workspace

## 更新系統
RUN apt-get update && apt-get -y update
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y build-essential unzip
RUN jupyter notebook --generate-config

## 複製 jupyter_notebook_config
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

## 安裝並啟動系統穩定性套件
## Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

## 啟動jupyter notebook
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir=/workspace"]

