docker build -t astianseb/multi-client:latest -t astianseb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t astianseb/multi-server:latest -t astianseb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t astianseb/multi-worker:latest -t astianseb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push astianseb/multi-client:latest
docker push astianseb/multi-server:latest
docker push astianseb/multi-worker:latest

docker push astianseb/multi-client:$SHA
docker push astianseb/multi-server:$SHA
docker push astianseb/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=astianseb/multi-client:$SHA
kubectl set image deployments/server-deployment server=astianseb/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=astianseb/multi-worker:$SHA

