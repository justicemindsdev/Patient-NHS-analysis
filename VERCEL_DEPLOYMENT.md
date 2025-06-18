# Vercel Deployment Guide

This guide explains how to deploy the Patient-NHS Analysis project to Vercel, ensuring that all audio files stored in Supabase remain accessible.

## Prerequisites

1. A Vercel account (https://vercel.com)
2. The GitHub repository (https://github.com/justicemindsdev/Patient-NHS-analysis)
3. Supabase project with stored audio files (https://eflzhvxrymhfvyfbxkrw.supabase.co)

## Environment Variables

The following environment variables need to be configured in your Vercel project settings:

| Variable | Value | Description |
|----------|-------|-------------|
| `SUPABASE_URL` | `https://eflzhvxrymhfvyfbxkrw.supabase.co` | The base URL of your Supabase project |
| `SUPABASE_STORAGE_URL` | `https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public` | The URL for accessing public storage objects |
| `SUPABASE_BUCKET_NAME` | `audios` | The name of the storage bucket containing audio files |
| `SUPABASE_FOLDER` | `lynne_hospital` | The folder within the bucket containing the project's audio files |

## Deployment Steps

1. **Connect to GitHub Repository**
   - Log in to your Vercel account
   - Click "Add New" > "Project"
   - Select the GitHub repository "Patient-NHS-analysis"
   - Click "Import"

2. **Configure Project**
   - Project Name: `patient-nhs-analysis` (or your preferred name)
   - Framework Preset: `Other`
   - Root Directory: `./` (default)

3. **Environment Variables**
   - Add the environment variables listed above in the "Environment Variables" section
   - These variables ensure that the application can access the audio files stored in Supabase

4. **Deploy**
   - Click "Deploy"
   - Vercel will build and deploy your project

## Vercel Configuration

The project includes a `vercel.json` file that configures the deployment:

```json
{
  "version": 2,
  "builds": [
    { "src": "*.html", "use": "@vercel/static" }
  ],
  "routes": [
    { "src": "/(.*)", "dest": "/$1" }
  ],
  "env": {
    "SUPABASE_URL": "https://eflzhvxrymhfvyfbxkrw.supabase.co",
    "SUPABASE_STORAGE_URL": "https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public"
  }
}
```

This configuration:
- Uses the static build for HTML files
- Sets up routes to serve all files
- Defines environment variables for Supabase access

## Maintaining Persistent Data

The project is designed to keep all heavy data (audio files) in Supabase, not in the GitHub repository or Vercel deployment. This approach ensures:

1. **Faster Deployments**: No large files to upload during deployment
2. **Better Performance**: Audio files are served from Supabase's optimized storage
3. **Persistent Data**: Audio files remain accessible even if the Vercel deployment is updated or redeployed

## Testing the Deployment

After deployment, you should be able to access:

- The main interface at: `https://patient.justice-minds.com/audio-podcast.html`
- The expert podcast script at: `https://patient.justice-minds.com/expert-podcast-script.html`

All audio files should load correctly from Supabase storage.

## Troubleshooting

If audio files are not loading:

1. Check that the Supabase project is still active
2. Verify that the environment variables are correctly set in Vercel
3. Ensure that the audio files in Supabase have the correct public permissions
4. Check browser console for any CORS-related errors
