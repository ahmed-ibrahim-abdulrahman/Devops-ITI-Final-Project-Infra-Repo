![project](project.png)

# Project Description

The project involves setting up a **Continuous Integration and Continuous Deployment (CI/CD) pipeline** using Jenkins on **Google Cloud Platform (GCP)**. I used **Terraform** to create the necessary infrastructure, establish a private cluster, configure the network, and set up a private jump host on GCP.

The jump host can be accessed via **SSH** from my laptop using **Identity-Aware Proxy (IAP)**, which allows connection to the private GKE cluster. The Terraform state file is stored in a GCP bucket using a backend.

**Jenkins master and slave nodes** are set up within the GKE cluster using **Ansible**. To achieve this, I modified `ansible.cfg` to tell Ansible to use IAP to connect to the jump host through IAP and apply the YAML files.

A **Jenkins CI/CD pipeline** is created with four parameters: `release`, `dev`, `test`, and `prod`. The pipeline is responsible for building a Docker image of the application and pushing it to Docker Hub during the build stage. I also created deployment files for the app using **Helm**. The application is then deployed using Helm during the deployment stage, ensuring a seamless integration and deployment process.

[Devops-ITI-Final-Project-App-Repo](https://github.com/AhmedIbrahim-CS/Devops-ITI-Final-Project-App-Repo.git)
