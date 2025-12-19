# DevOps Final Project

**Student:** Nurasyl Maratkanuly  
**Project:** DevOps Final Exam  
**Environment:** Ubuntu 24.04 (VirtualBox VM)  

This project demonstrates a complete DevOps pipeline including CI/CD automation, containerization, Kubernetes orchestration, and infrastructure automation with Ansible.

---

## Architecture Diagram

The system follows a DevOps-oriented architecture that integrates source control, CI/CD automation, containerization, and Kubernetes orchestration.

**Architecture overview:**
- Source code is stored in a GitHub repository.
- Jenkins acts as the CI/CD server and pulls the code from GitHub.
- The application is built using the Gradle Wrapper.
- A Docker image is created using a multi-stage Dockerfile.
- Docker Compose is used for local container validation.
- The application is deployed to a Kubernetes cluster (Minikube).
- PostgreSQL runs as a separate Kubernetes deployment and is accessed via a ClusterIP service.
- Horizontal Pod Autoscaler (HPA) is configured to scale the application based on CPU usage.

*Figure 1. DevOps project architecture diagram*

---

## Step-by-Step Setup Instructions

1. A virtual machine with **Ubuntu 24.04 LTS** was prepared using VirtualBox.
2. System dependencies were installed using a Bash setup script:
   - Java 17
   - Git
   - Curl
   - Unzip
3. The project repository was cloned from GitHub.
4. Jenkins was installed as a system service and configured.
5. Jenkins pipeline performs:
   - Source code checkout
   - Gradle build
   - Docker image creation
   - Docker Compose verification
6. Minikube was used to create a local Kubernetes cluster.
7. Kubernetes manifests (Deployment, Service, ConfigMap, Secret, HPA) were applied.
8. Ansible playbook automates Kubernetes deployment and validation.
9. Application availability is verified via REST endpoint.

---

## CI/CD Pipeline Flow Description

The CI/CD pipeline is implemented using Jenkins and consists of the following stages:

1. Jenkins pulls the source code from the GitHub repository.
2. The application is built using Gradle (`./gradlew clean build`).
3. A Docker image is created using a multi-stage Dockerfile.
4. The application is started using Docker Compose for validation.
5. Kubernetes manifests are applied to deploy the application and database.
6. Jenkins verifies the application availability using the `/actuator/health` endpoint.
7. The pipeline finishes successfully only if all stages pass.

---

## Verification Evidence

### Jenkins Pipeline Execution Success

The Jenkins pipeline completes all stages successfully, including build, containerization, and deployment.

*Figure 2. Successful Jenkins pipeline execution*

---

### Running Kubernetes Pods and Services

All Kubernetes components are running correctly:
- PostgreSQL pod is in `Running` state.
- Application pod is in `Running` and `Ready` state.
- Services are correctly exposed using ClusterIP and NodePort.

Example commands:
```bash
kubectl get pods -o wide
kubectl get svc
