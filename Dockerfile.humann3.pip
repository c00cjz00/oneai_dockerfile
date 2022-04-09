# HumanN
# VERSION       3.01

FROM biobakery/humann:latest
MAINTAINER Allen Chaung summerhill001@gmail.com

RUN apt-get update && apt-get -y update
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y build-essential
#RUN apt-get install -y build-essential python3.7 python3-pip python3-dev openslide-tools
RUN pip3 -q install pip --upgrade

WORKDIR /workspace

RUN pip3 install --upgrade pip
RUN pip install pooch
RUN pip3 install jupyterlab
RUN jupyter notebook --generate-config
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir=/workspace"]
