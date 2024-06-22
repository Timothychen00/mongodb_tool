function install(){
    cd ~/Downloads
    curl  "https://downloads.mongodb.com/compass/mongodb-compass-1.43.1-darwin-arm64.dmg" >> a.dmg

    # mount image
    hdiutil attach a.dmg

    # copy app, remove old version first if installed
    if [[ -d "/Applications/MongoDB Compass.app" ]]; then
        sudo rm -rf "/Applications/MongoDB Compass.app"
    fi
    sudo cp -r "/Volumes/MongoDB Compass/MongoDB Compass.app" "/Applications/MongoDB Compass.app"

    # unmount and remove image
    hdiutil detach "/Volumes/MongoDB Compass"
    mv a.dmg ~/.Trash/
}

echo "install.sh"
open -a "MongoDB Compass" --args mongodb://localhost:27017 
a=$?
if [ $a -eq 1 ]
then 
    echo "MongoDB Compass not found"
    while true; do
        read -p "Do you wish to install this program? [y/n]" yn
        case $yn in
            [Yy]* ) install;  break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi


