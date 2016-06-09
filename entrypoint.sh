#!/bin/sh

if [ ! -f /var/lib/mldonkey/downloads.ini ]; then
    mldonkey &
    echo "Waiting for mldonkey to start..."
    sleep 5
    /usr/lib/mldonkey/mldonkey_command -p "" "set allowed_ips 0.0.0.0/0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "share /mnt/mldonkey_completed incoming_files" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "share /mnt/mldonkey_completed incoming_directories" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set temp_directory /mnt/mldonkey_tmp" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_connected_servers 4" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set firewalled_mode false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set port 20562" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set overnet_port 6209" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set Kademlia_port 16965" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set BT-client_port 6881" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set BT-tracker_port 6882" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set BT-dht_port 3617" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_concurrent_downloads 150" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set filenames_utf8 true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_file_mode 664" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_dir_mode 775" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_file_sparse true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd server.met http://sites.google.com/site/ircemulespanish/descargas-2/server.met?attredirects=0&d=1" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd guarding.p2p http://sites.google.com/site/ircemulespanish/descargas-2/ipfilter.zip" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd geoip.dat http://www.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd hublist http://dchublist.com/hublist.config.bz2" "save"
    if [ -z "$MLDONKEY_ADMIN_PASSWORD" ]; then
        /usr/lib/mldonkey/mldonkey_command -p "" "kill"
    else
        /usr/lib/mldonkey/mldonkey_command -p "" "useradd admin $MLDONKEY_ADMIN_PASSWORD"
        /usr/lib/mldonkey/mldonkey_command -u admin -p "$MLDONKEY_ADMIN_PASSWORD" "kill"
    fi
fi

mldonkey
