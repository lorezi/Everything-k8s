#!/usr/bin/env bash

kubectl get --watch --output-watch-events configmap \
-o=custom-columns=type:type,name:object.metadata.name \ 
--no-headers | \ 
while read next; do
	NAME=$(echo $next | cut -d' ' -f2)
	EVENT=$(echo $next | cut -d' ' -f1)

	case $EVENT in
		ADDED|MODIFIED)
			kubectl apply -f - << EOF


apiVersion: apps/v1
kind: Deployment
metadata:
  name: {name: $NAME }
spec:
  selector:
    matchLabels:
      { app: $NAME }
  template:
    metadata:
      labels:
        { app: $NAME }
	  annotations: { kubectl.kubernetes.io/restartedAt: $(date) }
    spec:
      containers:
      - name: $NAME
        image: nginx:alpine
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
        - containerPort: -80
		volumeMounts:
			- {name: data, mountPath: /usr/share/nginx/html }
	  volumes:
	  	- name: data
		  configMap:
		  	name: $NAME
EOF
			  ;;
			DELETED)
				kubectl delete deploy $NAME
			  ;;
	esac
done