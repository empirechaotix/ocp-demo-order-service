build:
	docker build -t empirechaotix/order-service:0.1.0 .
	docker push empirechaotix/order-service:0.1.0
build-two:
	docker build -t empirechaotix/order-service:0.2.0 .
	docker push empirechaotix/order-service:0.2.0
init:
	oc adm policy add-scc-to-user privileged -z default -n order-service
	oc patch scc/privileged --patch {\"allowedCapabilities\":[\"NET_ADMIN\"]}
	oc adm policy add-scc-to-user privileged -z default
	oc adm policy add-cluster-role-to-user cluster-admin -z istio-manager-service-account
	oc adm policy add-cluster-role-to-user cluster-admin -z istio-ingress-service-account
	oc adm policy add-cluster-role-to-user cluster-admin -z default
	oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account
	oc adm policy add-scc-to-user privileged -z istio-ingress-service-account
	oc adm policy add-scc-to-user anyuid -z istio-manager-service-account
	oc adm policy add-scc-to-user privileged -z istio-manager-service-account
create:
	oc new-project order-service
delete:
	oc delete project order-service
deploy-general:
	oc apply -f openshift/Route.yaml
	oc apply -f openshift/Gateway.yml
	oc apply -f openshift/Service.yml
deploy-v1:
	oc project order-service
	istioctl kube-inject -f openshift/Deployment.yml > openshift/istio-deployment-v1.yml
	sed $$'s/            - NET_ADMIN/            - NET_ADMIN\\\n          privileged: true/g' openshift/istio-deployment-v1.yml > openshift/istio-deployment-v1-final.yml
	oc apply -f openshift/istio-deployment-v1-final.yml
deploy-v2:
	oc project order-service
	istioctl kube-inject -f openshift/Deployment-v2.yml > openshift/istio-deployment-v2.yml
	sed $$'s/            - NET_ADMIN/            - NET_ADMIN\\\n          privileged: true/g' openshift/istio-deployment-v2.yml > openshift/istio-deployment-v2-final.yml
	oc apply -f openshift/istio-deployment-v2-final.yml
deploy-v1-v2-5050:
	oc project order-service
	oc apply -f openshift/DestinationRule-v1-v2.yml
	oc apply -f openshift/VirtualService-v1-50-v2-50.yaml
undeploy-v1-v2-5050:
	oc project order-service
	oc delete -f openshift/DestinationRule-v1-v2.yml
	oc delete -f openshift/VirtualService-v1-50-v2-50.yaml
deploy-v1-v2-betaflag:
	oc project order-service
	oc apply -f openshift/DestinationRule-v1-v2.yml
	oc apply -f openshift/VirtualService-v1-v2-betaflag.yaml
undeploy-v1-v2-betaflag:
	oc project order-service
	oc delete -f openshift/DestinationRule-v1-v2.yml
	oc delete -f openshift/VirtualService-v1-v2-betaflag.yaml
deploy-v1-v2-mirror:
	oc project order-service
	oc apply -f openshift/DestinationRule-v1-v2.yml
	oc apply -f openshift/VirtualService-v1-v2-mirroring.yaml
undeploy-v1-v2-mirror:
	oc project order-service
	oc delete -f openshift/DestinationRule-v1-v2.yml
	oc delete -f openshift/VirtualService-v1-v2-mirroring.yaml
undeploy:
	oc project order-service
	oc delete -f openshift/Deployment.yml
	oc delete -f openshift/Route.yaml
	oc delete -f openshift/Gateway.yml
	oc delete -f openshift/Service.yml