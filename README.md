# Jenkins-slave
Configured Jenkins master-slave architecture using Docker as slave and 3 working nodes on AWS EC2 instance. Set up Jenkins master on EC2, created Docker image for slave, and launched 3 nodes to distribute workload efficiently


Setting Up Jenkins Master-Slave Architecture with Docker and AWS EC2

This project involves configuring a Jenkins master-slave architecture using Docker as the slave environment and AWS EC2 instances as the working nodes. The goal is to efficiently distribute workloads across multiple nodes using Docker containers, allowing for robust, scalable, and fault-tolerant Continuous Integration (CI) pipelines. Below is a detailed breakdown of each step involved in setting up the architecture.

1. Overview of Jenkins Master-Slave Architecture
Jenkins is widely used for CI/CD pipelines, where jobs can be distributed across multiple worker nodes to enhance performance and reliability. In this setup:

Jenkins Master: Orchestrates the build process, manages jobs, schedules builds, and assigns work to the slave nodes.
Jenkins Slaves: Execute tasks as instructed by the master, with each slave running in an isolated Docker container.

2. Setting Up AWS EC2 Instances for Jenkins Master
Step 1: Launching EC2 Instance
Instance Type: Select an EC2 instance (e.g., t2.micro) with appropriate resources for the Jenkins master.
Operating System: Use Ubuntu 20.04 as the base OS for Jenkins.
Security Group: Configure inbound rules to allow traffic on ports 8080 (Jenkins default) and 22 (SSH access).

''''sudo apt update
sudo apt install openjdk-11-jre''''

Step 2: Installing Jenkins on EC2

Install Jenkins using the following commands:

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins

Start and enable Jenkins:

sudo systemctl start jenkins
sudo systemctl enable jenkins


3. Configuring Docker as a Slave on EC2

Step 1: Install Docker
On each EC2 instance (for slave nodes), install Docker:

sudo apt update
sudo apt install docker.io
sudo usermod -aG docker $(whoami)

Step 2: Create a Docker Image for the Slave Node
You will need to create a Docker image that contains the Jenkins slave agent. Use the following Dockerfile as an example:

files are uploaded in repo.

Build the Docker image:

docker build -t jenkins-slave .

Step 3: Launch Docker Containers for Slave Nodes
Launch three Docker containers as Jenkins slaves on the EC2 instances:

docker run -d --name jenkins-slave1 jenkins-slave
docker run -d --name jenkins-slave2 jenkins-slave
docker run -d --name jenkins-slave3 jenkins-slave


4. Configuring Jenkins Master to Connect with Slave Nodes

5. Step 1: Add New Nodes in Jenkins
From the Jenkins UI:

Navigate to Manage Jenkins > Manage Nodes and Clouds > New Node.
Add each slave node (slave1, slave2, slave3) with proper credentials and IP addresses.
Step 2: Configuring Launch Method
In each node configuration, select Launch agent by connecting it to the master. This will connect the slave nodes running in Docker containers to the Jenkins master.

5. Workload Distribution and Running Jobs

6. Step 1: Creating a Simple Jenkins Job
Create a simple freestyle project in Jenkins to run on a specific node. For instance:

Go to New Item, create a job, and specify a label that corresponds to one of the slave nodes.
The job could be as simple as a shell script to check the Java version:

java -version


Step 2: Monitoring Job Execution
Once the job is triggered, Jenkins will automatically distribute the workload across the configured slave nodes. You can view which node the job is running on by checking the Console Output of the job.

6. Final Thoughts and Scalability

7. By utilizing Docker for your Jenkins slaves, you ensure that the environment is isolated and easy to manage. Docker’s portability combined with the flexibility of AWS EC2 ensures that your CI/CD pipelines are scalable and fault-tolerant. You can easily add or remove nodes by launching new EC2 instances and running additional Docker containers.

As the project grows, you can consider using Jenkins Pipelines for more complex build processes and leverage Docker Swarm or Kubernetes for container orchestration.
