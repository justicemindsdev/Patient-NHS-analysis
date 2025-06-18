#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Supabase storage information
ENDPOINT="${SUPABASE_ENDPOINT}"
BUCKET_NAME="${SUPABASE_BUCKET_NAME}"
FOLDER="${SUPABASE_FOLDER}"
ACCESS_KEY_ID="${SUPABASE_ACCESS_KEY_ID}"
SECRET_ACCESS_KEY="${SUPABASE_SECRET_ACCESS_KEY}"
REGION="${SUPABASE_REGION}"

# Logo file path
LOGO_FILE="/Volumes/EXCELLENCE/EXCELLENCE DIRECT/HOSPITAL MISHAP/justicemindslogo.svg"

# Configure AWS CLI with Supabase credentials
export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$REGION"

# Upload the logo file to Supabase
if [ -f "$LOGO_FILE" ]; then
    filename=$(basename "$LOGO_FILE")
    echo "Uploading $filename to Supabase..."
    
    # Upload the file to Supabase storage
    aws s3 cp "$LOGO_FILE" "s3://$BUCKET_NAME/$FOLDER/$filename" \
        --endpoint-url "$ENDPOINT" \
        --content-type "image/svg+xml"
    
    echo "Uploaded $filename"
    echo "Logo URL: https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public/$BUCKET_NAME/$FOLDER/$filename"
else
    echo "Logo file not found at $LOGO_FILE"
fi
