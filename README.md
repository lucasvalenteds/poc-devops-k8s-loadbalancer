# POC: Kubernetes Load Balancer

It demonstrates how to use [Kubernetes](https://kubernetes.io) to route requests to multiple [Node.js](https://nodejs.org) servers running on [Docker](https://github.com/docker) containers.

We want Kubernetes load balancer to redirect HTTP requests to a single URL to any running pod.

## How to run

| Description | Command |
| :--- | :--- |
| Build Docker image | `make build` |
| Provision | `make up` |
| Destroy | `make down` |
| Show logs | `make logs` |
| Run tests | `make test` |

> Running `SCALE=N make scale` will run N pods (e.g.: `SCALE=10 make scale` will run 10 pods)

## Preview

```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
server   LoadBalancer   10.108.38.99   <pending>     80:31647/TCP   5m51s

NAME                     READY   STATUS    RESTARTS   AGE
server-8dd75c554-2nd8r   1/1     Running   0          5m46s
server-8dd75c554-98sfk   1/1     Running   0          5m46s
server-8dd75c554-btrts   1/1     Running   0          5m46s
server-8dd75c554-dwvls   1/1     Running   0          5m46s
server-8dd75c554-ffpp9   1/1     Running   0          5m46s
server-8dd75c554-hgs7x   1/1     Running   0          5m46s
server-8dd75c554-jp59g   1/1     Running   0          5m51s
server-8dd75c554-m7zt8   1/1     Running   0          5m46s
server-8dd75c554-mmd2k   1/1     Running   0          5m46s
server-8dd75c554-rjl7g   1/1     Running   0          5m46s
```

```
audited 2 packages in 1.072s
found 0 vulnerabilities

Sending build context to Docker daemon   12.8kB
Step 1/6 : FROM node:alpine
 ---> 72eea7c426fc
Step 2/6 : WORKDIR /application
 ---> Using cache
 ---> 8bc1f9d591c4
Step 3/6 : ENV PORT 3000
 ---> Using cache
 ---> e40f1734735a
Step 4/6 : COPY dist/index.js .
 ---> 5053285ae5c3
Step 5/6 : EXPOSE 3000
 ---> Running in 3c2d922ade58
Removing intermediate container 3c2d922ade58
 ---> ae3510e62cda
Step 6/6 : CMD [ "node", "index.js" ]
 ---> Running in 450a71057364
Removing intermediate container 450a71057364
 ---> acbc6b659581
Successfully built acbc6b659581
Successfully tagged server:latest
```

## Tests

```
processor      Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz
memory         16GiB System memory
```

### 2 pods

```
Running 30s test @ http://172.17.0.3:30202
30 connections

┌─────────┬──────┬──────┬───────┬──────┬─────────┬─────────┬──────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%  │ Avg     │ Stdev   │ Max      │
├─────────┼──────┼──────┼───────┼──────┼─────────┼─────────┼──────────┤
│ Latency │ 0 ms │ 1 ms │ 2 ms  │ 2 ms │ 0.64 ms │ 0.76 ms │ 47.07 ms │
└─────────┴──────┴──────┴───────┴──────┴─────────┴─────────┴──────────┘
┌───────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┐
│ Stat      │ 1%      │ 2.5%    │ 50%     │ 97.5%   │ Avg     │ Stdev   │ Min     │
├───────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┤
│ Req/Sec   │ 10207   │ 10207   │ 27423   │ 28783   │ 26764.4 │ 3270.97 │ 10200   │
├───────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┤
│ Bytes/Sec │ 1.47 MB │ 1.47 MB │ 3.95 MB │ 4.15 MB │ 3.85 MB │ 471 kB  │ 1.47 MB │
└───────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┘

Req/Bytes counts sampled once per second.

803k requests in 30.06s, 116 MB read
```

### 5 pods

```
Running 30s test @ http://172.17.0.3:31845
30 connections

┌─────────┬──────┬──────┬───────┬──────┬─────────┬───────┬───────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%  │ Avg     │ Stdev │ Max       │
├─────────┼──────┼──────┼───────┼──────┼─────────┼───────┼───────────┤
│ Latency │ 0 ms │ 1 ms │ 2 ms  │ 4 ms │ 1.17 ms │ 2 ms  │ 178.67 ms │
└─────────┴──────┴──────┴───────┴──────┴─────────┴───────┴───────────┘
┌───────────┬────────┬────────┬─────────┬─────────┬──────────┬─────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%     │ 97.5%   │ Avg      │ Stdev   │ Min    │
├───────────┼────────┼────────┼─────────┼─────────┼──────────┼─────────┼────────┤
│ Req/Sec   │ 4187   │ 4187   │ 23007   │ 23903   │ 20840.74 │ 5676.57 │ 4185   │
├───────────┼────────┼────────┼─────────┼─────────┼──────────┼─────────┼────────┤
│ Bytes/Sec │ 603 kB │ 603 kB │ 3.31 MB │ 3.44 MB │ 3 MB     │ 817 kB  │ 603 kB │
└───────────┴────────┴────────┴─────────┴─────────┴──────────┴─────────┴────────┘

Req/Bytes counts sampled once per second.

625k requests in 30.07s, 90 MB read
```

### 10 pods

```
Running 30s test @ http://172.17.0.3:31647
30 connections

┌─────────┬──────┬──────┬───────┬───────┬─────────┬────────┬───────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%   │ Avg     │ Stdev  │ Max       │
├─────────┼──────┼──────┼───────┼───────┼─────────┼────────┼───────────┤
│ Latency │ 0 ms │ 1 ms │ 7 ms  │ 19 ms │ 1.69 ms │ 4.8 ms │ 318.11 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴────────┴───────────┘
┌───────────┬────────┬────────┬─────────┬─────────┬──────────┬─────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%     │ 97.5%   │ Avg      │ Stdev   │ Min    │
├───────────┼────────┼────────┼─────────┼─────────┼──────────┼─────────┼────────┤
│ Req/Sec   │ 2591   │ 2591   │ 19647   │ 21007   │ 14434.94 │ 7549.3  │ 2591   │
├───────────┼────────┼────────┼─────────┼─────────┼──────────┼─────────┼────────┤
│ Bytes/Sec │ 373 kB │ 373 kB │ 2.83 MB │ 3.02 MB │ 2.08 MB  │ 1.09 MB │ 373 kB │
└───────────┴────────┴────────┴─────────┴─────────┴──────────┴─────────┴────────┘

Req/Bytes counts sampled once per second.

433k requests in 30.06s, 62.4 MB read
```
