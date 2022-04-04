#!/bin/bash

# Made by Cy#0730
# Licensed under GPL-3.0

# Staring preperations
clear

# Selecting the Keyboard Layout
keyboard_layout_selection () {
    PS3='Please choose your Keyboard Layout: '
    #layouts=("us" "uk" "trq")
    layouts=("ANSI-dvorak" "adnw" "amiga-de" "amiga-us" "apple-a1048-sv" "apple-a1243-sv" "apple-a1243-sv-fn-reverse" "apple-internal-0x0253-sv" "apple-internal-0x0253-sv-fn-reverse" "applkey" "atari-de" "atari-se" "atari-uk-falcon" "atari-us" "azerty" "backspace" "bashkir" "be-latin1" "bg-cp1251" "bg-cp855" "bg_bds-cp1251" "bg_bds-utf8" "bg_pho-cp1251" "bg_pho-utf8" "bone" "br-abnt" "br-abnt2" "br-latin1-abnt2" "br-latin1-us" "by" "by-cp1251" "bywin-cp1251" "ca" "carpalx" "carpalx-full" "cf" "colemak" "croat" "ctrl" "cz" "cz-cp1250" "cz-lat2" "cz-lat2-prog" "cz-qwertz" "cz-us-qwertz" "de" "de-latin1" "de-latin1-nodeadkeys" "de-mobii" "de_CH-latin1" "de_alt_UTF-8" "defkeymap defkeymap_V1.0" "dk" "dk-latin1" "dvorak" "dvorak-ca-fr" "dvorak-es" "dvorak-fr" "dvorak-l" "dvorak-la" "dvorak-no" "dvorak-programmer" "dvorak-r" "dvorak-ru" "dvorak-sv-a1" "dvorak-sv-a5" "dvorak-uk" "dvorak-ukp" "emacs" "emacs2" "es" "es-cp850" "es-olpc" "et" "et-nodeadkeys" "euro" "euro1" "euro2" "fa" "fi" "fr" "fr-bepo" "fr-bepo-latin9" "fr-latin1" "fr-latin9" "fr-pc" "fr_CH" "fr_CH-latin1" "gr" "gr-pc" "hu" "hu101" "il" "il-heb" "il-phonetic" "is-latin1" "is-latin1-us" "it" "it-ibm" "it2" "jp106" "kazakh" "keypad" "koy" "ky_alt_sh-UTF-8" "kyrgyz" "la-latin1" "lt" "lt.baltic" "lt.l4" "lv" "lv-tilde" "mac-be" "mac-de-latin1" "mac-de-latin1-nodeadkeys" "mac-de_CH" "mac-dk-latin1" "mac-dvorak" "mac-es" "mac-euro" "mac-euro2" "mac-fi-latin1" "mac-fr" "mac-fr_CH-latin1" "mac-it" "mac-no-latin1" "mac-pl" "mac-pt-latin1" "mac-se" "mac-template" "mac-uk" "mac-us" "mk" "mk-cp1251" "mk-utf" "mk0" "neo" "neoqwertz" "nl" "nl2" "no" "no-latin1" "pc110" "pl" "pl1" "pl2" "pl3" "pl4" "pt-latin1" "pt-latin9" "pt-olpc" "ro" "ro_std" "ro_win" "ru" "ru-cp1251" "ru-ms" "ru-yawerty" "ru1" "ru2" "ru3" "ru4" "ru_win" "ruwin_alt-CP1251" "ruwin_alt-KOI8-R" "ruwin_alt-UTF-8" "ruwin_alt_sh-UTF-8" "ruwin_cplk-CP1251" "ruwin_cplk-KOI8-R" "ruwin_cplk-UTF-8" "ruwin_ct_sh-CP1251" "ruwin_ct_sh-KOI8-R" "ruwin_ct_sh-UTF-8" "ruwin_ctrl-CP1251" "ruwin_ctrl-KOI8-R" "ruwin_ctrl-UTF-8" "se-fi-ir209" "se-fi-lat6" "se-ir209" "se-lat6" "sg" "sg-latin1" "sg-latin1-lk450" "sk-prog-qwerty" "sk-prog-qwertz" "sk-qwerty" "sk-qwertz" "slovene" "sr-cy" "sr-latin" "sun-pl" "sun-pl-altgraph" "sundvorak" "sunkeymap" "sunt4-es" "sunt4-fi-latin1" "sunt4-no-latin1" "sunt5-cz-us" "sunt5-de-latin1" "sunt5-es" "sunt5-fi-latin1" "sunt5-fr-latin1" "sunt5-ru" "sunt5-uk" "sunt5-us-cz" "sunt6-uk" "sv-latin1" "tj_alt-UTF8" "tr_f-latin5" "tr_q-latin5" "tralt" "trf" "trf-fgGIod" "trq" "ttwin_alt-UTF-8" "ttwin_cplk-UTF-8" "ttwin_ct_sh-UTF-8" "ttwin_ctrl-UTF-8" "ua" "ua-cp1251" "ua-utf" "ua-utf-ws" "ua-ws" "uk" "unicode" "us" "us-acentos" "us1" "wangbe" "wangbe2" "windowkeys")
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
        echo "Error! Did not receive a Hostname! Please enter a Hostname for this instance of Arch linux!"
        hostname_selection
    fi
    echo $name
    #echo "$name" > /mnt/etc/hostname
}

