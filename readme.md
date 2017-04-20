# a shell script to setup my BBB for when it shits the bed

sudo apt-get update
sudo apt-get install git linux-headers-generic build-essential dkms

### Kernel stuff
```
cd /opt/source/bb.org-overlays
git pull
./install.sh
cd /opt/scripts/tools/
git pull
./update_kernel.sh --lts-4_4-kernel

shutdown -r now

function wirelessFix() {
	# SRC: https://github.com/pvaret/rtl8192cu-fixes
	# get the kernel version via uname -r
	version=$(uname -r)
	apt-get install git linux-headers-${version} build-essential dkms
	git clone https://github.com/pvaret/rtl8192cu-fixes.git
	dkms add ./rtl8192cu-fixes
	dkms install 8192cu/1.10
	depmod -a
	cp ./rtl8192cu-fixes/blacklist-native-rtl8192.conf /etc/modprobe.d/
	cp ./rtl8192cu-fixes/8192cu-disable-power-management.conf /etc/modprobe.d/
}
wirelessFix

shutdown -r now

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd ~/workspace
git clone https://github.com/jgtaylor/intellistrip.git
cd intellistrip
npm install
```

### get wireless working
```
connmanctl
enable wifi
agent on
connect wifi_e84e0626e064_hidden_managed_psk
<enter SSID and password>
```
