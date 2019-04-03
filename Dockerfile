FROM alpine:3.9

RUN echo "#aliyun" > /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.9/main/" >> /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.9/community/" >> /etc/apk/repositories
RUN apk update
RUN apk add bash vim git




#安装python3 和pip
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \    
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    pip3 install pipreqs && \
    rm -r /root/.cache
# RUN ls
#复制到工作目录
# ADD . /myapp

RUN git clone https://github.com/t-web/alpine_terry_python.git /myapp
WORKDIR /myapp
#安装依赖
RUN pip3 install -r requirements.txt

#RUN pip3 install .

#EXPOSE 8000
#CMD myapp --port 8000