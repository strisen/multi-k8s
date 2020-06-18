docker build -t strisen/multi-client:latest -t strisen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t strisen/multi-worker:latest -t strisen/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t strisen/multi-server:latest -t strisen/multi-server:$SHA -f ./server/Dockerfile ./server

docker push strisen/multi-client:latest
docker push strisen/multi-client:$SHA

docker push strisen/multi-worker:latest
docker push strisen/multi-worker:$SHA

docker push strisen/multi-server:latest
docker push strisen/multi-server:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=strisen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=strisen/multi-worker:$SHA
kubectl set image deployments/server-deployment server=strisen/multi-server:$SHA
