
#minimal base image (Debian based nginx)

#überprüfe bullsyse
FROM debian:bullseye

#install nginx
RUN apt update && apt install -y nginx openssl

#remove default nginx config
RUN rm -rf /etc/nginx/default.conf

# Create the SSL directory
RUN mkdir -p /etc/nginx/ssl/private

# COPY conf/openssl.cnf /tmp/openssl.cnf

# # Generate (self-signed) SSL certificate inside the container
# RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/nginx.key \
#     -out /etc/nginx/ssl/nginx.crt -days 365 -nodes -subj \
#     "/CN=localhost" 
    # -addext "subjectAltName=DNS:localhost,DNS:fmarggra.42.fr"

RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/private/nginx.key \
    -out /etc/nginx/ssl/private/nginx.crt -days 365 -nodes \
    -subj "/CN=fmarggra.42.fr" 
    # -addext "subjectAltName=DNS:localhost,DNS:fmarggra.42.fr"


#copy custom nginx config file (created separately) source -> destination inside docker container
COPY conf/default /etc/nginx/sites-available

#optional, but good because what if default file is corrupted
# Remove the default NGINX index file
RUN rm -f /var/www/html/index.nginx-debian.html

# Create website directory & add an index.html file
RUN mkdir -p /var/www/html && echo '<h1>Welcome to NGINX</h1>' > /var/www/html/index.html

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

#expose to port 443 (project requires TLS)
#443 --> default port for https (TSL/SSL encrypted traffic)
#different to non-encrypted: port 89
EXPOSE 443

#command to start nginx without "tail -f" hack)
CMD ["nginx", "-g", "daemon off;"]

#recreate image (done by docker compose)
#sudo docker build -t custom-nginx .
#check image exists
#sudo docker image ls
#run image
#sudo docker run -d --name nginx-container -p 443:443 nginx

#stop container
#sudo docker stop nginx-container

#remove container
#sudo docker rm nginx-container

#check for logs: sudo docker logs nginx-container

