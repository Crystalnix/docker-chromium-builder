FROM ubuntu:14.04

# https://chromium.googlesource.com/chromium/src/+/master/docs/linux_suid_sandbox_development.md

ENV SRC="/src" LC_CTYPE="en_US.UTF-8" CHROME_DEVEL_SANDBOX="1"

RUN useradd -m chromium \
    && mkdir $SRC \
    && chown -R chromium:chromium $SRC \
    && echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse"              >> /etc/apt/sources.list \
    && echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse"          >> /etc/apt/sources.list \
    && echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"      >> /etc/apt/sources.list \
    && echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"  >> /etc/apt/sources.list

RUN locale-gen "en_US.UTF-8" \
    && dpkg-reconfigure locales

RUN apt-get update \
    && apt-get -yq install software-properties-common python-software-properties bzip2 unzip git build-essential pkg-config aptitude dpkg \
    && apt-get install -yq libasound2 libcap2 libelf-dev libexif12 libfontconfig1 libgconf-2-4 libgl1-mesa-glx libglib2.0-0 libgpm2 libgtk2.0-0 libncurses5 libnss3 libpango1.0-0 libssl1.0.0 libtinfo-dev libudev1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxrandr2 libxss1 libxtst6 ant apache2.2-bin autoconf bison cdbs cmake curl devscripts dpkg-dev elfutils fakeroot flex fonts-thai-tlwg g++ g++-mingw-w64-i686 gawk git-core git-svn gperf intltool language-pack-da language-pack-fr language-pack-he language-pack-zh-hant lib32gcc1 lib32ncurses5-dev lib32stdc++6 lib32z1-dev libapache2-mod-php5 libasound2 libasound2-dev libatk1.0-0 libav-tools libbluetooth-dev libbrlapi-dev libbrlapi0.6 libbz2-1.0 libbz2-dev libc6 libc6-i386 libcairo2 libcairo2-dev libcap-dev libcap2 libcups2 libcups2-dev libcurl4-gnutls-dev libdrm-dev libelf-dev libexif-dev libexif12 libexpat1 libffi-dev libffi6 libfontconfig1 libfreetype6 libgbm-dev libgconf2-dev libgl1-mesa-dev libgles2-mesa-dev libglib2.0-0 libglib2.0-dev libglu1-mesa-dev libgnome-keyring-dev libgnome-keyring0 libgtk2.0-0 libgtk2.0-dev libjpeg-dev libkrb5-dev libnspr4 libnspr4-dev libnss3 libnss3-dev libpam0g libpam0g-dev libpango1.0-0 libpci-dev libpci3 libpcre3 libpixman-1-0 libpng12-0 libpulse-dev libpulse0 libsctp-dev libspeechd-dev libspeechd2 libsqlite3-0 libsqlite3-dev libssl-dev libstdc++6 libtinfo-dev libtool libudev-dev libudev1 libwww-perl libx11-6 libxau6 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxi6 libxinerama1 libxkbcommon-dev libxrandr2 libxrender1 libxslt1-dev libxss-dev libxt-dev libxtst-dev libxtst6 mesa-common-dev openbox patch perl php5-cgi pkg-config python python-cherrypy3 python-crypto python-dev python-numpy python-opencv python-openssl python-psutil python-yaml realpath rpm ruby subversion texinfo ttf-dejavu-core ttf-indic-fonts ttf-kochi-gothic ttf-kochi-mincho ttf-mscorefonts-installer wdiff xfonts-mathml xsltproc xutils-dev xvfb zip zlib1g \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/sbin

WORKDIR ${SRC}
VOLUME ${SRC}
USER chromium

CMD ["/bin/bash"]
