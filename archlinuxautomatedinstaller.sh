#!/bin/bash

# Made by Cy#0730
# Licensed under GPL-3.0

# Staring preperations
clear

# Selecting the Keyboard Layout
keyboard_layout_selection () {
    PS3='Please choose your Keyboard Layout: '
    layouts=("us" "uk" "trq")
    select fav in "${layouts[@]}"; do
        echo $fav && break
        #echo "KEYMAP=$fav" > /mnt/etc/vconsole.conf
    done
}

# Selecting the locale
locale_selection () {
    PS3='Please choose your Locale: '
    layouts=("en_US" "en_GB")
    select fav in "${layouts[@]}"; do
        echo $fav && break
        #echo "$fav.UTF-8 UTF-8"  > /mnt/etc/locale.gen
        #echo "LANG=$fav.UTF-8" > /mnt/etc/locale.conf
    done
}

# Selecting the Hostname
hostname_selection () {
    read -r -p "Please enter the Hostname you'd like for this Instance of Arch Linux: " name
    if [ -z "$name" ]; then
        print "Error! Did not receive a Hostname! Please enter a Hostname for this instance of Arch linux!"
        hostname_selection
    fi
    echo $name
    #echo "$name" > /mnt/etc/hostname
}

# Selecting the main/root password (Thanks easy-arch!)
main_password_selection () {
    while true; do
        read -r -p "Please enter the Root Pasword you'd like for this instance of Arch Linux: " mainpass
	    while [ -z "$mainpass" ]; do
            echo
            echo "You need to enter a Root password."
            read -r -p "Please enter a Root Password: " mainpass
            [ -n "$mainpass" ] && break
	    done
        echo
        read -r -p "Please enter the Root Password again: " mainpass2
        echo
        [ "$mainpass" = "$mainpass2" ] && echo $mainpass && break
        echo "The passwords do not match! Please try again!"
    done
}

# Selecting the Desktop Environment
dekstop_environment_selection () {
    PS3="Please select the Desktop Environment you'd like to use: "
    des=("kde" "gnome" "none")
    select fav in "${des[@]}"; do
        echo $fav && break
        #echo "KEYMAP=$fav" > /mnt/etc/vconsole.conf
    done
}

# Selecting a Username to create a User
username_selection () {
    read -r -p "Please enter the Username you'd like: " user
    if [ -z "$user" ]; then
        print "Error! Did not receive a Username! Please enter a Username to create a user!"
        username_selection
    fi

    echo $user
}

# Selecting the user password (Thanks easy-arch!)
user_password_selection () {
    while true; do
        read -r -p "Please enter the User Pasword you'd like for your User: " userpass
	    while [ -z "$userpass" ]; do
            echo
            echo "You need to enter a User password."
            read -r -p "Please enter a User Password: " userpass
            [ -n "$userpass" ] && break
	    done
        echo
        read -r -p "Please enter the User Password again: " userpass2
        echo
        [ "$userpass" = "$userpass2" ] && echo $userpass && break
        echo "The passwords do not match! Please try again!"
    done
}

# Selecting a Timezone
timezone_selection () {
    PS3="Please select a Timezone: "
    timezones=("GB" "GMT" "Custom")
    select fav in "${timezones[@]}"; do
        [ "$fav" != "Custom" ] && echo $fav && break
        read -r -p "Please enter a Custom Timezone " customtimezone
        while [ -z "$customtimezone" ]; do
            echo
            echo "You need to enter a Custom Timezone"
            read -r -p "Please enter a Custom Timezone: " customtimezone
            [ -n "$customtimezone" ] && break
        done
        echo $customtimezone && break
    done
}

