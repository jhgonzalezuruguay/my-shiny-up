FROM rocker/shiny:latest

# Copia todo el contenido del repo al contenedor
COPY . /srv/shiny-server/

# Copia la configuración personalizada
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]