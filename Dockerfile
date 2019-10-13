#docker build -t html_playground .
#docker run -d -p 8082:8082 html_playground

FROM alpine:3.10

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

# RUN pip3 install http

# Bundle app source
COPY . /src/app
WORKDIR "/src/app"
EXPOSE  8082
CMD ["python", "-m", "http.server", "8082"]