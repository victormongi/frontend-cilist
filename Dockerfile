FROM node:16-bullseye
WORKDIR /apps
COPY . .
RUN npm install
RUN npm run build
EXPOSE 3000
CMD ["npm", "run", "start"]