# docker-mldonkey
MLdonkey docker with BT, emule, UI, Kad and HTTP ports open. Based on cheungpat's work.

Uses stretch package(version 3.1.5-3) instead of older wheezy(version 3.1.2-1)

Modified with my preferred ports:
- edonkey:		20562/tcp 20566/udp
- Overnet:		6209/both
- Kad:			16965/udp
- Bittorrent:	3617/udp 6881/tcp 6882/tcp
- Admin:		4001/tcp

Also uses three volumes, first one for config files, second one for temp files while downloading and third one for completed downloaded files.
- /var/lib/mldonkey
- /mnt/mldonkey_tmp
- /mnt/mldonkey_completed

Will also setup lots of basic and some advanced stuff, change to your liking via web upon startup

---------------------------------------------------------
-STILL UNDER DEVELOPMENT, USE AT YOUR OWN RISK!!!!!!!!!!-
---------------------------------------------------------