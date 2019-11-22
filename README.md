# docker-mldonkey
MLdonkey docker with BT, emule, UI, Kad and HTTP ports open. Based on cheungpat's work.

Uses Debian stretch package(version 3.1.5-3) instead of older wheezy(version 3.1.2-1)

Modified with my preferred ports:
- edonkey:		20562/tcp 20566/udp
- Overnet:		6209/both
- Kad:			16965/udp
- Bittorrent:	3617/udp 6881/tcp 6882/tcp
- Admin:		4000/tcp 4080/tcp

WARNING!!! If you change these ports in the EXPORT you will later on have to change them in MLDonkey, via telnet, editing its .ini files or whatever means you prefer

Also uses three volumes, first one for config files, second one for temp files while downloading and third one for completed downloaded files.
- /var/lib/mldonkey
- /mnt/mldonkey_tmp
- /mnt/mldonkey_completed

Will also setup lots of basic and some advanced stuff, change to your liking via web upon startup. Inside the docker container it deletes any existing mldonkey user/group and creates a new one with uid&gid 2001 to match my system.

## Command
### build docker image:
```bash
docker build  -t mldonkey .
```

### Run the docker
```bash
docker run -it -d --rm --name mldonkey \
  -p 20562:20562/tcp  -p 20566:20566/udp \
  -p 6209:6209/tcp  -p 6209:6209/udp \
  -p 16965:16965/udp \
  -p 3617:3617/udp  -p 6881:6881/tcp -p 6882:6882/tcp \
  -p localhost:4000:4000/tcp -p localhost:4080:4080 \
  -v ${PWD}/mldonkey_completed:/mnt/mldonkey_completed  \
  -v ${PWD}/mldonkey_tmp:/mnt/mldonkey_tmp \
  -v ${PWD}/config:/var/lib/mldonkey \
  mldonkey
```

You can visit the web admin interface in http://localhost:4080 .

