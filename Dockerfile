FROM pipill/armhf-node:8

COPY ./discord-xa /home/discord-xa
COPY ./settings.json /home/discord-xa/settings.json

RUN apt-get update -y && \
    apt-get install autoconf -y && \
    apt-get install libtool -y && \
    apt-get install python -y

RUN apt-get install yasm nasm \
                build-essential automake autoconf \
                libtool pkg-config libcurl4-openssl-dev \
                intltool libxml2-dev libgtk2.0-dev \
                libnotify-dev libglib2.0-dev libevent-dev \
                checkinstall -y

RUN cd /tmp && \
    git clone git://git.videolan.org/ffmpeg.git && \
    cd ffmpeg && \
    ./configure --prefix=/usr && \
    make -j 8 && \
    cat RELEASE && \
    checkinstall &&\
    dpkg --install ffmpeg_*.deb

RUN cd /home/discord-xa && \
    npm i

WORKDIR /home/discord-xa/src

CMD ["node","index.js"]
