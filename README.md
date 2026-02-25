#  Three-Tier Architecture on AWS using Terraform

This project demonstrates a complete **3-Tier Architecture** deployed on AWS using Terraform.

It includes:
-  Frontend (React + Vite) hosted on S3
-  Backend (Node.js + Express) hosted on EC2
-  Database (MySQL) hosted on RDS
-  Infrastructure provisioned using Terraform (IaC)
![WhatsApp Image 2026-02-26 at 01 06 05](https://github.com/user-attachments/assets/c4e66466-47b2-4d3d-9741-9e8967f8e00a)

---

##  Architecture Overview

User → S3 (Frontend) → EC2 (Backend API) → RDS (MySQL Database)

1. User submits login form on frontend.
2. Frontend sends POST request to EC2 backend.
3. Backend processes request and inserts data into RDS.
4. Response is sent back to frontend.

---

##  Frontend Layer (S3)

- Built using React (Vite)
- Static website hosted on AWS S3
- Public access enabled via bucket policy
- Sends API requests to backend EC2 instance
- Managed using Terraform

Main Terraform file: `frontend.tf`

---

##  Backend Layer (EC2)

- Node.js + Express application
- Runs on Port 5000
- CORS configured for frontend communication
- Connects to RDS using environment variables
- Security group allows:
  - 22 (SSH)
  - 80 (HTTP)
  - 5000 (API)

API Route:
POST /api/users

Main Terraform file: `ec2.tf`

---

##  Database Layer (RDS)

- MySQL running on AWS RDS
- Deployed inside private subnets
- Accessible only from EC2 security group
- Stores user login data

Database Schema:

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(150) UNIQUE,
  password VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Main Terraform file: `rds.tf`

---

##  Networking (VPC Setup)

- Custom VPC
- Public subnet → EC2
- Private subnets → RDS
- Internet Gateway attached
- Route table configured
- Security groups for controlled access

Main Terraform file: `vpc.tf`

---

##  Terraform Deployment Steps

terraform init  
terraform plan  
terraform apply  

Terraform provisions:
- VPC
- Subnets
- Internet Gateway
- Route Tables
- Security Groups
- EC2 Instance
- RDS Instance
- S3 Bucket with Static Hosting

---

##  Backend Environment Variables (.env)

DB_HOST=<rds-endpoint>  
DB_USER=<db-username>  
DB_PASSWORD=<db-password>  
DB_NAME=myapp  
PORT=5000  

---

## Technologies Used

- AWS (EC2, RDS, S3, VPC)
- Terraform
- Node.js
- Express.js
- MySQL
- React (Vite)
- Git & GitHub

---

##  Key Highlights

✔ Complete 3-Tier Architecture  
✔ Infrastructure as Code (Terraform)  
✔ Secure VPC & Subnet Design  
✔ Frontend–Backend–Database Connectivity  
✔ Production-style Deployment Structure  


---

