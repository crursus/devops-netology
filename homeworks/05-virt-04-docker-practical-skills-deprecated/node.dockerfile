FROM node:latest
RUN apt update
RUN git clone https://github.com/simplicitesoftware/nodejs-demo.git
WORKDIR /nodejs-demo/
RUN npm install
EXPOSE 3000
CMD ["npm", "start", "0.0.0.0"]

