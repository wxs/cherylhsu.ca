#!/bin/bash

# This script copies over files from the Obsidian vault into the appropriate directories of the hugo site,
# then performs a git commit and push to the remote repository (which should trigger a rebuild if webhooks are set up)


set -e

cd "$(dirname "$0")"

# Hard-coded (sorry) on X's machine: ~/Documents/Obsidian/cherylhsu.ca. On Cheryl's machine ~/Documents/cherylhsu.ca.
# Look for X's first, then Cheryl's to set the vault directory (I'm trying to make this as simple as double-clicking for
# Cheryl which is why I'm hard-coding things)


if [ -d ~/Documents/Obsidian/cherylhsu.ca ]; then
    vault_dir=~/Documents/Obsidian/cherylhsu.ca
elif [ -d ~/Documents/cherylhsu.ca ]; then
    vault_dir=~/Documents/cherylhsu.ca
else
    echo "Vault directory not found. Please check the script and try again."
    exit 1
fi

# Now rsync the vault's pages directory into content/pages, the images directory into static/images and the post
# directory into content/post. The rsync command is set to delete files in the destination that are not in the source

rsync -av --delete $vault_dir/pages/ content/pages/
rsync -av --delete $vault_dir/post/ content/post/
rsync -av --delete $vault_dir/images/ static/images/

# Now commit and push the changes to the remote repository

git add content static
git commit -m "Syncing Obsidian vault"
git push

# Now open the site in the browser
open http://cherylhsu.ca



