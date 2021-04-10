# Sobre el repo
Actividad de Taller de Nuevas Tecnologías de la UNTDF.

# Practicando Docker

## Construyendo entorno de desarrollo modularmente (sin docker-compose)
A fines demostrativos, correremos 3 containers:
    - Un servidor MongoDB
    - La app de mongo-express
    - Una app simple en express que se conecta con el servidor de mongo

1. Creamos la red que usaremos para los contenedores
    ```bash
    docker network create mongonet
    ```
2. Creamos el contenedor con el servidor de MongoDB
    ```bash
    docker run --rm -d --network mongonet -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret --name mongodb_server mongo:4.4.5-bionic
    # o
    docker run \
        --rm \ 
        -d \
        --network mongonet \
        -p 27017:27017 \
        -e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
        -e MONGO_INITDB_ROOT_PASSWORD=secret \
        --name mongodb_server \
        mongo:4.4.5-bionic
    ```
3. Creamos un contenedor con mongo-express
    ```bash
    docker run --rm -d --network mongonet -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=mongoadmin -e ME_CONFIG_MONGODB_ADMINPASSWORD=secret -e ME_CONFIG_MONGODB_SERVER=mongodb_server --name mongo_express mongo-express:0.54.0
    # o
    docker run \
        --rm \
        -d \
        --network mongonet \
        -p 8081:8081 \
        -e ME_CONFIG_MONGODB_ADMINUSERNAME=mongoadmin \
        -e ME_CONFIG_MONGODB_ADMINPASSWORD=secret \
        -e ME_CONFIG_MONGODB_SERVER=mongodb_server \
        --name mongo_express \
        mongo-express:0.54.0
    ```
4. Construimos la imagen para nuestra app basados en el `Dockerfile`
    ```bash
    docker build -t express_user .
    ```
5. Creamos un contenedor con la imagen recién construida
    ```bash
    docker run --rm -d --network mongonet -p 3000:3000 express_user
    ```
6. Nos conectamos a `http://localhost:3000` y deberíamos ver la app de edición de usuario.

## Construyendo con docker-compose
Simplente corremos `docker-compose up` o `docker-compose up -d`
### Otros comandos de `docker-compose`
```bash
# build    Reconstruir servicios (cuando modificamos el .yaml)
# down     Deterner servicios o recursos
# images   Listar imágenes
# kill     Matar contenedores
# logs     Ver logs de los contenedores
# ps       Listar contenedores
# restart  Reiniciar contenedores
# rm       Eliminar contenedores
# start    Iniciar contenedores
# stop     Detener contenedores
# top      Mostrar los procesos corriendo
# up       Crear e iniciar los servicos
```

# Conceptos + Comandos útiles

## Images
```bash
# Descargo una imagen
docker pull mongo:4.4.5-bionic

# Listo las imágenes descargadas
docker images
# o su equivalente
docker image ls

# más comandos de "docker image"
# build       Contruir una imagen desde un Dockerfile
# inspect     Mostrar info detallada de una imagen
# prune       Eliminar imágenes sin uno
# pull        Descargar
# push        Enviar una imagen a un repo
# rm          Eliminar una imagen
# tag         Etiquetar una imagen
```

## Containers
```bash
# Listo los contenedores en ejecución
docker ps

# Listo todos los contenedores
docker ps -a

# Creo un contenedor a partir de una imagen
docker run --rm -d --network mongonet -p 27017:27017 --name mongodb_server mongo:4.4.5-bionic
# --rm borra el container luego de pararlo
# -d   corre el container en segundo plano

# Accedo a la "terminal" del contenedor
docker exec -it [CONTAINER_ID|CONTAINER_NAME] [/bin/bash | /bin/sh]

# Accedo a los logs de un contenedor
docker logs [CONTAINER_ID|CONTAINER_NAME]

# Inicio un contenedor parado
docker start [CONTAINER_ID|CONTAINER_NAME]

# Detengo un contenedor en ejecución
docker stop [CONTAINER_ID|CONTAINER_NAME]

# Eliminar uno o más contenedores
docker stop [CONTAINER_ID|CONTAINER_NAME]
```

## Networks
```bash
# Creo una red
docker network create [NETWORK_NAME]

# Otros comandos
# connect     Conectar un contenedor a una red
# disconnect  Desconectar un contenedor a una red
# inspect     Mostrar info de una red
# ls          Listar las redes
# prune       Eliminar todas las redes sin uso
# rm          Eliminar una o muchas redes
```

## Volumes
```bash
# Creo un volumen
create      Create a volume

# Otros comandos
# inspect     Mostrar info de un volumen
# ls          Lista de volúmenes
# prune       Eliminar todos los volúmenes sin uso
# rm          Eliminar uno o más volúmeness
```
