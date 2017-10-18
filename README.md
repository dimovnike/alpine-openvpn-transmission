An image to run transmission via VPN. Extends dimovnike/alpine-openvpn.

use with:

sudo docker run -p9091:9091 -v \</path/to/configs\>:/var/lib/transmission/  \<opnvpn options\> -d dimovnike/alpine-openvpn-transmission

If /path/to/configs is empty, it will create the new config file (config.json) and the directry layer with a downloads/ folder in it.
