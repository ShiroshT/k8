docker build -t shiroshana/multi-client:latest -t shiroshana/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shiroshana/multi-server:latest -t shiroshana/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shiroshana/multi-worker:latest -t shiroshana/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shiroshana/multi-client:latest
docker push shiroshana/multi-server:latest
docker push shiroshana/multi-worker:latest

docker push shiroshana/multi-client:$SHA
docker push shiroshana/multi-server:$SHA
docker push shiroshana/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shiroshana/multi-server:$SHA
kubectl set image deployments/client-deployment client=shiroshana/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shiroshana/multi-worker:$SHA