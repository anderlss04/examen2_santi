@REM # !/bin/bash
@REM # Limpiar y eliminar contenedores previos
docker container prune -f

@REM # Contenedor en estado "Exited"
docker run  -d --name exited_container nginx sleep 30
docker stop exited_container

@REM # Contenedor en estado "Paused"
docker run  -d --name paused_container nginx sh -c "trap 'exit 0' INT TERM; while true; do echo 'Paused'; sleep 1; done"
docker pause paused_container

@REM # Contenedor en estado "Up" (corriendo)
docker run  -d --name running_container nginx sh -c "trap 'exit 0' INT TERM; while true; do echo 'Running'; sleep 1; done"

@REM # Contenedor en estado "Created"
docker create --name created_container nginx

@REM # Contenedor en estado "Restarting"
docker run -d --name restarting_container --restart always nginx 
docker kill restarting_container

@REM # Mostrar informe de los contenedores
echo "Informe de contenedores:"
docker ps -a

@REM # Eliminar todos los contenedores
docker rm -f $(docker ps -a -q)
