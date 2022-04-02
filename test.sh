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

main () {

    local rootpass=$(main_password_selection)
    echo $rootpass

}

main