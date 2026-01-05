
# ECS Threat Composer

A monorepo that demonstrates packaging a web application, containerising it, and deploying it to AWS using ECS Fargate with Terraform and GitHub Actions. This repo is designed to follow a realistic production workflow: manual ClickOps exploration, then infrastructure-as-code, and finally automated CI/CD with secure AWS authentication (OIDC).

**What this repo contains**
- **App**: A lightweight React app served by Nginx in `application/`.
- **Container config**: `Dockerfile` and `.dockerignore` for multi-stage builds and minimal runtime images.
- **Infra**: Terraform configuration and reusable modules for VPC, ECS, ALB, ECR, ACM, Route53, IAM, and security groups under `terraform/` and `modules/`.
- **CI/CD**: GitHub Actions workflows in `.github/workflows/` that build/push images and run Terraform (init/plan/apply) using OIDC.

**Deliverables checklist**
- [ ] `app/` with `/health` route returning `{"status":"ok"}`
- [ ] `Dockerfile` (multi-stage), `.dockerignore`, non-root runtime user
- [ ] Image pushed to ECR (tagged with commit SHA or version)
- [ ] Terraform (IaC) 
- [ ] `.github/workflows/deploy.yml` (build, push, terraform)
- [ ] HTTPS via ACM + Route53 pointing to ALB


**Repository layout (high level)**

```

├── app/                      
│   └── (React UI + Dockerfile)
│
├── terraform/                
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   └── modules/
│       ├── vpc/
│       ├── alb/
│       ├── ecs/
│       ├── acm/
│       ├── dns/
│       ├── iam/
│       ├── sg/
│       └── s3/
│
└── .github/
    └── workflows/
        ├── build.yaml
        ├── plan.yaml
        ├── apply.yaml
        └── destroy.yaml
```

**Architecture**


```
image-1.png


---
**1) Application Setup**

Requirements
- Simple route `/health` returning `{ "status": "ok" }`.
- Runs locally on port 80 before containerising.

Verification (local):

```sh
# from project root
cd application
npm install
npm run start
curl http://localhost:80/health
# expected: {"status":"ok"}
```



**2) Containerisation**

Requirements
- Multi-stage `Dockerfile` (build → runtime)
- `.dockerignore`
- Non-root runtime user and small image

Sample verification:

```sh
docker build -t threatmod:latest application/
docker run -p 8080:80 threatmod:latest
curl http://localhost:8080/health
# expected: {"status":"ok"}
```

Place your `Dockerfile` and `.dockerignore` in `application/`.

**3) Image Registry (ECR)**

Preferred: push to ECR. Tag with commit SHA or version.

Example push commands (after auth):

```sh
aws ecr create-repository --repository-name threatmod || true
docker tag threatmod:latest <account>.dkr.ecr.<region>.amazonaws.com/threatmod:<tag>
docker push <account>.dkr.ecr.<region>.amazonaws.com/threatmod:<tag>
```

**4) Terraform (IaC)**

Recreate the ClickOps setup using Terraform. Minimum resources:
- VPC with public subnets
- ECS cluster + Fargate service
- ECR repository
- ALB + listeners + target group
- ACM certificate
- Route53 record for `tm.<your-domain>`
- IAM roles and security groups

Structure example:

```
terraform/
├─ provider.tf
├─ backend.tf            # optional S3 + DynamoDB locking
├─ main.tf
├─ variables.tf
├─ outputs.tf
└─ modules/
	 ├─ vpc/
	 ├─ ecs/
	 ├─ alb/
	 ├─ ecr/
	 └─ acm/
```

Quick commands:

```sh
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan -out plan.tfplan
terraform apply plan.tfplan
```

Notes: Use an S3 backend and DynamoDB for locks (recommended for team use).

**6) CI/CD (GitHub Actions)**

Goals:
- Build & tag image with SHA
- Push to ECR
- Run `terraform init`, `plan`, and `apply` on `main` (use OIDC, no static creds)
- After deploy, run a health-check `curl https://tm.<your-domain>/health` and fail if unhealthy

Place workflows under `.github/workflows/` and include a `workflow_dispatch` trigger for manual runs.

Suggested checks: `terraform fmt`, `terraform validate`, `tflint` (optional), and an automated post-deploy curl.

**7) HTTPS & Domain**

- Use ACM for certificates .
- Add Route53 `A`/`CNAME` record (e.g., `tm.labs.<your-domain>`) to the ALB.
- Configure ALB listener to forward 80→443 if you want HTTP→HTTPS redirect.

*
---

Screenshots
- 
![alt text](image-1.png)
![alt text](<Screenshot 2025-12-29 170445.png>)
![alt text](<Screenshot 2025-12-29 170526.png>)
![alt text](<Screenshot 2025-12-29 170809.png>)
![alt text](<Screenshot 2025-12-29 171134.png>)
---





