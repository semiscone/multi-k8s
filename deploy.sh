docker build -t semiscone/multi-client:latest -t semiscone/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t semiscone/multi-server:latest -t semiscone/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t semiscone/multi-worker:latest -t semiscone/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push semiscone/multi-client:latest
docker push semiscone/multi-server:latest
docker push semiscone/multi-worker:latest

docker push semiscone/multi-client:$SHA
docker push semiscone/multi-server:$SHA
docker push semiscone/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=semiscone/multi-server:$SHA
kubectl set image deployments/client-deployment client=semiscone/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=semiscone/multi-worker:$SHA