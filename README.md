![project](project.png)

# Project Description

The project involves setting up a **Continuous Integration and Continuous Deployment (CI/CD) pipeline** using Jenkins on **Google Cloud Platform (GCP)**. I used **Terraform** to create the necessary infrastructure, establish a private cluster, configure the network, and set up a private jump host on GCP.

The jump host can be accessed via **SSH** from my laptop using **Identity-Aware Proxy (IAP)**, which allows connection to the private GKE cluster. The Terraform state file is stored in a GCP bucket using a backend.

**Jenkins master and slave pods** are set up within the GKE cluster using **Ansible**. To achieve this, I modified `ansible.cfg` to tell Ansible to use IAP to connect to the jump host through IAP and apply the YAML files.

A **Jenkins CI/CD pipeline** is created with four parameters: `release`, `dev`, `test`, and `prod`. The pipeline is responsible for building a Docker image of the application and pushing it to Docker Hub during the build stage. I also created deployment files for the app using **Helm**. The application is then deployed using Helm during the deployment stage, ensuring a seamless integration and deployment process.



1. Run `terraform init` and `terraform apply` to create the necessary infrastructure on GCP.

![1](Screenshots/1.png)

![2](Screenshots/2.png)

![3](Screenshots/3.png)

2. Uncomment the backend section and run `terraform init` again to use the backend and store the Terraform state file in the GCP bucket.


3. Delete the local Terraform state file and run `terraform apply` again to confirm that the backend is working.

![4](Screenshots/4.png)

![5](Screenshots/5.png)

![6](Screenshots/6.png)


4. Test the setup by making an SSH connection to the jump host and then exiting. Run `gcloud compute ssh --zone <zone> <jump-host-name> --tunnel-through-iap --project <project-ID>` to connect to the jump host through IAP.

![7](Screenshots/7.png)

![8](Screenshots/8.png)

5. Run `gcloud compute ssh --zone <zone> <jump-host-name> --tunnel-through-iap --project <project-ID> --dry-run` and use the output to tell Ansible to use IAP to SSH to the private jump host and copy files to the jump host and apply YAML files in the jump host to set up Jenkins master and slave.

![9](Screenshots/9.png)

![10](Screenshots/10.png)

![11](Screenshots/11.png)

![12](Screenshots/12.png)

6. Take the administrator password and create a user.

![13](Screenshots/13.png)

![14](Screenshots/14.png)

![15](Screenshots/15.png)

![16](Screenshots/16.png)

![17](Screenshots/17.png)

7. Create password the Jenkins user and start the SSH service to allow SSH on the slave pod

![18](Screenshots/18.png)

8. Write '/var/jenkins_home' in the 'Remote root directory' field, choose the launch method 'Launch agents via SSH', specify the cluster IP service in the 'Host' field, and create credentials with the same username and password used in step 6 to establish an SSH connection to the agent.

![19](Screenshots/19.png)

![20](Screenshots/21.png)

![22](Screenshots/22.png)

![23](Screenshots/23.png)

![24](Screenshots/24.png)

9. Create a Jenkins CI/CD pipeline with four parameters: `release`, `dev`, `test`, and `prod`.

![25](Screenshots/25.png)

![26](Screenshots/26.png)

![27](Screenshots/27.png)

![28](Screenshots/28.png)

![29](Screenshots/29.png)


10. Create docker credentials to allow access to Docker Hub.

![30](Screenshots/30.png)


11. create kubeconfig credentials to allow the Jenkins pipeline to deploy to the cluster.

![31](Screenshots/31.png)

![32](Screenshots/32.png)

12. Run `chmod 777 /var/run/docker.sock` This will allow the Jenkins slave pod to access the Docker socket.


![33](Screenshots/33.png)


13. Create a namespace for the Applcation using `kubectl create namespace <namespace-name>`.

![34](Screenshots/34.png)

14 . The pipeline :

![35](Screenshots/35.png)

![36](Screenshots/36.png)

![37](Screenshots/37.png)

![38](Screenshots/38.png)

![39](Screenshots/39.png)

![40](Screenshots/40.png)

![41](Screenshots/41.png)

![42](Screenshots/42.png)


15 . Run the following commands to see the outputs : `helm list -n <namespace-name>` 

`kubectl get pods -n <namespace-name>` 

`kubectl get svc -n <namespace-name>`.

`kubectl get deployments -n <namespace-name>`

![43](Screenshots/43.png)





16 . Take the ip of loadbalancer service and put it in the browser to see the working application

![44](Screenshots/44.png)

![45](Screenshots/45.png)


17. the pipeline

![46](Screenshots/46.png)

![47](Screenshots/47.png)

![48](Screenshots/48.png)





**This is a summary about the Terraform modules that I used in this project:**
- **gke-cluster:** Creates a GKE cluster and node pool with VPC-native networking, private endpoint, specific IP allocation policy, and machine type.
- **iap:** Creates a service account, adds it to a project with the "iap.tunnelResourceAccessor" role, and creates a firewall rule to allow SSH traffic.
- **jump_host:** Creates a service account bound to a role, an internal IP address, and a Compute Engine instance with a specific machine type, boot disk image, startup script, and service account with a specific scope.
- **nat_gateway:** Creates a router and NAT.
- **subnet:** Creates a subnetwork with a specified name, IP address range, and enabled private IP access to Google services.
- **vpc:** Creates a network with a specified name, routing mode, and automatic subnetwork creation is false.


[Devops-ITI-Final-Project-App-Repo](https://github.com/AhmedIbrahim-CS/Devops-ITI-Final-Project-App-Repo.git)