# Selecting the main/root password (Thanks easy-arch!)
main_password_selection () {
    while true; do
        read -r -p "Please enter the Root Password you'd like for this Instance of Arch Linux: " user
        if [ -z "$user" ]; then
            echo "Error! Did not receive a Password! Please enter a Password!"
            main_password_selection
        fi

        read -r -p "Please re-enter the Root Password you'd like for this Instance of Arch Linux: " usera
        if [ -z "$usera" ]; then
            echo "Error! Did not receive a Password! Please enter a Password!"
            main_password_selection
        fi

        if [ "$user" = "$usera" ]; then
            echo $usera && break
        fi

        echo "Error! The passwords do not match!"
        main_password_selection
    done
}

# Selecting the Desktop Environment
dekstop_environment_selection () {
    PS3="Please select the Desktop Environment you'd like to use: "
    des=("kde" "gnome" "xfce" "mate" "none")
    select fav in "${des[@]}"; do
        echo $fav && break
        #echo "KEYMAP=$fav" > /mnt/etc/vconsole.conf
    done
}

# Selecting a Username to create a User
username_selection () {
    read -r -p "Please enter the Username you'd like: " user
    if [ -z "$user" ]; then
        echo "Error! Did not receive a Username! Please enter a Username to create a user!"
        username_selection
    fi

    echo $user
}

# Selecting the user password (Thanks easy-arch!)
user_password_selection () {
    while true; do
        read -r -p "Please enter the Password you'd like for your User: " user
        if [ -z "$user" ]; then
            echo "Error! Did not receive a Password! Please enter a Password!"
            user_password_selection
        fi

        read -r -p "Please re-enter the Password you'd like for your User: " usera
        if [ -z "$usera" ]; then
            echo "Error! Did not receive a Password! Please enter a Password!"
            user_password_selection
        fi

        if [ "$user" = "$usera" ]; then
            echo $usera && break
        fi

        echo "Error! The passwords do not match!"
        user_password_selection
    done
}

