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
