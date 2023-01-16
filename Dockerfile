# Dockerfile para versión de produccion
# Lo ejecutamos con el comando -> docker build .
# Y lo ponemos en marcha con un -> docker run -p puerto:puerto IdDocker
# Por ej.> docker run -p 8080:80 34klg1l4hh4
# Ojo, este ya no se actualiza

#Usamos Nginx, un load balancer que permite equilibrar la carga de trabajo en los servidores manteniendo la capacidad a un nv optimo

FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# Expose 80 sirve para que Elastic Beanstalk (AWS) mapee los puertos de la página