#!/bin/bash

# Check for potential credentials in staged changes
check_credentials() {
    # Common patterns for credentials
    patterns=(
        "api[_-]key"
        "auth[_-]token"
        "password"
        "secret"
        "access[_-]key"
        "sk_[a-zA-Z0-9]+"
        "AKIA[0-9A-Z]{16}"
    )
    
    # Get the list of staged files
    staged_files=$(git diff --cached --name-only)
    
    # Skip checking .env files
    staged_files=$(echo "$staged_files" | grep -v "\.env$")
    
    # Check each file for credential patterns
    for file in $staged_files; do
        if [ -f "$file" ]; then
            for pattern in "${patterns[@]}"; do
                if git diff --cached "$file" | grep -i "$pattern" > /dev/null; then
                    echo "ERROR: Credential found in staged changes"
                    echo "Please move credentials to .env file"
                    exit 1
                fi
            done
        fi
    done
    
    exit 0
}

check_credentials
