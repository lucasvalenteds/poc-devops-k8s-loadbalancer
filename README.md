# POC: Kubernetes Load Balancer

It demonstrates how to use [Kubernetes](https://kubernetes.io) to route requests to multiple [Node.js](https://nodejs.org) servers running on [Docker](https://github.com/docker) containers.

We want Kubernetes load balancer to redirect HTTP requests to a single URL to any running pod.

## How to run

| Description | Command |
| :--- | :--- |
| Provision | `make up` |
| Destroy | `make down` |
| Show logs | `make logs` |
| Run tests | `./test.sh` |

> Running `SCALE=N make scale` will run N pods (e.g.: `SCALE=10 make scale` will run 10 pods)

## Preview

```
NAME                     READY   STATUS    RESTARTS   AGE
server-8dd75c554-2hpmz   1/1     Running   0          3h22m
server-8dd75c554-6xkvn   1/1     Running   0          6s
server-8dd75c554-9snw2   1/1     Running   0          6s
server-8dd75c554-lbbjg   1/1     Running   0          6s
server-8dd75c554-nrb4t   1/1     Running   0          5s
```

```
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
server   5/5     5            5           3h23m
```
