FROM keymetrics/pm2:latest-alpine

# Bundle APP files
COPY src src/
COPY package.json .
COPY ecosystem.config.js .

ENV STEEMCONNECT_CLIENT_ID=casteem
ENV STEEMCONNECT_REDIRECT_URL=https://app.steem.racing/callback
ENV STEEMJS_URL=https://api.steemit.com
ENV SIGNUP_URL=https://signup.steemit.com/?ref=casteem

# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install --production

# Expose the listening port of your app
EXPOSE 3000

# Show current folder structure in logs
RUN ls -al -R

CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]
