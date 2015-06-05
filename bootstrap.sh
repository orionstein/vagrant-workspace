#!/bin/sh

sudo su
apt-get update
apt-get install putty-tools
rm /home/vagrant/$1
rm /home/vagrant/$1.pub
ssh-keygen -b 1024 -f $1 -t dsa -N ''
cp /home/vagrant/$1 /vagrant
puttygen /home/vagrant/$1 -O private -o /vagrant/$1.ppk
useradd -m -c "$1" -G sudo $1
rm -r /home/$1/.ssh
mkdir /home/$1/.ssh
chmod 700 /home/$1/.ssh
chown $1:$1 /home/$1/.ssh
cat /home/vagrant/$1.pub >> /home/$1/.ssh/authorized_keys
chmod 600 /home/$1/.ssh/authorized_keys
chown $1:$1 /home/$1/.ssh/authorized_keys
chown $1:$1 /projects
ln -s /projects /home/$1/projects
su - $1
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y ruby zsh git vim nodejs build-essential cmake python python-dev libpython-all-dev exuberant-ctags
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo chsh -s /usr/bin/zsh $1
sudo -H -u $1 /usr/bin/zsh -c "git clone https://github.com/orionstein/rc.git ~/.rc; cd ~/.rc/; /usr/bin/ruby install.rb;"
exit