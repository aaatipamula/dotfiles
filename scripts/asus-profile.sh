#!/bin/bash

set -e

profile=$(asusctl profile list | vicinae dmenu --placeholder "Set Profile")

if [[ -z "$profile" ]]; then
  echo "No profile selected."
else
  asusctl profile set "$profile"
  echo "Profile set to $profile"
fi
