#!/bin/bash
set -e

echo "🔄 Fetching latest task definition for medusa-task..."

# Get latest revision number safely
TASK_REVISION=$(aws ecs list-task-definitions \
  --family-prefix medusa-task \
  --sort DESC \
  --max-items 1 \
  --query "taskDefinitionArns[0]" \
  --output text | cut -d':' -f6)

echo "📦 Latest task revision: $TASK_REVISION"

# Update ECS service with latest task revision
aws ecs update-service \
  --cluster medusa-cluster \
  --service medusa-service \
  --task-definition medusa-task:$TASK_REVISION

echo "✅ ECS service updated successfully"
