docker build -t jpbarbosa/multi-client:latest -t jpbarbosa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jpbarbosa/multi-server:latest -t jpbarbosa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jpbarbosa/multi-worker:latest -t jpbarbosa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jpbarbosa/multi-client:latest
docker push jpbarbosa/multi-server:latest
docker push jpbarbosa/multi-worker:latest

docker push jpbarbosa/multi-client:$SHA
docker push jpbarbosa/multi-server:$SHA
docker push jpbarbosa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jpbarbosa/multi-client:$SHA
kubectl set image deployments/server-deployment server=jpbarbosa/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jpbarbosa/multi-worker:$SHA
