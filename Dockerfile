FROM node:14-alpine3.15
ADD ./app/app.js /app.js
ENTRYPOINT ["node", "app.js"]