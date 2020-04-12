FROM mono:latest

RUN apt-get update
RUN apt-get install -y wget unzip xvfb x11vnc xterm i3

# Install Game
RUN mkdir -p /data/Stardew && \
    mkdir -p /data/nexus && \
    wget https://eris.cc/Stardew_latest_1.4.tar.gz -qO /data/latest.tar.gz && \
    tar xf /data/latest.tar.gz -C /data/Stardew && \
    rm /data/latest.tar.gz

# Install Mod Loader
RUN wget https://github.com/Pathoschild/SMAPI/releases/download/3.4.1/SMAPI-3.4.1-installer.zip  -qO /data/nexus.zip && \
    unzip /data/nexus.zip -d /data/nexus/ && \
    rm -f /data/nexus.zip && \
    /bin/bash -c "echo -e \"2\n/data/Stardew/Stardew\ Valley\n1\n\" | /usr/bin/mono /data/nexus/SMAPI\ 3.4.1\ installer/internal/unix-install.exe" 

RUN apt-get update
RUN apt-get install -y procps xdotool

# Add i3 window manager config
COPY configs/i3 /root/.config/i3/config

# Add Mods & Scripts
COPY ["mods/", "/data/Stardew/Stardew Valley/Mods/"]
COPY scripts/ /opt/
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /data/Stardew/Stardew\ Valley/StardewValley \
        /docker-entrypoint.sh \
        /opt/*.sh

ENTRYPOINT ["/docker-entrypoint.sh"]