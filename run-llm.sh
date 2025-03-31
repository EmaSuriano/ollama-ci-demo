#!/bin/bash

DATE=$(date +'%Y-%m-%d')
PHRASES_DIR="./src/phrases"
FILE_PATH="$PHRASES_DIR/$DATE.md"
MODEL='llama3.2-motivational'
MODEL_FILE='./Modelfile'

# Function to collect all previous phrases and return them as a string
collect_previous_phrases() {
    local all_phrases=""
    
    if [ -d "$PHRASES_DIR" ]; then
        for file in "$PHRASES_DIR"/*.md; do
            if [ -f "$file" ]; then
                content=$(cat "$file")
                all_phrases+=$'\n'"$content"
            fi
        done
    fi
    
    echo "$all_phrases"
}

# Avoid running the command if the file already exists
if [ -f "$FILE_PATH" ]; then
    echo '[INFO] Phrase already exists, skipping...'
    exit 0
fi

echo '[INFO] Creating new model based on Modelfile...'
ollama create $MODEL -f $MODEL_FILE

ALL_PREVIOUS_PHRASES=$(collect_previous_phrases)
PROMPT=$(cat <<EOF
Give me an inspirational phrase, just the phrase without the author.
Try to avoid repeating the same phrases as before:
$ALL_PREVIOUS_PHRASES
EOF
)


echo '[INFO] Generating new phrase...'
echo "$PROMPT"


ollama run "$MODEL" "$PROMPT" > "$FILE_PATH"
