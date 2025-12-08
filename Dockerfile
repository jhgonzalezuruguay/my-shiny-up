FROM rocker/shiny:latest

# Copia todo el contenido del repo al contenedor
COPY . /srv/shiny-server/

# Expone el puerto 3838
EXPOSE 3838

# Comando de inicio
CMD ["/usr/bin/shiny-server"]