docker build -t anastasiya108/multi-client:latest -t anastasiya108/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anastasiya108/multi-server:latest -t anastasiya108/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anastasiya108/multi-worker:latest -t anastasiya108/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anastasiya108/multi-client:latest
docker push anastasiya108/multi-server:latest
docker push anastasiya108/multi-worker:latest

docker push anastasiya108/multi-client:$SHA
docker push anastasiya108/multi-server:$SHA
docker push anastasiya108/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anastasiya108/multi-server:$SHA
kubectl set image deployments/client-deployment client=anastasiya108/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anastasiya108/multi-worker:$SHA

