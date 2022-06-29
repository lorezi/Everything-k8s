FROM node:14-alpine3.15
ADD ./app/app.js /app.js
# Exec form for command line execution
ENTRYPOINT ["node", "app.js"]