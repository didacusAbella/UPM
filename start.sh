#!/bin/bash

systemctl start docker
docker run -it -p 1999:1999 chaincore/developer
echo "Database Start"

case "$1" in
("d") rerun -- rackup -E development -p 3000 config.ru ;;
("p") rackup -E production -p 3000 config.ru ;;
(*) echo "Opzione non valida" ;;
esac