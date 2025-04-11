
Step-by-Step Guide to Deploy and Access a Kubernetes App using Docker Desktop

1. Ensure Docker Desktop is installed and Kubernetes is enabled in Docker Desktop settings.

2. Open your terminal (PowerShell, CMD, or terminal in VS Code) and navigate to your project directory:
   cd "C:\Harshitha\cloud native\Task6.1\sit737-2025-prac6p"

3. Build your Docker image:
   docker build -t myapp:latest .

4. Tag the image for Docker registry (if using DockerHub):
   docker tag myapp:latest <your-dockerhub-username>/myapp:latest

5. Push the image to DockerHub:
   docker push <your-dockerhub-username>/myapp:latest

6. Update your deployment.yaml to use the pushed image:
   image: <your-dockerhub-username>/myapp:latest

7. Apply the Kubernetes deployment:
   kubectl apply -f deployment.yaml

8. Apply the Kubernetes service:
   kubectl apply -f service.yaml

9. Verify the deployment and pods:
   kubectl get deployments
   kubectl get pods

10. Check pod logs if there are any issues:
    kubectl describe pod <pod-name>
    kubectl logs <pod-name>

11. If needed, delete and let Kubernetes recreate the pod:
    kubectl delete pod <pod-name>

12. Check the service to get the exposed NodePort:
    kubectl get services

    Example output:
    NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    myapp        NodePort    10.103.42.249   <none>        80:30001/TCP   29m

13. Get the internal IP of your Docker Desktop Kubernetes node:
    kubectl get nodes -o wide

    Example output:
    NAME             STATUS   ROLES           AGE   VERSION   INTERNAL-IP    
    docker-desktop   Ready    control-plane   31m   v1.32.2   192.168.65.3

14. Access your app from the browser:
    http://localhost:30001
    (or)
    http://192.168.65.3:30001

15. If `localhost:30001` doesn’t work, verify port accessibility and firewall rules.

Notes:
- Ensure your image is correctly pushed and accessible publicly or is pulled locally by Kubernetes.
- For private images, setup imagePullSecrets in your deployment.

