Medusa Deployment Pipeline
This repository automates container deployment to AWS ECS using GitHub Actions. It builds and pushes a Docker image to Amazon ECR, then triggers ECS to update with the latest version — no manual intervention needed.

🚀 How the Pipeline Works
⚙️ Triggers
Auto-deploys on every push to main

Manual deploys via GitHub CLI (workflow_dispatch)

🔧 Steps
Checkout code

Authenticate with AWS + ECR

Build Docker image tagged as :latest

Push to ECR

ECS pulls latest image and restarts services

🧪 Debugging Journal: 4 Hours of DevOps Mayhem
We didn’t just “fix things” — we debugged like gladiators. Here's what went down:

Problem	Solution
unexpected EOF while looking for matching ')'	Removed multiline shell substitutions and simplified commands
Docker push failed with “image does not exist locally”	Added --load to docker buildx build so the image gets saved
Authentication errors (no basic auth credentials)	Used aws ecr get-login-password to login securely to ECR
GitHub workflow 403 (Resource not accessible)	Enabled “Read and write” workflow permissions in repo settings
Manual trigger blocked	Added workflow_dispatch to YAML, then used gh workflow run
Image layer issues	Optimized with cache-aware push (reused unchanged layers)
CLI permissions hiccups	Re-authenticated via GitHub CLI with gh auth login
We basically reverse-engineered every cryptic error message and patched up the pipeline like seasoned operators. Half debugging, half sorcery 🧙‍♂️

✅ Final Outcome
Clean push to ECR ✅

ECS triggers automatically ✅

Manual CLI triggers supported ✅

No rogue syntax or auth errors ✅

Mental peace restored ✅ 😌

💡 Usage
📦 Trigger via GitHub CLI
bash
gh workflow run deploy.yml --ref main
🔁 Trigger via Git Push
bash
git add .
git commit -m "Deploy: Updated feature X"
git push origin main
📍 ECS Deployment Details
Cluster: medusa-cluster

Service: medusa-service

Image URL: 573191494546.dkr.ecr.ap-south-1.amazonaws.com/medusa-app:latest
