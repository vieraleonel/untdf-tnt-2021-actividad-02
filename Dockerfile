FROM node:14.16.1-alpine3.13

RUN mkdir -p /home/app

COPY ./app /home/app

# set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

# will execute npm install in /home/app because of WORKDIR
RUN npm install

EXPOSE 3000

# no need for /home/app/server.js because of WORKDIR
CMD ["npm", "start"]

