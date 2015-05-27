#!/bin/bash

echo -n "Server host: "
read -e HOST
echo -n "Server IP: "
read -e SERVERIP
echo -n "Desired SSH Port: "
read -e SSHPORT
echo -n "Desired Username: "
read -e USERNAME
echo -n "Temporary root password: "
read -e ROOTPASS
echo -n "How much memory (64, 128, 256, 512, 1024, 2048): "
read -e MEMORY

ssh-keygen -t rsa -N '' -f ~/.ssh/$HOST
cat >> ~/.ssh/config <<END

Host $HOST
  HostName $SERVERIP
  Port $SSHPORT
  User $USERNAME
  IdentityFile ~/.ssh/$HOST
END
ssh-keyscan $SERVERIP >> ~/.ssh/known_hosts
PUBKEY=`cat ~/.ssh/$HOST.pub`
sshpass -p "$ROOTPASS" ssh root@$SERVERIP -t "bash -l -c 'wget --no-check-certificate -O /usr/bin/setup https://raw.githubusercontent.com/abstracthat/server-setup/master/setup-wheezy.sh; chmod +x /usr/bin/setup; setup new \"$PUBKEY\" \"$USERNAME\" \"$SSHPORT\" \"$MEMORY\"'"