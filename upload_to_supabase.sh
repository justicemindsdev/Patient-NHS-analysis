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

# Directory containing audio segments
SEGMENTS_DIR="/Volumes/EXCELLENCE/EXCELLENCE DIRECT/HOSPITAL MISHAP/audio_segments"

# Configure AWS CLI with Supabase credentials
export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$REGION"

# Upload each audio segment to Supabase
for file in "$SEGMENTS_DIR"/*.mp3; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "Uploading $filename to Supabase..."
        
        # Upload the file to Supabase storage
        aws s3 cp "$file" "s3://$BUCKET_NAME/$FOLDER/$filename" \
            --endpoint-url "$ENDPOINT" \
            --content-type "audio/mpeg"
        
        echo "Uploaded $filename"
    fi
done

echo "All audio segments have been uploaded to Supabase storage."
