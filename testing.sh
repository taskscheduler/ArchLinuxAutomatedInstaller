test () {
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

main () {
    local rootpass=$(test)
    echo $rootpass
}

main