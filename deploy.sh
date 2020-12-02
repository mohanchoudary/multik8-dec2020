docker build -t mohanchoudary/multi-client:latest -t mohanchoudary/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohanchoudary/multi-server:latest -t mohanchoudary/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohanchoudary/multi-worker:latest -t mohanchoudary/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mohanchoudary/multi-client:latest
docker push mohanchoudary/multi-server:latest
docker push mohanchoudary/multi-worker:latest

docker push mohanchoudary/multi-client:$SHA
docker push mohanchoudary/multi-server:$SHA
docker push mohanchoudary/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mohanchoudary/multi-server:$SHA
kubectl set image deployments/client-deployment client=mohanchoudary/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mohanchoudary/multi-worker:$SHA
