docker build -t rpuscasu/multi-client:latest -t rpuscasu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rpuscasu/multi-server:latest -t rpuscasu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rpuscasu/multi-worker:latest -t rpuscasu/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rpuscasu/multi-client:latest
docker push rpuscasu/multi-server:latest
docker push rpuscasu/multi-worker:latest

docker push rpuscasu/multi-client:$SHA
docker push rpuscasu/multi-server:$SHA
docker push rpuscasu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rpuscasu/multi-server:$SHA
kubectl set image deployments/client-deployment client=rpuscasu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rpuscasu/multi-worker:$SHA