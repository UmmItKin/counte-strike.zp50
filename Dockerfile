FROM docker.io/steamcmd/steamcmd:latest

RUN apt-get update && apt-get install -y \
    unzip git build-essential clang python3 gcc-multilib g++-multilib meson ninja-build wget \
    libcurl4 lib32gcc-s1 lib32stdc++6 libc6-i386 \
    && apt-get clean

WORKDIR /root/.local/share/Steam/steamapps/common/Half-Life
RUN steamcmd +login anonymous +app_update 90 validate +quit

# Copy local extracted files instead of downloading
#COPY addons/ ./addons/
#RUN mkdir -p cstrike/addons && \
#    cp -r addons/* cstrike/addons/

# Configure Metamod
#RUN echo "gamedll_linux \"addons/metamod/dlls/metamod.so\"" > cstrike/liblist.gam && \
#    mkdir -p cstrike/addons/metamod && \
#    echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" > cstrike/addons/metamod/plugins.ini

# Install YaPB
#RUN git clone --recursive https://github.com/yapb/yapb && \
#    cd yapb && \
#    meson setup build && \
#    meson compile -C build && \
    #   mkdir -p ../cstrike/addons/yapb/bin && \
#    mkdir -p ../cstrike/addons/yapb/data && \
#    mkdir -p ../cstrike/addons/yapb/data/graph && \
#    cp -v build/yapb.so ../cstrike/addons/yapb/bin/ && \
#    echo "linux addons/yapb/bin/yapb.so" >> ../cstrike/addons/metamod/plugins.ini && \
#    echo "yapb_quota 8" > ../cstrike/addons/yapb/data/yapb.cfg && \
#    echo "yapb_difficulty 3" >> ../cstrike/addons/yapb/data/yapb.cfg

# Expose CS 1.6 port
EXPOSE 27015/udp 27015/tcp

CMD ["./hlds_run", "-game", "cstrike", "+map", "de_dust2", "-port", "27015", "+maxplayers", "16", "-insecure"]