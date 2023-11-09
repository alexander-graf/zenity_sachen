#!/bin/bash

# Install zenity if not available
if ! command -v zenity &> /dev/null
then
    echo "Zenity could not be found, attempting to install..."
    sudo apt-get install zenity -y
fi

app_name=$(zenity --entry --title="Application Name" --text="Enter the name of your application:")

app_comment=$(zenity --entry --title="Application Comment" --text="Enter the comment for your application:")

app_exec=$(zenity --file-selection --title="Choose the application executable")

app_icon=$(zenity --file-selection --title="Choose an icon")

app_categories=$(zenity --entry --title="Application Categories" --text="Enter the categories for your application (separate multiple categories with a semicolon):")

cat << EOF > ~/.local/share/applications/${app_name// /_}.desktop
[Desktop Entry]
Version=1.0
Name=$app_name
Comment=$app_comment
Exec=$app_exec
Icon=$app_icon
Terminal=false
Type=Application
Categories=$app_categories
EOF

zenity --info --text="Desktop entry created for $app_name"
