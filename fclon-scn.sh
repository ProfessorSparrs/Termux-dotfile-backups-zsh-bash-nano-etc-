#!/data/data/com.termux/files/usr/bin/bash
# prompt for the directory to scan
read -p "Enter the directory to scan for duplicates: " directory

# prompt whether to display the progress
read -p "Do you want to display the progress? (y/n) " display_progress

# count the number of duplicates
duplicates=$(fclones $directory | wc -l)

if [[ $display_progress == "y" ]]; then
    # get the number of files in the directory
    total_files=$(find $directory -type f | wc -l)
    echo "Scanning $total_files files in $directory..."

    # set the initial count of scanned files
    scanned_files=0

    # run fclones and display the progress
    fclones $directory | while read line; do
        # increment the count of scanned files
        scanned_files=$((scanned_files + 1))

        # calculate the progress in percentage
        progress=$(((scanned_files * 100) / total_files))

        # display the progress
        echo -ne "Progress: $progress%\r"
    done
    echo -ne "\n"
else
    # run fclones without displaying the progress
    fclones $directory
fi

# display the number of duplicates found
echo "Number of duplicates found: $duplicates"
