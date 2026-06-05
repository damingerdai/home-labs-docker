FROM gitea/act_runner:0.2.11

RUN apk add --no-cache nodejs


RUN node --version
