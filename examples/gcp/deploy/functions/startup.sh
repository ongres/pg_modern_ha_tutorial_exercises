natIP=#IP# &&
hostName=#HOSTNAME# &&
sudo sed -i "s/ansible_ip/$natIP/g" /etc/systemd/system/etcd.service &&
sudo sed -i "s/ansible_hostname/$hostName/g" /etc/systemd/system/etcd.service &&
sudo systemctl daemon-reload &&
sudo service etcd restart