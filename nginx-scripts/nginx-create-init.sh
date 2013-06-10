if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# kill currently running nginx if it is
pid_file="/usr/local/nginx/logs/nginx.pid"
if [ -e "$pid_file" ]
then
  sudo kill `cat /usr/local/nginx/logs/nginx.pid`
fi

exit

# copy and load the boot script
sudo cp nginx /etc/init.d/
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults

# start nginx
sudo /etc/init.d/nginx start

