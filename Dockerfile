FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk

WORKDIR /app

RUN apt update && apt install -y clang-16
RUN ln -sf /usr/bin/clang-16 /usr/bin/clang && ln -sf /usr/bin/clang++-16 /usr/bin/clang++
RUN git clone https://github.com/alliedmodders/ambuild
RUN cd ambuild && python setup.py install && cd ..
RUN git config --global --add safe.directory /app

COPY ./docker-entrypoint.sh ./
ENV HL2SDKCS2=/app/source/vendor/hl2sdk-cs2
ENV MMSOURCE112=/app/source/vendor/metamod-source
WORKDIR /app/source
CMD [ "/bin/bash", "./docker-entrypoint.sh" ]