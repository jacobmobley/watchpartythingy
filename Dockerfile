# ────────────────────────────────────────────────────────────────
FROM debian:bullseye-slim
LABEL maintainer="you@example.com"

# Install desktop environment and browser
RUN apt-get update && apt-get install -y \
    # Desktop environment
    xfce4 \
    xfce4-terminal \
    # Browser
    chromium \
    # VNC and streaming
    xvfb \
    x11vnc \
    supervisor \
    ffmpeg \
    nginx \
    pulseaudio pulseaudio-utils \
    # noVNC and websockify
    novnc \
    websockify \
    # Additional dependencies
    dbus-x11 \
    pulseaudio \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Set VNC password
RUN mkdir -p /root/.vnc \
 && x11vnc -storepasswd "watchparty" /root/.vnc/passwd

# Copy configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf       /etc/nginx/nginx.conf
COPY hls-stream.sh    /usr/local/bin/hls-stream.sh
RUN chmod +x /usr/local/bin/hls-stream.sh
COPY index.html /usr/share/novnc/index.html
COPY wait-for-x.sh /usr/local/bin/wait-for-x.sh
RUN chmod +x /usr/local/bin/wait-for-x.sh
COPY extension       /opt/launcher/extension
COPY localindex.html      /opt/homescreen/index.html
COPY start-supervisor.sh  /usr/local/bin/start-supervisor.sh
RUN chmod +x /usr/local/bin/start-supervisor.sh

# Create a non-root user
RUN useradd -m -s /bin/bash watchparty \
    && echo "watchparty:watchparty" | chpasswd \
    && usermod -aG sudo watchparty \
    && usermod -aG pulse,pulse-access watchparty

# Expose ports:
#    5900 = raw VNC
#    6080 = noVNC (HTML5)
#    8080 = HLS web server
EXPOSE 5900 6080 8080

CMD ["/usr/local/bin/start-supervisor.sh"]
# ────────────────────────────────────────────────────────────────