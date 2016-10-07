#!/bin/bash

TTV_URL="$1"

if [[ -n "$TTV_URL" ]]; then
    sed -i "s^url = ''^url = '$1'^" /home/tv/aceproxy-master/plugins/config/torrenttv.py
    echo "Paste this URL into your player"
    echo "http://host_ip:8000/torrenttv/torrenttv.m3u"
    echo "where host_ip is your docker host ip address"
fi

sed -i 's/vlcuse = False/vlcuse = True/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videoobey = True/videoobey = False/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videopausedelay = .*/videopausedelay = 0/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videodelay = .*/videodelay = 0/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videodestroydelay = .*/videodestroydelay = 30/' /home/tv/aceproxy-master/aceconfig.py

exec /usr/bin/supervisord
