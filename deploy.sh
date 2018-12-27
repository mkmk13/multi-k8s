docker build -t mk13/multi-client:latest -t mk13/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t mk13/multi-server:latest -t mk13/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t mk13/multi-worker:latest -t mk13/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push mk13/multi-client:latest
docker push mk13/multi-server:latest
docker push mk13/multi-worker:latest
docker push mk13/multi-client:$SHA
docker push mk13/multi-server:$SHA
docker push mk13/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mk13/multi-server:$SHA
kubectl set image deployments/client-deployment client=mk13/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mk13/multi-worker:$SHA