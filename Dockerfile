FROM keymetrics/pm2:alpine

ENV NPM_CONFIG_LOGLEVEL warn
ENV STEEMCONNECT_CLIENT_ID=casteem
ENV STEEMCONNECT_REDIRECT_URL=https://app.steem.racing/callback
ENV STEEMJS_URL=https://api.steemit.com
ENV SIGNUP_URL=https://signup.steemit.com/?ref=casteem

RUN npm config set unsafe-perm true
RUN npm i npm@latest -g

WORKDIR /app

# Bundle APP files
COPY package.json /app/package.json

# Install app dependencies
RUN yarn --production

COPY . /app/

RUN yarn build

# Expose the listening port of your app
EXPOSE 3000

# Show current folder structure in logs
#CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]
CMD [ "yarn", "start"]
