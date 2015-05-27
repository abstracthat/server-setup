Bootstrap a tiny VPS (128MB) for serving static sites. Do it well and do it fast.

This is a custom fork of Keith's script. I've made my changes as minimal as possible so that it will be easier to keep it up to date with his changes.

## Differences from Original
The main difference is the addition of the "new" command which is my personal prefence for setting up a new static site web server. The command cleans up your system and installs nginx.

I've replaced dropbear/xinetd with sshd as it's easier to configure and the performance is nearly the same.

The other big change is that the user you add gets sudo priveleges with no password and is setup for key-based login only. I also disable root login, so the only way to get into the box after this script is done is with your rsa key.

The other commands should still work as expected but I have not tested them all.

## Easy Setup From Your Local Command Line
To make setup a breeze you can just run the handy `server.sh` script. This will ask you a few questions (server name, ip, password, desired port, username, memory) and get your server running with no further input.

```bash
bash server.sh
```

You will now have the `setup` command available on your server.

### Dependencies
This script assumes you have a `~/.ssh` folder and `~/.ssh/config` file for storing host configs. This enables you to simply `ssh yourhost` instead of having to type the port, user, and IP.

You also need sshpass. To install on OSX you can run:

```bash
curl -O -L http://downloads.sourceforge.net/project/sshpass/sshpass/1.05/sshpass-1.05.tar.gz && tar xvzf sshpass-1.05.tar.gz
cd sshpass-1.05
./configure
make
sudo make install
```

## Server Recommendation
Make sure to run this on a fresh Debian 7 Wheezy (32-bit) install... the regular version, not the "minimal" version.

I recommend [RamNode](https://clientarea.ramnode.com/aff.php?aff=2536) for a surprisingly cheap and insanely fast SSD based VPS. That's an affiliate link and I appreciate you using it. Thanks! :)

## Setting Up a Site
To install a domain ssh into your VPS, `ssh hostname`. Run `sudo setup domain yoururl.com`. After that you should be able to just point an `A record` to the server's IP at your registrar and everything will work. You can `rsync` your files to `hostname:/var/www/yoururl.com`. So easy!

If you need email for the domain, make your life easier (and your mail more deliverable) by using an email hosting provider. I use [Namecheap](http://www.namecheap.com/?aff=16639)... it's only $9.88 per year and easy to setup (just a couple of host records at your registrar). That's an affiliate link too, so thank you if you use it.
