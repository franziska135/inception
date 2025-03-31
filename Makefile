# NAME = inception


DATA_DIR:= /home/${USER}/data/mariadb /home/${USER}/data/wordpress

create_dir:
	@for dir in $(DATA_DIR); do \
		if [ ! -d $$dir ]; then \
			echo "Create volume directory $$dir"; \
			mkdir -p $$dir; \
		fi; \
	done

all: up

#startet container
up: create_dir
	docker-compose -f srcs/docker-compose.yml up --build -d


#stoppt container
#stopt alle laufenden container, entfernt nichts
#kann man dann später mit make up wieder starten
#löscht die container nicht!
stop:
	docker-compose -f srcs/docker-compose.yml stop

#löscht container
#löscht fast alles (laufende container, netzwerke, ungenutzte Volumes)
#löscht nicht: docker-images und volumes
down:
	docker-compose -f srcs/docker-compose.yml down -v

#sicherstellen, dass Anderungen übernommen werden
#no-cache baut docker images von grund auf neu, ohne zwischengespeicherte Layer zu verwenden
# up -d startet container im hintergrund
re:
	docker-compose -f srcs/docker-compose.yml build --no-chache
	docker-compose -f srcs/docker-compose.yml up -d

# docker-compose -f srcs/docker-compose.yml up -d

#löscht unbenötigte Docker-ressourcen
#löscht alel nicht verwendeten container, netzwerke und caches
#löscht NICHT: volumes oder genutzte container
prune:
	docker system prune

#löscht alles docker images und volumes
#radikales cleanup
clean:
	@imgs="$$(docker images -q)"; \
	if [ -n "$$imgs" ]; then \
	    docker rmi $$imgs; \
	else \
	    echo "No images left to remove."; \
	fi
	@docker volume prune -f
	@sudo rm -rf /home/${USER}/data || true

status:
	docker ps -a

logdelete:
	sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' wordpress)

