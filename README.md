# ECS Threat Composer Deployment (ECS Fargate + Terraform + GitHub Actions)

This project is a complete AWS deployment of a containerised web application. It focuses on building the infrastructure using **Terraform**, packaging the application with **Docker**, and automating deployments using **GitHub Actions**.

The result is a live, production-style setup deployed to AWS and accessible through a custom domain over **HTTPS**, with CI/CD authenticated via **GitHub OIDC** (no static AWS keys).

---

## Project Structure

```text
ECS-Projects/
├── .github/
│   └── workflows/
│       ├── build.yaml
│       ├── plan.yaml
│       ├── apply.yaml
│       └── destroy.yaml
│
├── Application/
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   ├── yarn.lock
│   ├── public/
│   └── src/
│
├── Terraform/
│   ├── backend.tf                  
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars            
│   ├── modules/
│   │   ├── vpc/
│   │   ├── sg/
│   │   ├── alb/
│   │   ├── ecs/
│   │   ├── iam/
│   │   ├── acm/
│   │   ├── dns/
│   │   ├── s3/
│   │ 
│   └── Bootstrap/                  
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       └── README.md
│
├── .gitignore
└── README.md
---
## ARCHITTECTURE
![alt text](image.png)
---

