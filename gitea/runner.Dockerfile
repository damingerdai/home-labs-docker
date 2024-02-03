FROM gitea/act_runner:0.2.6

RUN apk add --no-cache nodejs


RUN node --version
