FROM monostream/nodejs-gulp-bower

ADD . /data/scheduler

WORKDIR /data/scheduler

RUN \
  rm -rf node_modules && \
  rm -rf bower_components && \
  npm cache clean && \
  bower --allow-root cache clean && \
  npm install && \
  rm -rf bower_components && \
  bower --allow-root cache clean

EXPOSE 9999

CMD ["node", "server.js"]
