#!/bin/bash

DATE=$(date +'%Y-%m-%d')
PHRASES_DIR="./src/phrases"
FILE_PATH="$PHRASES_DIR/$DATE.md"
MODEL='llama3.2-motivational'
MODEL_FILE='./Modelfile'

# Function to collect all previous phrases and return them as a string
collect_previous_phrases() {
    local N=20  # Number of recent phrases to keep
    local all_phrases=""

    if [ -d "$PHRASES_DIR" ]; then
        # List all .md files by date (sorted), get the last N
        recent_files=$(ls "$PHRASES_DIR"/*.md 2>/dev/null | sort | tail -n "$N")
        
        for file in $recent_files; do
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
echo $ALL_PREVIOUS_PHRASES

THEMES=(
  "resilience" "focus" "growth" "courage" "clarity" "momentum" "discipline" "confidence"
  "fearlessness" "transformation" "patience" "consistency" "grit" "vision" "self-worth"
  "initiative" "action" "perseverance" "adaptability" "calm" "inner fire" "strength"
  "presence" "persistence" "hope" "determination" "boldness" "recovery" "renewal"
  "purpose" "tenacity" "intention" "leadership" "self-trust"
)
RANDOM_THEME=${THEMES[$RANDOM % ${#THEMES[@]}]}


PROMPT="Write a poetic motivational phrase, rich in metaphor, fresh in tone, and under 25 words. Wrap it in quotes.\n\n"
PROMPT+="Today's theme is: $RANDOM_THEME.\n\n"
PROMPT+="Try to avoid repeating the same phrases as before:\n"
PROMPT+="$ALL_PREVIOUS_PHRASES"

echo '[INFO] Generating new phrase...'
echo "$PROMPT"

RAW_OUTPUT=$(ollama run $MODEL "$PROMPT")

# Extract only the content between the first pair of double quotes
PHRASE=$(echo "$RAW_OUTPUT" | grep -o '".\{1,\}"' | head -n 1)

# If nothing is found, fall back to raw output (as a safety net)
if [ -z "$PHRASE" ]; then
    PHRASE="$RAW_OUTPUT"
fi

# Save final phrase to the file
echo "$PHRASE" > "$FILE_PATH"
