### Medusa Deployment Pipeline
Automated deployment of Dockerized services to Amazon ECS using GitHub Actions, Docker Buildx, and ECR. Designed for reliability, simplicity, and fast CI/CD shipping.




Deployment Workflow Summary
Every push to the main branch triggers the following steps via GitHub Actions:

Checkout Code

Configure AWS Credentials (from repo secrets)

Authenticate Docker to ECR

Build Image with Buildx

Push Image to Amazon ECR

Trigger ECS Deployment

### 🔧 Requirements
ECR Registry: 573191494546.dkr.ecr.ap-south-1.amazonaws.com/medusa-app

ECS Cluster: medusa-cluster

ECS Service: medusa-service

GitHub Secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

ECR_URL (optional if hardcoded in workflow)

### 📦 Manual Deployment (GitHub CLI)
Ensure workflow_dispatch is enabled in deploy.yml, then:

bash
gh workflow run deploy.yml --ref main
To push via Git:

bash
git add .
git commit -m "Deploy update"
git push origin main
🧪 Troubleshooting Log (4-Hour Debugathon)
Issue	Resolution
unexpected EOF	Removed complex shell substitutions
Image not found	Added --load or used --push in Docker Buildx
no basic auth credentials	Authenticated Docker using AWS ECR login
Manual dispatch blocked	Enabled “read/write” workflow permissions
GitHub CLI error 403	Fixed token scopes and CLI auth
Layer reuse confusion	Verified caching with image digest
### 💡 Improvements to Explore
[ ] Tag image with commit SHA for traceability

[ ] Add Slack/webhook deploy notifications

[ ] Post-deploy ECS health checks

[ ] Rollback automation for failed deployments







