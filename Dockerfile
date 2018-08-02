FROM node:9-alpine

ENV NPM_CONFIG_LOGLEVEL warn
ENV STEEMCONNECT_CLIENT_ID=casteem
ENV STEEMCONNECT_REDIRECT_URL=https://app.steem.racing/callback
ENV STEEMJS_URL=https://api.steemit.com
ENV SIGNUP_URL=https://signup.steemit.com/?ref=casteem

#RUN npm config set unsafe-perm true
RUN npm i npm@latest -g
# Install pm2
RUN npm install --global yarn
RUN npm install --global pm2

WORKDIR /app

# Bundle APP files
COPY package.json /app/package.json

# Install app dependencies
RUN yarn

COPY . /app/

RUN yarn build

# Expose the listening port of your app
EXPOSE 80 443 8082 3000 43554

# Show current folder structure in logs
CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]
#CMD [ "yarn", "start"]
#CMD ["pm2-runtime", "start", "pm2.json"]