# Selecting a Timezone
timezone_selection () {
    PS3="Please select a Timezone: "
    timezones=("Automatic" "GB" "GMT" "Custom")
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

# Selecting a Kernel
kernel_selection () {
    PS3="Please select a Kernel: "
    optkern=("linux" "linux-hardened" "linux-lts" "linux-zen")
    select fav in "${optkern[@]}"; do
        echo $fav && break
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
    select diskToInstallTo in $(lsblk -dpnoNAME|grep -P "/dev/sd|nvme|vd|blk");
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

    # Kernel Selection
    local selectedKern=$(kernel_selection)
    echo "Using Kernel: " $selectedKern

    # Confirming Installation with the User
    read -r -p "Would you like to continue with the Installation? (Y/n) " response
    response=${response,,}
    if [[ "$response" =~ ^(yes|y)$ ]]; then
        echo "Continuing..."
    fi

    # Confirming the User wants to wipe the selected Disk
    read -r -p "Do you understand that Disk $diskToInstallTo will be wiped and that the owner of the Script is not responsible for any data loss? (Y/n)" response2
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

    #pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager
    pacstrap /mnt base $selectedKern linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager

    # Generating the fstab
    echo "Generating the File System Tab..."
    genfstab /mnt > /mnt/etc/fstab

    # Changing the Root: This does not work
    #echo "Moving into Root 'mnt'..."
    #arch-chroot /mnt

    # Setting the Timezone to the Timezone that the User selected
    echo "Setting Timezone..."
    if [ $timezone = "Automatic" ]; then
        local autoTimezone=curl https://ipapi.co/timezone
        arch-chroot /mnt ln -sf /usr/share/zoneinfo/${autoTimezone} /etc/localtime
    fi

    if [ $timezone != "Automatic" ]; then
        arch-chroot /mnt ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime
    fi
    #arch-chroot /mnt ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

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

    # Setting the Root Password to the Root Password that the User selected
    echo "root:$rootpass" | arch-chroot /mnt chpasswd

    # Creating a User with the Username that the User selected
    echo "Creating the User..."
    arch-chroot /mnt useradd -m -G wheel -s /bin/bash ${username}

    # Setting the password of the User
    echo "$username:$userpass" | arch-chroot /mnt chpasswd

    # Adding the User Group 'wheel' to the sudoers list
    echo "Adding the User Group 'wheel' to the sudoers list..."
    arch-chroot /mnt echo "%wheel ALL=(ALL) ALL"  > /mnt/etc/sudoers

    # Enabling Services/Daemons
    echo "Enabling Services/Daemons..."
    arch-chroot /mnt systemctl enable NetworkManager

    # Setting up Grub
    echo "Setting up Grub..."
    arch-chroot /mnt grub-install ${diskToInstallTo}
    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

    # Checking what Desktop Environment they selected and Installing it (If none, notify the user of a successful installation.)
    if [ $desktopenvironment = "none" ]; then
        # Notifying the User that the Installation is Complete
        umount -a

        echo "Installation Complete! - Thank you for using Arch Linux Automated Installer!"
        echo "Please eject the Installation Media, then restart your Instance of Arch Linux."

        # Exiting
        exit
    fi
    
    if [ $desktopenvironment = "kde" ]; then
        # Notifying the User that the Base Installation is complete
        echo "The Base Installation is complete. Please wait while we install the selected Desktop Environment."
        sleep 3s

        # Installing KDE
        arch-chroot /mnt pacman -S --noconfirm plasma sddm konsole kate dolphin firefox
        arch-chroot /mnt systemctl enable sddm

        # Notifying the User that the Installation is Complete
        umount -a

        echo "Installation Complete! - Thank you for using Arch Linux Automated Installer!"
        echo "Please eject the Installation Media, then restart your Instance of Arch Linux."

        # Exiting
        exit
    fi

    if [ $desktopenvironment = "gnome" ]; then
        # Notifying the User that the Base Installation is complete
        echo "The Base Installation is complete. Please wait while we install the selected Desktop Environment."
        sleep 3s

        # Installing GNOME
        arch-chroot /mnt pacman -S --noconfirm xorg gnome gnome-extra gdm
        arch-chroot /mnt systemctl enable gdm

        # Notifying the User that the Installation is Complete
        umount -a

        echo "Installation Complete! - Thank you for using Arch Linux Automated Installer!"
        echo "Please eject the Installation Media, then restart your Instance of Arch Linux."

        # Exiting
        exit
    fi

    if [ $desktopenvironment = "xfce" ]; then
        # Notifying the User that the Base Installation is complete
        echo "The Base Installation is complete. Please wait while we install the selected Desktop Environment."
        sleep 3s

        # Installing XFCE
        arch-chroot /mnt pacman -S --noconfirm xorg xorg-xinit xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
        arch-chroot /mnt systemctl enable lightdm

        # Notifying the User that the Installation is Complete
        umount -a

        echo "Installation Complete! - Thank you for using Arch Linux Automated Installer!"
        echo "Please eject the Installation Media, then restart your Instance of Arch Linux."

        # Exiting
        exit
    fi

    if [ $desktopenvironment = "mate" ]; then
        # Notifying the User that the Base Installation is complete
        echo "The Base Installation is complete. Please wait while we install the selected Desktop Environment."
        sleep 3s

        # Installing MATE
        arch-chroot /mnt pacman -S --noconfirm xorg xorg-xinit xorg-server mate mate-extra lightdm lightdm-gtk-greeter
        arch-chroot /mnt systemctl enable lightdm

        # Notifying the User that the Installation is Complete
        umount -a

        echo "Installation Complete! - Thank you for using Arch Linux Automated Installer!"
        echo "Please eject the Installation Media, then restart your Instance of Arch Linux."

        # Exiting
        exit
    fi

}

# Calling the Main function
main