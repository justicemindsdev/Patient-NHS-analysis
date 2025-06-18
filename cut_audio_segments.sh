#!/bin/bash

# Directory for audio segments
SEGMENTS_DIR="/Volumes/EXCELLENCE/EXCELLENCE DIRECT/HOSPITAL MISHAP/audio_segments"
# Source MP3 file
SOURCE_MP3="/Volumes/EXCELLENCE/EXCELLENCE DIRECT/HOSPITAL MISHAP/Meeting with Ben Mak, Lynne 48523263-7daa-4a73-bdeb-1404263ccf57.mp3"
# List file
SEGMENTS_LIST="/Volumes/EXCELLENCE/EXCELLENCE DIRECT/HOSPITAL MISHAP/audio_segments_list.txt"

# Make sure the segments directory exists
mkdir -p "$SEGMENTS_DIR"

# Function to convert timestamp to seconds
timestamp_to_seconds() {
    local timestamp=$1
    local minutes=$(echo $timestamp | cut -d':' -f1)
    local seconds=$(echo $timestamp | cut -d':' -f2)
    echo $(( minutes * 60 + seconds ))
}

# Process each segment
segment_num=1
while IFS= read -r line; do
    # Look for timestamp lines
    if [[ $line =~ Timestamp:\ ([0-9]+:[0-9]+)-([0-9]+:[0-9]+) ]]; then
        start_time="${BASH_REMATCH[1]}"
        end_time="${BASH_REMATCH[2]}"
        
        # Convert to seconds for ffmpeg
        start_seconds=$(timestamp_to_seconds "$start_time")
        end_seconds=$(timestamp_to_seconds "$end_time")
        duration=$((end_seconds - start_seconds))
        
        # Get the previous line which contains the quote
        if [[ $prev_line =~ ^[0-9]+\.\ \"(.*)\"$ ]]; then
            quote="${BASH_REMATCH[1]}"
            # Create a short title from the quote (first 30 chars)
            short_quote=$(echo "$quote" | cut -c 1-30 | tr -d '"' | tr ' ' '_' | tr -d "'" | tr -d ',' | tr -d '.')
            
            # Determine what the quote proves
            title=""
            if [[ $quote =~ [Dd]ata\ [Pp]olicy || $quote =~ ICO\ license || $quote =~ your\ data ]]; then
                title="Data_Protection_Expert"
            elif [[ $quote =~ [Ss]urgery || $quote =~ [Bb]ackpack || $quote =~ [Tt]heater || $quote =~ [Tt]heatre ]]; then
                title="Surgical_Best_Practice"
            elif [[ $quote =~ [Ww]ednesbury || $quote =~ [Pp]rinciple || $quote =~ [Rr]easonable ]]; then
                title="Legal_Framework_Knowledge"
            elif [[ $quote =~ [Dd]ue\ [Pp]rocess || $quote =~ [Bb]est\ [Pp]ractice ]]; then
                title="Professional_Standards"
            elif [[ $quote =~ [Pp]rofessionals || $quote =~ [Ii]ntegrity || $quote =~ [Ss]ystem ]]; then
                title="Professional_Ethics"
            elif [[ $quote =~ [Pp]roud || $quote =~ [Tt]rust || $quote =~ [Ss]upport ]]; then
                title="Patient_Advocacy"
            else
                title="Expert_Knowledge"
            fi
            
            # Create filename
            filename="${segment_num}_${title}_${short_quote}.mp3"
            output_file="$SEGMENTS_DIR/$filename"
            
            echo "Cutting segment $segment_num: $start_time to $end_time"
            echo "Title: $title"
            echo "Output: $filename"
            
            # Use ffmpeg to cut the segment
            ffmpeg -i "$SOURCE_MP3" -ss "$start_seconds" -t "$duration" -acodec copy "$output_file" -y
            
            segment_num=$((segment_num + 1))
        fi
    fi
    
    # Store the current line for the next iteration
    prev_line="$line"
done < "$SEGMENTS_LIST"

echo "All segments have been cut and saved to $SEGMENTS_DIR"
