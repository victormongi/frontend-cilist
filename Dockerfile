FROM node:lts-gallium
WORKDIR /apps
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start" ]