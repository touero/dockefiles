FROM ubuntu:22.04

ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's#http://.*ubuntu.com#http://mirrors.aliyun.com#g' /etc/apt/sources.list && apt update

RUN apt-get install -y \
        xvfb \
        wget \
        x11vnc \
        psmisc \
        libglib2.0-0 \
        libatomic1 \
        libxrandr2 \
        libxkbcommon0 \
        libxkbcommon-dev \
        libxkbcommon-x11-0 \
        libxcb-glx0 \
        libxcb-xkb1 \
        libxcb-randr0 \
        libxcb-icccm4 \
        libxcb-shm0 \
        libxcb-render0 \
        libxcb-image0 \
        libxcb-xfixes0 \
        libxcb-shape0 \
        libxcb-sync1 \
        libxcb-render-util0 \
        libxcb-keysyms1 \
        libfontconfig1 \
        libfreetype6 \
        libdbus-1-3 \
        libnss3 \
        libnspr4 \
        libx11-xcb1 \
        libgbm1 \
        libpango-1.0-0 \
        libcairo2 \
        libatk1.0-0 \
        libasound2 \
        libatk-bridge2.0-0 \
        locales \
        xfce4 \
        fcitx5 \
        fcitx5-chinese-addons \
        dbus-x11 \
        ttf-wqy-zenhei \
        ttf-wqy-microhei \
        xfonts-wqy \
        fonts-noto-cjk \
        git \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir websockify

RUN git clone https://github.com/novnc/noVNC.git /noVNC && \
    git clone https://github.com/novnc/websockify.git /noVNC/utils/websockify

RUN ln -s /noVNC/vnc.html /noVNC/index.html

RUN locale-gen zh_CN.UTF-8 && \
    update-locale LANG=zh_CN.UTF-8

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:en_US:en \
    LC_ALL=zh_CN.UTF-8 \
    XMODIFIERS=@im=fcitx \
    GTK_IM_MODULE=fcitx \
    QT_IM_MODULE=fcitx

RUN mkdir /root/wxbot
WORKDIR /root/wxbot/

RUN wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -O /tmp/wechat.deb
RUN dpkg -i /tmp/wechat.deb || apt-get install -f -y

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 6080

ENTRYPOINT ["/entrypoint.sh"]

