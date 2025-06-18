#!/bin/bash

# This script automates the deployment of the project to Vercel
# including setting up all required environment variables

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "Vercel CLI is not installed. Installing..."
    npm install -g vercel
fi

# Login to Vercel (if not already logged in)
vercel login

# Create .vercel directory if it doesn't exist
mkdir -p .vercel

# Create project.json configuration file
cat > .vercel/project.json << EOF
{
  "projectId": "prj_patient_nhs_analysis",
  "orgId": "justicemindsdev"
}
EOF

# Create environment variables file
cat > .vercel/.env.local << EOF
SUPABASE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co
SUPABASE_STORAGE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public
SUPABASE_BUCKET_NAME=audios
SUPABASE_FOLDER=lynne_hospital
EOF

# Deploy to Vercel with environment variables and custom domain
echo "Deploying to Vercel..."
vercel --prod --yes \
  --env SUPABASE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co \
  --env SUPABASE_STORAGE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public \
  --env SUPABASE_BUCKET_NAME=audios \
  --env SUPABASE_FOLDER=lynne_hospital \
  --alias patient.justice-minds.com

echo "Deployment complete!"
echo "Your project is now available at: https://patient.justice-minds.com"
