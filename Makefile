build:
	docker build -t empirechaotix/order-service:0.1.0 .
	docker push empirechaotix/order-service:0.1.0
build-two:
	docker build -t empirechaotix/order-service:0.2.0 .
	docker push empirechaotix/order-service:0.2.0
create:
	oc new-project order-service
delete:
	oc delete project order-service
deploy:
	oc project order-service
	istioctl kube-inject -f openshift/Deployment.yml > openshift/istio-deployment.yml
	sed $$'s/            - NET_ADMIN/            - NET_ADMIN\\\n          privileged: true/g' openshift/istio-deployment.yml > openshift/istio-deployment-final.yml
	oc apply -f openshift/istio-deployment-final.yml
	oc apply -f openshift/Route.yaml
	oc apply -f openshift/Gateway.yml
	oc apply -f openshift/Service.yml
deploy-v2:
	oc project order-service
	istioctl kube-inject -f openshift/Deployment-v2.yml > openshift/istio-deployment-v2.yml
	sed $$'s/            - NET_ADMIN/            - NET_ADMIN\\\n          privileged: true/g' openshift/istio-deployment-v2.yml > openshift/istio-deployment-v2-final.yml
	oc apply -f openshift/istio-deployment-v2-final.yml
# 	oc apply -f openshift/Route.yaml
# 	oc apply -f openshift/Gateway.yml
# 	oc apply -f openshift/Service.yml
deploy-v1-v2:
	oc project order-service
	oc apply -f openshift/DestinationRule-v1-v2.yml
	oc apply -f openshift/VirtualService-v1-50-v2-50.yaml
undeploy-v1-v2:
	oc project order-service
	oc delete -f openshift/DestinationRule-v1-v2.yml
	oc delete -f openshift/VirtualService-v1-50-v2-50.yaml
undeploy:
	oc project order-service
	oc delete -f openshift/Deployment.yml
	oc delete -f openshift/Route.yaml
	oc delete -f openshift/Gateway.yml
	oc delete -f openshift/Service.yml