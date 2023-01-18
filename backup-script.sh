#!/usr/bin/env python
import os

# Oh joy, another backup script. Because manually copying important files is just way too much work.
# I'm sure this script will never fail and will be completely reliable.

# First, let's ask the user if they want to customize the schedule. Because the default schedule of daily backups at 2:00am isn't good enough.
customize_schedule = input("Do you want to customize the schedule for the backups? [y/N] ")

# If the user wants to customize the schedule, prompt them for the schedule. Because who doesn't love spending time configuring backup schedules?
if customize_schedule == "y":
    schedule = input("Enter the schedule for the backups in Cron format (e.g. 0 2 * * * for daily backups at 2:00am): ")
else:
    # Use a default schedule of daily backups at 2:00am. Like I said, the default is never good enough.
    schedule = "0 2 * * *"

# Now we can use Cron to schedule the backups. Because nothing says "reliability" like relying on a tool that's been around since the 1970s.
print(f"Installing the backup schedule in Cron: {schedule}")
os.system(f"echo '{schedule} ~/backup-script.sh' | crontab -")

# Let's also ask the user if they want to be notified before the backups start. Because who doesn't love being woken up at 2:00am by a notification that a backup is about to start?
notify = input("Do you want to be notified before the backups start? [y/N] ")

# If the user wants to be notified, write a script to send the notification. Because nothing says "professional" like using "wall" to send notifications.
if notify == "y":
    with open("~/.backup-notify.sh", "w") as notify_file:
        notify_file.write('''#!/bin/bash
echo "Backup is about to start!" | wall''')
    os.system("chmod +x ~/.backup-notify.sh")
    os.system("echo '* * * * * /home/$USER/.backup-notify.sh' | crontab -")

# Now we can write the script that performs the backups. Because nothing says "elegance" like using a bunch of Unix commands strung together in a script.
with open("~/backup-script.sh", "w") as backup_file:
    backup_file.write('''#!/bin/bash
tar czf /tmp/config-backup.tar.gz /etc ~/.bashrc ~/.bash_aliases ~/.inputrc ~/.gitconfig ~/.vimrc ~/.tmux.conf ~/.config
cp /tmp/config-backup.tar.gz /path/to/backup/location/
rm /tmp/config-backup.tar.gz
echo "Backup complete!"''')
os.system("chmod +x /path/to/backup-script.sh")

# Automatic backups are now configured. Time to sit back and watch the magic happen.
print("Automatic backups are now configured!")
