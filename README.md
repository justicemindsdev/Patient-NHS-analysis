# Patient-NHS Analysis

## Overview

This repository contains an analysis of professional expertise demonstrated in a healthcare context, with a focus on data protection, surgical best practices, legal frameworks, professional standards, and patient advocacy.

## Features

- **Interactive Audio Podcast Interface**: A web-based interface that allows users to listen to audio segments and see how each statement connects to relevant legislation and professional standards.
- **Audio Segmentation**: Scripts for extracting and segmenting audio from a source recording.
- **Professional Analysis**: Detailed analysis of expertise across multiple domains, including data protection, surgical best practices, legal frameworks, and professional ethics.
- **Supabase Integration**: Audio segments are stored in Supabase for efficient delivery.

## Files

- `audio-podcast.html`: Interactive web interface for listening to audio segments with relevant legislation and frameworks.
- `expert-podcast-script.html`: Script for a podcast analyzing professional expertise.
- `audio_segments_list.txt`: List of audio segments with timestamps and quotes.
- `audio_segments_summary.md`: Summary of all audio segments organized by expertise category.
- `cut_audio_segments.sh`: Script for cutting audio segments from a source recording.
- `upload_to_supabase.sh`: Script for uploading audio segments to Supabase.

## Usage

1. Clone the repository
2. Open `audio-podcast.html` in a web browser to access the interactive interface
3. Listen to audio segments and explore the relevant legislation and frameworks

## Audio Storage

All audio files are stored in Supabase at:
`https://eflzhvxrymhfvyfbxkrw.supabase.co/storage/v1/object/public/audios/lynne_hospital/`

## Privacy

This repository contains no personal data. All audio files are stored externally, and only text analysis and references are included in this repository.
