#
# For pyCharm and GUI (X11), run the image with:
# $ XSOCK=/tmp/.X11-unix && sudo docker run -i -v $XSOCK:$XSOCK --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -e DISPLAY -t [image-name]
#
# Then run pyCharm with:
#


FROM centos:7

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=144 \
    JAVA_VERSION_BUILD=01 \
    JAVA_URL_HASH=090f390dda5b47b9b721c7dfaa008135


ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g ${GROUP_ID} pycharm &&\
		useradd -l -u ${USER_ID} -g pycharm pycharm  

RUN yum update -y && \
    yum install -y wget && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git && \
    yum install -y xeyes && \
    yum clean all

# Set environment variables.
ENV HOME /root
ENV JDK_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64
ENV JAVA_EXE /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/jre/bin/java
ENV JRE_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/jre
ENV LANG C.UTF-8

RUN set -ex && \
    wget https://download.jetbrains.com/python/pycharm-community-2019.2.3.tar.gz && \
    tar -xf pycharm-community-2019.2.3.tar.gz && \
    rm pycharm-community-2019.2.3.tar.gz

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