# Main Function
main () {
    # Welcomes the User
    echo "Welcome to Arch Linux Automated Installer! This is a Bash Script that automates the installation of Arch Linux. First, we'll go through some options, then we'll install Arch Linux for you. Thank you for choosing Arch Linux Automated Installer!"
    echo "Please make sure you have internet connection before continuing. Either use an Ethernet connection or connect to a wireless connection using iwctl."

    sleep 5s

    echo "Begining Setup..."

    # Disk Selection
    #local diskToInstallTo=$(disk_selection)
    PS3="Please select what disk you'd like Arch Linux install to: "
    select diskToInstallTo in $(lsblk -dpnoNAME|grep -P "/dev/sd|nvme|vd");
    do
        break
    done
    echo "Installing Arch Linux to the following Disk: " $diskToInstallTo

    # Keymap Selection
    local keyMap=$(keyboard_layout_selection)
    echo "Selected the following Keymap: " $keyMap

    # Locale Selection
    local localeSelected=$(locale_selection)
    echo "Selected the following Locale: " $localeSelected

    # Hostname Selection
    local hostname=$(hostname_selection)
    echo "Selected the following Hostname: " $hostname

    # Root Password Selection
    local rootpass=$(main_password_selection)

    # Desktop Environment Selection
    local desktopenvironment=$(dekstop_environment_selection)
    echo "Selected the following Desktop Environment: " $desktopenvironment

    # Timezone Selection
    local timezone=$(timezone_selection)
    echo "Selected the following Timezone: " $timezone

    # Username Selection
    local username=$(username_selection)
    echo "Selected the following Username: " $username

    # User Password Selection
    local userpass=$(user_password_selection)

    # Confirming Installation with the User
    read -r -p "Would you like to continue with the Installation? " response
    response=${response,,}
    if [[ "$response" =~ ^(yes|y)$ ]]; then
        echo "Continuing..."
    fi

    # Confirming the User wants to wipe the selected Disk
    read -r -p "Do you understand that Disk $diskToInstallTo will be wiped and that the owner of the Script is not responsible for possible data loss? " response2
    response2=${response2,,}
    if [[ "$response2" =~ ^(yes|y)$ ]]; then
        echo "Continuing..."
    fi

    # Notifying the User that they don't have to intervine anymore
    echo "Thank you! You may now sit back and relax or go do something else while we install Arch Linux for you."
    echo "Begining Installation in 5 seconds..."

    sleep 5s

    echo "Begining Installation!"

    sleep 1s

    # Deleting existing partitions 
    echo "Deleting existing partitions..."

    umount -A --recursive /mnt

    wipefs -af "$diskToInstallTo" &>/dev/null
    sgdisk -Zo "$diskToInstallTo" &>/dev/null

    # Creating new partitions
    echo "Creating new partitions..."

    parted -s "$diskToInstallTo" -- \
        mklabel gpt \
        unit mib \
        mkpart primary 1 350 \
        mkpart primary 350 8543 \
        mkpart primary 8543 -1 \
        name 1 boot \
        name 2 swap \
        name 3 home

    partprobe "$diskToInstallTo"

    # Formatting the partitions
    echo "Formatting partitions..."

    mkfs.ext4 ${diskToInstallTo}3
    mkfs.fat -F 32 ${diskToInstallTo}1
    mkswap ${diskToInstallTo}2

    # Mounting the partitions
    echo "Mounting the partitions..."

    mount ${diskToInstallTo}3 /mnt

    mkdir -p /mnt/boot/efi
    mount ${diskToInstallTo}1 /mnt/boot/efi

    swapon ${diskToInstallTo}2

    # Installing the Base System
    echo "Installing the Base System..."

    pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager

    # Generating the fstab
    echo "Generating the File System Tab..."
    genfstab /mnt > /mnt/etc/fstab

    # Changing the Root: This does not work
    #echo "Moving into Root 'mnt'..."
    #arch-chroot /mnt

    # Setting the Timezone to the Timezone that the User selected
    echo "Setting Timezone..."
    arch-chroot /mnt ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

    # Syncing the System Clock
    arch-chroot /mnt hwclock --systohc

    # Setting the Locale to the Locale that the User selected
    arch-chroot /mnt echo "$localeSelected.UTF-8 UTF-8"  > /mnt/etc/locale.gen
    arch-chroot /mnt echo "LANG=$localeSelected.UTF-8" > /mnt/etc/locale.conf

    # Generating the Locale
    echo "Generating the Locale..."
    arch-chroot /mnt locale-gen

    # Setting the Keymap to the Keymap that the User selected
    echo "Setting the Keymap..."
    arch-chroot /mnt echo "KEYMAP=$keyMap" > /mnt/etc/vconsole.conf

    # Setting the Hostname to the Hostname that the User selected
    echo "Setting the Hostname..."
    arch-chroot /mnt echo "$hostname" > /mnt/etc/hostname

    exit

    # Setting the Root Password to the Root Password that the User selected
    echo "Setting the Root Password..."
    echo "root:$rootpass" | arch-chroot /mnt chpasswd

    # Creating a User with the Username that the User selected
    echo "Creating the User..."
    arch-chroot /mnt useradd -m -G wheel -s /bin/bash ${username}

    # Setting the password of the User
    echo "Setting the User Password..."
    echo "$username:$userpass" | arch-chroot /mnt chpasswd

    # Adding the User Group 'wheel' to the sudoers list
    echo "Adding the User Group 'wheel' to the sudoers list..."
    sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /mnt/etc/sudoers

    # Enabling Services/Daemons
    echo "Enabling Services/Daemons..."
    arch-chroot /mnt systemctl enable NetworkManager

    # Setting up Grub
    echo "Setting up Grub..."
    arch-chroot /mnt grub-install ${diskToInstallTo}
    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

    # Notifying the User that the Base Installation is complete
    #echo "The Base Installation is complete. Please wait while we install the selected Desktop Environment."

    # Switching into the User Account
    #su ${username}

    # Checking what Desktop Environment they selected and Installing it
    #if [ $desktopenvironment = "kde" ]; then
        #sudo pacman -S plasma sddm konsole kate dolphin firefox
        #sudo systemctl enable sddm
    #fi

    #if [ $desktopenvironment = "gnome" ]; then
        #echo "Work in progress"
    #fi

    # Notifying the User that the Installation is Complete
    echo "Installation Complete! - Thank you for using Arch Linux Automated Installer!"
    echo "Please eject the Installation Media, then restart your Instance of Arch Linux."

}

# Calling the Main function
main