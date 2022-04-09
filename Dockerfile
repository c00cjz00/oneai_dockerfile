# HumanN
#
# VERSION       3.01
FROM biobakery/humann:latest
MAINTAINER Allen Chaung summerhill001@gmail.com

#ENV http_proxy 'http://yourproxyIP:8080'
#ENV https_proxy 'http://yourproxyIP:8080'

#RUN export DEBIAN_FRONTEND=noninteractive &&
#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN apt-get update -y
RUN apt-get install --assume-yes apt-utils -y
RUN apt-get install zlib1g -y




# Home
WORKDIR /workspace

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :8888

# conda
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version

#RUN bash
#RUN sleep 2
#RUN conda update -n base -c defaults conda
#RUN conda activate qiime2-2022.2
RUN conda install -y -c conda-forge jupyterlab jupyter-archive nodejs


#RUN jupyter serverextension enable --py qiime2 --sys-prefix
#COPY run.py .
#USER qiime2
#COPY bashrc /home/qiime2/.bashrc

#USER 1000:1000
# Autostart script that is invoked during container start
CMD ["jupyter","notebook","--NotebookApp.token=''","--NotebookApp.password=''","--ip=0.0.0.0","--allow-root","--port=8888","--no-browser"]


