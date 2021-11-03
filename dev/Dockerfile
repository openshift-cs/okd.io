FROM squidfunk/mkdocs-material:7.2.6

RUN apk add --no-cache --update nodejs npm

WORKDIR /site
COPY ./package*.json /site/
COPY ./requirements.txt /site/

# Dependencies
RUN npm ci && pip install -r requirements.txt
ENTRYPOINT /usr/local/bin/mkdocs serve --dirtyreload -a 0.0.0.0:8000

