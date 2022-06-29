FROM ubuntu:latest
RUN apt-get update ; apt-get -y install fortune
ADD fortuneloop.sh /bin/fortuneloop.sh
RUN chmod +x /bin/fortuneloop.sh
# shell form for command line execution
ENTRYPOINT /bin/fortuneloop.sh 