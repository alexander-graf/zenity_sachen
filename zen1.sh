#!/bin/bash

# Install zenity if not available
if ! command -v zenity &> /dev/null
then
    echo "Zenity could not be found, attempting to install..."
    sudo apt-get install zenity -y
fi

echo "Enter the name of your application:"
read app_name

echo "Enter the comment for your application:"
read app_comment

# Use zenity to open a file chooser dialog for the application executable
app_exec=$(zenity --file-selection --title="Choose the application executable")

# Use zenity to open a file chooser dialog for the application icon
app_icon=$(zenity --file-selection --title="Choose an icon")

echo "Enter the categories for your application (separate multiple categories with a semicolon):"
read app_categories

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

echo "Desktop entry created for $app_name"
