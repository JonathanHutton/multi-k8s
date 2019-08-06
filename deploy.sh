docker build -t jonathanhutton/multi-client:latest -t jonathanhutton/mulit-client:$SHA -f ./client/Dockerfile ./client
docker build -t jonathanhutton/multi-server:latest -t jonathanhutton/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jonathanhutton/worker:latest -t jonathanhutton/worker:$SHA -f ./worker/Dockerfile ./worker

docker push jonathanhutton/multi-client:latest
docker push jonathanhutton/multi-client:$SHA
docker push jonathanhutton/multi-server:latest
docker push jonathanhutton/multi-server:$SHA
docker push jonathanhutton/worker:latest
docker push jonathanhutton/worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jonathanhutton/multi-server:$SHA
kubectl set image deployments/client-deployment client=jonathanhutton/multi-client:$SHA
kubectl set image deployments/worker worker=jonathanhutton/worker:$SHA