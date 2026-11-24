# 🛍️ Flipkart Product Recommender Chatbot

An AI-powered e-commerce shopping assistant that understands complex user queries and recommends relevant products from Flipkart product data using Retrieval-Augmented Generation (RAG).

The application uses LangChain and LangGraph to support intelligent, stateful, multi-turn conversations, with a containerized microservices architecture designed for deployment on Google Cloud Platform (GCP).

## 🚀 Project Demo

![Flipkart Chatbot Demo](https://github.com/user-attachments/assets/c476cb8c-2635-41bf-9833-2d07e0b04039)

## ✨ Key Features

- **Intelligent Product Search:** Understands natural language shopping queries.
- **RAG-Based Retrieval:** Retrieves relevant products from the Flipkart dataset.
- **Product Recommendations:** Suggests products based on user requirements.
- **Multi-turn Conversations:** Maintains conversational context using LangGraph.
- **Modular Architecture:** Separates application components for better maintainability.
- **Containerization:** Uses Docker for application deployment.
- **Kubernetes Orchestration:** Deploys and manages containerized services.
- **Cloud Deployment:** Runs the application on Google Cloud Platform.
- **Monitoring & Observability:** Uses Prometheus and Grafana to monitor application health.

## 🛠️ Tech Stack

| Category            | Technologies                   |
| ------------------- | ------------------------------ |
| Language            | Python                         |
| LLM Framework       | LangChain                      |
| Agent Orchestration | LangGraph                      |
| RAG                 | Retrieval-Augmented Generation |
| Vector Database     | Astra DB                       |
| LLM Provider        | Groq                           |
| Embeddings          | Hugging Face                   |
| Containerization    | Docker                         |
| Orchestration       | Kubernetes, Minikube           |
| Cloud               | Google Cloud Platform          |
| Monitoring          | Prometheus, Grafana            |

## 📁 Project Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Dataman10/flipkart_product_assistant.git

cd flipkart_product_assistant
```

### 2. Create a Virtual Environment

```bash
python -m venv FPRS
```

Activate the environment:

**Windows:**

```bash
FPRS\Scripts\activate
```

**Linux:**

```bash
source FPRS/bin/activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure Environment Variables

Create a `.env` file in the project root.

Configure the required credentials:

```env
GROQ_API_KEY=
ASTRA_DB_APPLICATION_TOKEN=
ASTRA_DB_KEYSPACE=default_keyspace
ASTRA_DB_API_ENDPOINT=
HF_TOKEN=
HUGGINGFACEHUB_API_TOKEN=
```

Never commit your `.env` file or expose API credentials on GitHub.

### 5. Run the Application Locally

Run the application using your project's configured entry point.

Verify that the application works correctly before deploying it.

---

## ☁️ Deployment on Google Cloud Platform

### 1. Create a GCP VM Instance

Navigate to Google Cloud Console → Compute Engine → VM Instances → Create Instance.

Recommended configuration:

- **Instance Name:** `flipkart-bot-vm`
- **Machine Series:** E2
- **Machine Type:** Standard
- **Memory:** 16 GB RAM
- **Boot Disk:** 256 GB
- **Operating System:** Ubuntu 24.04 LTS

Enable HTTP and HTTPS traffic if required by your deployment.

Create the VM and connect using the browser-based SSH option.

### 2. Clone the Repository on VM

```bash
git clone https://github.com/Dataman10/flipkart_product_assistant.git

cd flipkart_product_assistant
```

### 3. Install and Configure Docker

Follow the official Docker installation guide for Ubuntu:

https://docs.docker.com/engine/install/ubuntu/

Verify Docker installation:

```bash
docker run hello-world
```

Configure Docker to run without sudo by following the official post-installation instructions:

https://docs.docker.com/engine/install/linux-postinstall/

Enable Docker services at startup:

```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

Verify:

```bash
systemctl status docker
docker ps
docker ps -a
```

### 4. Configure Minikube and Kubernetes

Install Minikube by following its official documentation:

https://minikube.sigs.k8s.io/docs/start/

Select:

- OS: Linux
- Architecture: x86-64
- Installation: Binary Download

Start the cluster:

```bash
minikube start
```

Install kubectl:

```bash
sudo snap install kubectl --classic
```

Verify the installation:

```bash
kubectl version --client

minikube status

kubectl get nodes

kubectl cluster-info

docker ps
```

### 5. Connect GitHub with VM

Configure Git identity:

```bash
git config --global user.email "hiteshdataman@gmail.com"

git config --global user.name "Dataman10"
```

Push updated code whenever required:

```bash
git add .

git commit -m "Update application"

git push origin main
```

For private repository authentication, use an appropriate GitHub authentication method, such as a Personal Access Token or SSH key.

---

## 🐳 Application Deployment

### 1. Configure Docker with Minikube

```bash
eval $(minikube docker-env)
```

### 2. Build Docker Image

```bash
docker build -t flipkart-bot:latest .
```

Ensure the image name in your Kubernetes deployment manifest matches this image.

### 3. Configure Kubernetes Secrets

Create secrets for your application credentials:

```bash
kubectl create secret generic llmops-secrets \
  --from-literal=GROQ_API_KEY="YOUR_GROQ_API_KEY" \
  --from-literal=ASTRA_DB_APPLICATION_TOKEN="YOUR_ASTRA_TOKEN" \
  --from-literal=ASTRA_DB_KEYSPACE="default_keyspace" \
  --from-literal=ASTRA_DB_API_ENDPOINT="YOUR_ASTRA_ENDPOINT" \
  --from-literal=HF_TOKEN="YOUR_HF_TOKEN" \
  --from-literal=HUGGINGFACEHUB_API_TOKEN="YOUR_HF_TOKEN"
```

Do not store real credentials in GitHub or deployment manifests.

### 4. Deploy Using Kubernetes

Apply your actual Kubernetes deployment and service manifests:

```bash
kubectl apply -f <your-deployment-file>.yaml

kubectl get pods

kubectl get services
```

Check application logs:

```bash
kubectl logs <pod-name>
```

### 5. Access the Application

Forward the application service port:

```bash
kubectl port-forward svc/<your-service-name> 5000:80
```

Access the application locally:

```text
http://localhost:5000
```

For remote access, use an SSH tunnel or appropriately restricted firewall rules rather than exposing development port forwarding publicly.

---

## 📊 Monitoring with Prometheus & Grafana

### 1. Create Monitoring Namespace

```bash
kubectl create namespace monitoring

kubectl get namespaces
```

### 2. Deploy Prometheus

```bash
kubectl apply -f prometheus/prometheus-configmap.yaml

kubectl apply -f prometheus/prometheus-deployment.yaml
```

### 3. Deploy Grafana

```bash
kubectl apply -f grafana/grafana-deployment.yaml
```

### 4. Verify Monitoring Pods

```bash
kubectl get pods -n monitoring
```

### 5. Access Prometheus

```bash
kubectl port-forward -n monitoring svc/prometheus-service 9090:9090
```

Open:

```text
http://localhost:9090
```

### 6. Access Grafana

```bash
kubectl port-forward -n monitoring svc/grafana-service 3000:3000
```

Open:

```text
http://localhost:3000
```

Default credentials, if unchanged:

```text
Username: admin
Password: admin
```

Change the default password after your first login.

### 7. Configure Grafana Data Source

1. Open Grafana.
2. Navigate to Settings → Data Sources.
3. Select Prometheus.
4. Configure the URL:

```text
http://prometheus-service.monitoring.svc.cluster.local:9090
```

5. Click Save & Test.

After successful configuration, create dashboards to visualize application and infrastructure metrics.

---

## 🏗️ Architecture & Deployment Workflow

```text
User
  |
  v
Flipkart Shopping Assistant
  |
  v
FastAPI / Application Backend
  |
  v
LangChain + LangGraph
  |
  v
RAG Pipeline
  |
  v
Astra DB / Product Retrieval
  |
  v
LLM Response
  |
  v
Docker Container
  |
  v
Kubernetes (Minikube)
  |
  v
Google Cloud Platform
  |
  v
Prometheus + Grafana
```

## 🎯 Learning Objectives

- Building production-oriented RAG applications.
- Developing stateful AI agents using LangGraph.
- Designing modular and scalable microservices.
- Containerizing applications with Docker.
- Orchestrating deployments using Kubernetes.
- Deploying AI applications on Google Cloud Platform.
- Implementing application monitoring and observability.

## 👨‍💻 Author

**Hitesh Moota**

- GitHub: [@Dataman10](https://github.com/Dataman10)

---

⭐ If you find this project interesting, consider giving the repository a star!
