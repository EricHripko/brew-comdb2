# brew-comdb2
https://brew.sh/ formula that installs the latest version of COMDB2. This will be merged to the official repository once COMDB2 has a first stable public release. For now, run the following to get COMDB2 installed:
```
$ brew install https://raw.githubusercontent.com/EricHripko/brew-comdb2/master/comdb2.rb
```
All the COMDB2 executables will be available in `$PATH`. The database files can be found in `/usr/local/var/cdb2/` whereas logs are placed in `/usr/local/var/log/cdb2/`.  
You can also test if COMDB2 was installed successfully by running `brew test comdb2`.
