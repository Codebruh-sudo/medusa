SystemDesign.md — Medusa Deployment Pipeline
🎯 Objective
Automate containerized application deployment for Medusa via GitHub Actions, Amazon ECR, and ECS. The goal is to reduce manual deployment steps, ensure image traceability, and enable rapid rollouts using DevOps best practices.

🧩 Core Components
Component	Role
GitHub Actions	CI/CD orchestration & automation
Docker Buildx	Multi-platform image builder
Amazon ECR	Container registry for storing images
Amazon ECS	Container runtime (cluster + service)
AWS CLI	Interface to update services, push images
ECS Task Definition	Blueprint for containerized service
GitHub CLI (optional)	Manual workflow triggering via terminal
🔄 Data Flow & Process
Code Push to main → GitHub Actions triggered

Build Phase

Docker image built and tagged as :latest

Image either loaded locally (--load) or pushed directly (--push)

Authentication

Docker authenticates with ECR using AWS CLI

Push Phase

Image pushed to ECR

Layers cached and reused when possible

Deploy Phase

ECS service (medusa-service) on cluster (medusa-cluster) triggered with force-new-deployment

ECS pulls latest tag and restarts containers

🧠 Design Decisions
✅ Use --load or --push to resolve Buildx caching issues

✅ Force ECS deployments instead of task revision juggling

✅ Simplified YAML for easier debugging and onboarding

✅ Secrets Management using GitHub Actions secrets for AWS keys & ECR endpoint

✅ Manual Trigger Support via workflow_dispatch and GitHub CLI (gh workflow run)

📌 Assumptions
Task definition in ECS is already configured to use :latest tag

Repository permissions include “read/write” for workflow execution

ECR URL stored in secrets.ECR_URL

AWS credentials stored securely in secrets.AWS_ACCESS_KEY_ID and secrets.AWS_SECRET_ACCESS_KEY

⚠️ Edge Cases We Handled
Problem	Solution
Shell parsing errors (unexpected EOF)	Removed script-level substitutions and simplified YAML
Missing image tag	Ensured --load used in docker buildx build
Auth failures	Added docker login via aws ecr get-login-password
CLI dispatch blocked	Enabled workflow permissions + added workflow_dispatch
Image not found during push	Confirmed correct tagging and visibility post-build
🧘 Deployment Philosophy
This system was designed to be:

Minimal: Just enough steps to get the job done

Recoverable: Fast rollback or fix if something fails

Transparent: Easy to read, debug, and extend

Human-Proof: No unexpected syntax traps or fragile scripts
