# ---------------------------
# 1. Build Stage (Vite)
# ---------------------------
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# ---------------------------
# 2. Production Stage (Nginx)
# ---------------------------
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

