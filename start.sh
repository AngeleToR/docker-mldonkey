#!/bin/sh

if [ ! -f /var/lib/mldonkey/downloads.ini ]; then
    userdel -f mldonkey
    groupdel mldonkey
    groupadd -g 2001 mldonkey
    useradd -M -u 2001 -g 2001 mldonkey
    mldonkey &
    echo "Waiting for mldonkey to start..."
    sleep 5
    /usr/lib/mldonkey/mldonkey_command -p "" "set run_as_user mldonkey" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set allowed_ips 0.0.0.0/0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "share 0 /mnt/mldonkey_completed/files incoming_files" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "share 0 /mnt/mldonkey_completed/directories incoming_directories" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "unshare shared" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "unshare incoming/files" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "unshare incoming/directories" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_overnet true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_kademlia true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_bittorrent true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-connect_only_preferred_server true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set client_name $MLDONKEY_CLIENT_NAME" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_hard_upload_rate 100" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_hard_download_rate 0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set temp_directory /mnt/mldonkey_tmp" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-max_connected_servers 4" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-firewalled-mode false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-port 20562" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set BT-client_port 6882" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set BT-tracker_port 6881" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set BT-dht_port 3617" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set gui_port 4000" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set telnet_port 3999" "save"
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
    
    # Overnet & Kad ports can't be changed from the command, too bad mldonkey!!!!
    # First port is for overnet, second for kad, then we leave all the same
    sed -i '0,/   port =/s/   port =.*/  port = 6209/' /var/lib/mldonkey/donkey.ini
    sed -i '0,/   port =/s/   port =.*/  port = 16965/' /var/lib/mldonkey/donkey.ini
    sed -i 's/  port =/   port =/' /var/lib/mldonkey/donkey.ini

fi


chown -R mldonkey:mldonkey /var/lib/mldonkey
chown -R mldonkey:mldonkey /mnt/mldonkey_completed
chown -R mldonkey:mldonkey /mnt/mldonkey_tmp

mldonkey
