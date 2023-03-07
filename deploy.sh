docker build -t horger89/multi-client:latest -t horger89/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t horger89/multi-server:latest -t horger89/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t horger89/multi-worker:latest -t horger89/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push horger89/multi-client:latest
docker push horger89/multi-server:latest
docker push horger89/multi-worker:latest
docker push horger89/multi-client:$SHA
docker push horger89/multi-server:$SHA
docker push horger89/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=horger89/multi-server:$SHA
kubectl set image deployments/client-deployment client=horger89/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=horger89/multi-worker:$SHA