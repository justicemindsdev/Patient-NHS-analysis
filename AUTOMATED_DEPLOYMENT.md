# Automated Deployment Guide

This guide explains how to automatically deploy the Patient-NHS Analysis project to Vercel with all required environment variables, without having to manually enter them in the Vercel dashboard.

## Option 1: Using the Vercel CLI Script

We've created a bash script that automates the entire deployment process, including setting up all required environment variables.

### Prerequisites

- Node.js installed on your system
- npm installed on your system

### Steps to Deploy

1. Make the script executable:
   ```bash
   chmod +x vercel-deploy.sh
   ```

2. Run the script:
   ```bash
   ./vercel-deploy.sh
   ```

3. The script will:
   - Install the Vercel CLI if not already installed
   - Log you into Vercel (if not already logged in)
   - Create necessary configuration files
   - Deploy your project to Vercel with all required environment variables

### How It Works

The script uses the Vercel CLI to deploy your project and set environment variables in a single command:

```bash
vercel --prod --yes \
  --env SUPABASE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co \
  --env SUPABASE_STORAGE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public \
  --env SUPABASE_BUCKET_NAME=audios \
  --env SUPABASE_FOLDER=lynne_hospital
```

## Option 2: Using GitHub Actions

We've also set up a GitHub Actions workflow that automatically deploys your project to Vercel whenever changes are pushed to the main branch.

### Prerequisites

1. A Vercel account linked to your GitHub account
2. A Vercel API token

### Setting Up the Vercel API Token

1. Go to your Vercel account settings
2. Navigate to "Tokens"
3. Create a new token with "Full Account" scope
4. Copy the token

### Adding the Token to GitHub Secrets

1. Go to your GitHub repository
2. Navigate to "Settings" > "Secrets and variables" > "Actions"
3. Click "New repository secret"
4. Name: `VERCEL_TOKEN`
5. Value: Paste your Vercel API token
6. Click "Add secret"

### How It Works

The GitHub Actions workflow is defined in `.github/workflows/vercel-deploy.yml`. It:

1. Runs whenever you push to the main branch
2. Sets up Node.js
3. Installs the Vercel CLI
4. Deploys to Vercel with all required environment variables

The key part of the workflow is:

```yaml
- name: Deploy to Vercel
  run: |
    vercel --prod --yes \
      --token ${{ secrets.VERCEL_TOKEN }} \
      --env SUPABASE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co \
      --env SUPABASE_STORAGE_URL=https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public \
      --env SUPABASE_BUCKET_NAME=audios \
      --env SUPABASE_FOLDER=lynne_hospital
```

## Option 3: Using Vercel's Integration with GitHub

If you prefer to use Vercel's GitHub integration but still want to automate environment variable setup:

1. Fork the repository
2. Go to Vercel and create a new project from the forked repository
3. Before deploying, click on "Environment Variables"
4. Add the following environment variables:
   - `SUPABASE_URL`: `https://eflzhvxrymhfvyfbxkrw.supabase.co`
   - `SUPABASE_STORAGE_URL`: `https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public`
   - `SUPABASE_BUCKET_NAME`: `audios`
   - `SUPABASE_FOLDER`: `lynne_hospital`
5. Click "Deploy"

### Automating with Vercel's API

You can also use Vercel's API to programmatically create a project and set environment variables:

```javascript
// Example using fetch API
fetch('https://api.vercel.com/v9/projects', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${VERCEL_TOKEN}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    name: 'patient-nhs-analysis',
    gitRepository: {
      type: 'github',
      repo: 'justicemindsdev/Patient-NHS-analysis'
    },
    environmentVariables: [
      { key: 'SUPABASE_URL', value: 'https://eflzhvxrymhfvyfbxkrw.supabase.co', target: ['production', 'preview'] },
      { key: 'SUPABASE_STORAGE_URL', value: 'https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public', target: ['production', 'preview'] },
      { key: 'SUPABASE_BUCKET_NAME', value: 'audios', target: ['production', 'preview'] },
      { key: 'SUPABASE_FOLDER', value: 'lynne_hospital', target: ['production', 'preview'] }
    ]
  })
})
```

## Conclusion

By using any of these methods, you can deploy your project to Vercel with all required environment variables without having to manually enter them in the Vercel dashboard. This makes the deployment process more efficient and less error-prone.
