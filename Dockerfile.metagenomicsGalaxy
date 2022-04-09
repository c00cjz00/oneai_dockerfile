# Galaxy - deepTools
#
# VERSION       0.2

FROM quay.io/galaxy/metagenomics-training

MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com

#RUN export DEBIAN_FRONTEND=noninteractive && 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN apt-get update -y 
RUN apt-get install --assume-yes apt-utils
RUN apt-get install libreadline6-dev multiarch-support  wget libtinfo-dev -y


#RUN curl http://cz.archive.ubuntu.com/ubuntu/pool/main/r/readline/libreadline-dev_7.0-3_amd64.deb -o libreadline-dev_7.0-3_amd64.deb
#RUN dpkg -i libreadline-dev_7.0-3_amd64.deb 
RUN curl http://ftp.debian.org/debian/pool/main/r/readline6/libreadline6_6.3-8+b3_amd64.deb -o libreadline6_6.3-8+b3_amd64.deb
RUN apt install ./libreadline6_6.3-8+b3_amd64.deb -y

#RUN curl http://ftp.debian.org/debian/pool/main/g/glibc/multiarch-support_2.19-18+deb8u10_amd64.deb -o multiarch-support_2.19-18+deb8u10_amd64.deb
#RUN curl http://ftp.debian.org/debian/pool/main/g/glibc/multiarch-support_2.24-11+deb9u4_amd64.deb -o multiarch-support_2.24-11+deb9u4_amd64.deb
#RUN apt install ./libreadline6_6.3-8+b3_amd64.deb  
#RUN apt install ./multiarch-support_2.24-11+deb9u4_amd64.deb -y
#./multiarch-support_2.19-18+deb8u10_amd64.deb -y

ENV GALAXY_CONFIG_BRAND Metagenomic-training
# The following two lines are optional and can be given during runtime
# with the -e http_proxy='http://yourproxyIP:8080' parameter
#ENV http_proxy 'http://yourproxyIP:8080'
#ENV https_proxy 'http://yourproxyIP:8080'

WORKDIR /galaxy-central

#RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'

# Install Visualisation
#RUN install-biojs msa

# Adding the tool definitions to the container
#ADD my_tool_list.yml $GALAXY_ROOT/my_tool_list.yml

# Install deepTools
#RUN install-tools $GALAXY_ROOT/my_tool_list.yml

# Mark folders as imported from the host.
#VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
