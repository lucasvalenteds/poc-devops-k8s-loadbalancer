SERVICE = server
SCALE ?= 5

build:
	@npm --prefix ./server install
	@npm --prefix ./server run build
	@docker-compose build

up:
	@kubectl apply --filename=kubernetes.yml

down:
	@kubectl delete --filename=kubernetes.yml

logs:
	@kubectl logs --selector app=$(SERVICE) --follow

info:
	@kubectl get service $(SERVICE)
	@kubectl get pods --selector app=$(SERVICE)

scale:
	@kubectl scale --replicas=$(SCALE) deployment/$(SERVICE)
