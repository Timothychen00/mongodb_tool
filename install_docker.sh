open -a docker 
if [ $? -eq 1 ]
then
    echo "docker not found"
    while true; do
        read -p "Do you wish to install this program? [y/n]" yn
        case $yn in
        
            [Yy]* ) brew install docker;  break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi