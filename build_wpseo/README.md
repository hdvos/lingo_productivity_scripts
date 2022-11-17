## "Installation"

* Put `build_wpseo.config` anywhere you like.
* In `build_wpseo.config` change the paths to where your wpseo and wpseo-premium are located.

* In `build_wpseo.sh` on `line 5`: change this to `. /Wherever/you/saved/the/config/file/build_wpseo.config;`
* Move `build_wpseo.sh` to a folder that is in your `PATH` variable. For example `/usr/local/bin`.

* Now you can call `sh build_wpseo.sh` from anywhere.


## Usage

* `sh build_wpseo.sh` will build free.
* `sh build_wpseo.sh -q` (`-q` = quick) will only build js: `grunt build:js`
* `sh build_wpseo.sh -p` (`-p` = premium) will build premium.
* `sh build_wpseo.sh -p -q` will only build js in premium.
* `sh build_wpseo.sh -p -r some-free-branch` (`-r` = require) will require a branch and build premium.

## Future
Will add more/better things in the future. E.g. also for woo etc.
