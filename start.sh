#!/bin/bash

case "$1" in
("d") rackup -E development -p 3000 config.ru ;;
("p") rackup -E production -p 3000 config.ru ;;
(*) echo "Opzione non valida" ;;
esac