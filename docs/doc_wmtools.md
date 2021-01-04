# install_wmtools.sh

Installs tools to run virtual machines with Vagrant and Packer

## Overview

The scripts installs the current packages:
* Virtualbox
* Vagrant
* Packer

Requirements - These are installed automatically if they are not present.
* git
* syslinux-utils
* unzip
* bash-builtins

## Index

* [say-hello()](#say-hello)

### say-hello()

My super function.
Not thread-safe.

#### Example

```bash
echo "test: $(say-hello World)"
```

#### Arguments

* **$1** (string): A value to print

#### Exit codes

* **0**: If successful.
* **1**: If an empty string passed.

#### See also

* [validate()](#validate)

