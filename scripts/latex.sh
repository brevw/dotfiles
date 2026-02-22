#!/bin/zsh

# Get Resolution Dynamically
RESOLUTION=$(system_profiler SPDisplaysDataType | grep Resolution | awk '{print $2, $4}')
RESOLUTION=$(echo $RESOLUTION | cut -d 'x' -f 1)
WIDTH=$(echo $RESOLUTION | cut -d ' ' -f 1)
HEIGHT=$(echo $RESOLUTION | cut -d ' ' -f 2)

# fix resolution scale
WIDTH=$(($WIDTH / 2))
HEIGHT=$(($HEIGHT / 2))
HALF_WIDTH=$(($WIDTH / 2))

# Variables
TEMPLATE_PATH="$HOME/dotfiles/scripts/template.tex" # Adjust the path (handles spaces)
DEST_DIR=$(pwd) # Current directory
FILE_NAME=$(find . -maxdepth 1 -type f -name "*.tex" | head -n 1)
FILE_NAME=$(basename "$FILE_NAME")
FILE_NAME="${FILE_NAME%.*}"

# File paths
TEX_FILE="$DEST_DIR/$FILE_NAME.tex"
PDF_FILE="$DEST_DIR/$FILE_NAME.pdf"


# Clear Terminal
clear
echo "$WIDTH x $HEIGHT"

# Prompt Options
cat <<EOF
 _       ____  ______    ___  __ __      ______   ___    ___   _      _____
| T     /    T|      T  /  _]|  T  T    |      T /   \  /   \ | T    / ___/
| |    Y  o  ||      | /  [_ |  |  |    |      |Y     YY     Y| |   (   \_
| l___ |     |l_j  l_jY    _]l_   _j    l_j  l_j|  O  ||  O  || l___ \__  T
|     T|  _  |  |  |  |   [_ |     |      |  |  |     ||     ||     T/  \ |
|     ||  |  |  |  |  |     T|  |  |      |  |  l     !l     !|     |\    |
l_____jl__j__j  l__j  l_____j|__j__|      l__j   \___/  \___/ l_____j \___j

Select from the following options:
0. Open LaTeX project in Neovim
1. Create LaTeX project
2. Create LaTeX project and open in Neovim
3. Delete Build Files
4. Compile LaTeX project
5. Exit
EOF

echo
echo -n "Enter option: "
read option

# Handle options
if [ "$option" = "0" ]; then
    if [ -z "$FILE_NAME" ]; then
        echo "No .tex files found in the current directory."
    else
        latexmk -pdf -output-directory="$DEST_DIR" "$TEX_FILE" > /dev/null 2>&1
        open -a Skim "$PDF_FILE"
        osascript <<EOF
tell application "iTerm"
    activate
    set bounds of front window to {0, 0, $HALF_WIDTH, $HEIGHT} -- Adjust for left half
end tell

tell application "Skim"
    activate
    set bounds of front window to {$HALF_WIDTH, 0, 1500, $HEIGHT} -- Adjust for right half
end tell
EOF
        nvim "$TEX_FILE"
    fi
elif [ "$option" = "1" ]; then
    echo -n "Enter the name of the LaTeX project (without .tex): "
    read -r FILE_NAME
    # upadete paths
    TEX_FILE="$DEST_DIR/$FILE_NAME.tex"
    PDF_FILE="$DEST_DIR/$FILE_NAME.pdf"
    echo "Creating LaTeX project and compiling..."
    cp "$TEMPLATE_PATH" "$TEX_FILE" || { echo "Error: Failed to copy template."; exit 1; }
    latexmk -pdf -output-directory="$DEST_DIR" "$TEX_FILE" || { echo "Error: Failed to compile LaTeX."; exit 1; }
elif [ "$option" = "2" ]; then
    echo -n "Enter the name of the LaTeX project (without .tex): "
    read -r FILE_NAME
    # upadete paths
    TEX_FILE="$DEST_DIR/$FILE_NAME.tex"
    PDF_FILE="$DEST_DIR/$FILE_NAME.pdf"
    echo "Creating LaTeX project and opening in Neovim..."
    cp "$TEMPLATE_PATH" "$TEX_FILE" || { echo "Error: Failed to copy template."; exit 1; }
    latexmk -pdf -output-directory="$DEST_DIR" "$TEX_FILE" || { echo "Error: Failed to compile LaTeX."; exit 1; }
    open -a Skim "$PDF_FILE"
    osascript <<EOF
tell application "iTerm"
    activate
    set bounds of front window to {0, 0, $HALF_WIDTH, $HEIGHT} -- Adjust for left half
end tell

tell application "Skim"
    activate
    set bounds of front window to {$HALF_WIDTH, 0, 1500, $HEIGHT} -- Adjust for right half
end tell
EOF
    nvim "$TEX_FILE"

elif [ "$option" = "3" ]; then
    echo "Deleting build files..."
    # Define the list of extensions to delete
    EXTENSIONS=("aux" "log" "toc" "out" "fls" "fdb_latexmk" "synctex.gz" "bbl" "blg")
    # Check if a file was found
    if [ -z "$FILE_NAME" ]; then
        echo "No build files found in the current directory."
    else
        # Extract just the file name (without path)
        for ext in "${EXTENSIONS[@]}"; do
            if [ -f "${FILE_NAME}.${ext}" ]; then
                echo "Deleting ${FILE_NAME}.${ext}"
                rm "${FILE_NAME}.${ext}"
            fi
        done
    fi
    exit 0
elif [ "$option" = "4" ]; then
    echo "Compiling LaTeX project..."
    latexmk -pdf -output-directory="$DEST_DIR" "$TEX_FILE" || { echo "Error: Failed to compile LaTeX."; exit 1; }
    exit 0
elif [ "$option" = "5" ]; then
    echo "Exiting..."
    exit 0
else
    echo "Invalid option. Exiting..."
    exit 1
fi

exit 0



# Open the LaTeX file in Neovim
nvim "$TEX_FILE"
