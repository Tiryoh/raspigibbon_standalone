# raspigibbon_standalone

Scripts for Raspberry Pi Gibbon to run standalone

## Requirements

requires the followings to run:

* Raspberry Pi Gibbon
* [raspigibbon_driver_installer](https://github.com/Tiryoh/raspigibbon_driver_installer)
  * put it in your home directory

## Installation

First, git clone this repository.
```
git clone https://github.com/Tiryoh/raspigibbon_standalone.git
```

Next, add `standalone.sh` to `/etc/rc.local`.  
We need to specify the full path, like `/home/ubuntu/raspigibbon_standalone/standalone.sh`.  
e.g.)
```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

/home/ubuntu/raspigibbon_standalone/standalone.sh &

exit 0
```


## Usage

Checkout this video!

YouTube : [https://youtu.be/Mjsz_MIMm64](https://youtu.be/Mjsz_MIMm64)


## License

This repository is licensed under the MIT license, see [LICENSE](./LICENSE).

Unless attributed otherwise, everything is under the MIT license.


