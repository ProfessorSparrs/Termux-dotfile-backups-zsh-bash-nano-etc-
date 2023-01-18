#!/data/data/com.termux/files/usr/bin/bash
# Corrected function to display the menu
# This function creates a dialog menu with given choices, title and prompt.
# It takes an additional argument which is the number of options in the menu
display_menu() {
    local choices=$1
    local title=$2
    local prompt=$3
    local n_options=$4
    local choice
    while true; do
    	  clear
        choice=$(echo "$choices" | dialog --clear --stdout --backtitle "$title" --menu "$prompt" $n_options 0 0)
        if [ "$choice" != "" ]; then
            break
        fi
    done
    echo "$choice"
}

# Function to display the file selection dialog for selecting a folder
# This function creates a file selection dialog with given title and prompt.
select_files() {
    local title=$1
    local prompt=$2
    local file
    while true; do
        file=$(dialog --clear --stdout --backtitle "$title" --fselect $HOME/ 0 0)
        if [ "$file" != "" ]; then
            break
        fi
    done
    echo "$file"
}

# Function to display the destination file selection dialog for selecting destination folder
# This function creates a destination file selection dialog with given title and prompt.
select_destination() {
    local title=$1
    local prompt=$2
    local file
    while true; do
        file=$(dialog --clear --stdout --backtitle "$title" --dselect $HOME/ 0 0)
        if [ "$file" != "" ]; then
            break
        fi
    done
    echo "$file"
}

# Install dialog if not already installed
apt install dialog -y

# Display main menu
while true; do
    main_choices="Sync a Folder\nQuit"
    main_title="Main Menu"
    main_prompt="Please select an option:"
    # Pass number of options to the function
    main_choice=$(display_menu "$main_choices" "$main_title" "$main_prompt" 2)

    case $main_choice in
        "Sync a Folder")
            # Display file selection dialog for folder
            # This dialog allows the user to select the folder they want to sync
            sync_folder_title="Select Folder to Sync"
            sync_folder_prompt="Please select the folder you want to sync:"
            sync_folder=$(select_files "$sync_folder_title" "$sync_folder_prompt")

            # Display file selection dialog for destination folder
            # This dialog allows the user to select the destination folder where the files should be synced to
            sync_destination_title="Select Destination Folder"
            sync_destination_prompt="Please select the destination folder you want to sync to:"
            sync_destination=$(select_destination "$sync_destination_title" "$sync_destination_prompt")

            # Perform sync
            # This command syncs the selected folder and destination folder using the rsync command with the -av options
            rsync -av "$sync_folder" "$sync_destination"
            echo "Folder $sync_folder has been synced to $sync_destination"
            ;;

        "Quit")
            break
            ;;
    esac
done
