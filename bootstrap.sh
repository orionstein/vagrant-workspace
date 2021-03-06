#!/bin/sh

sudo su
lvresize -l +100%FREE /dev/vagrant-vg/root
resize2fs /dev/vagrant-vg/root
apt-get update
apt-get install putty-tools
rm /home/vagrant/$1
rm /home/vagrant/$1.pub
ssh-keygen -b 1024 -f $1 -t dsa -N ''
cp /home/vagrant/$1 /vagrant/keys
puttygen /home/vagrant/$1 -O private -o /vagrant/keys/$1.ppk
useradd -m -c "$1" -G sudo $1
rm -r /home/$1/.ssh
mkdir /home/$1/.ssh
chmod 700 /home/$1/.ssh
chown $1:$1 /home/$1/.ssh
cat /home/vagrant/$1.pub >> /home/$1/.ssh/authorized_keys
chmod 600 /home/$1/.ssh/authorized_keys
chown $1:$1 /home/$1/.ssh/authorized_keys
echo "$1 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ln -s /projects /home/$1/projects
chown -R $1:$1 /home/$1/projects
echo "\nhv_vmbus \nhv_storvsc \nhv_blkvsc \nhv_netvsc \n" >> /etc/initramfs-tools/modules
update-initramfs -u
su - $1
curl -sL https://deb.nodesource.com/setup_4.x | bash -
sudo rm -rf /usr/bin/docker
curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-1.8.3
sudo mv docker-1.8.3 /bin/docker
sudo chmod +x /bin/docker
sudo ln -s /bin/docker /usr/bin/docker
sudo curl -SLO https://raw.githubusercontent.com/docker/docker/master/contrib/init/systemd/docker.service
sudo mv docker.service /etc/systemd/system/docker.service
sudo curl -SLO https://raw.githubusercontent.com/docker/docker/master/contrib/init/systemd/docker.socket
sudo mv docker.socket /etc/systemd/system/docker.socket
sudo groupadd docker
sudo usermod -a -G docker $1
sudo apt-get install -y ruby zsh git vim nodejs build-essential cmake python python-dev libpython-all-dev closure-linter exuberant-ctags silversearcher-ag
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo chsh -s /usr/bin/zsh $1
sudo -H -u $1 /usr/bin/zsh -c "git clone https://github.com/orionstein/rc.git ~/.rc; cd ~/.rc/; /usr/bin/ruby install.rb;"
exit
