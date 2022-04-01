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

main () {
    local userpass=$(user_password_selection)
    echo $userpass
}

main