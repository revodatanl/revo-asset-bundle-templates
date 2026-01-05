# Set correct shell for any OS.

set shell := ["bash", "-cu"]

# Set just variables.

PROFILE_NAME := "default"

# This imports GIT bash from user specific location.

import? "just/justfile.local"

# Just submodules

import "just/setup.justfile"
import "just/git.justfile"
import "just/ci.justfile"
import "just/dab.justfile"
import "just/justtools.justfile"

# Generic recipe to print/echo a message with cross platform compatibility.
@print msg:
	printf "{{msg}}"
alias p := print
alias e := print
alias echo := print
alias write := print
alias write-host := print
alias write-output := print
