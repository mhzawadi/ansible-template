# ansible-template
My Ansible setup, without all my configs. I hope

## Start here

```
echo -e "\x1b[0;31mYou need an environment setup...\x1b[0m"
python3.10 -m venv .venv
source .venv/bin/activate
python3.10 -m pip install --upgrade pip
python3.10 -m pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
echo -e "\x1b[0;33mthere, its all done\x1b[0m"

alias testing='$(git rev-parse --show-toplevel)/testing/test.sh'
```

# Testing on Proxmox

in the test dir is the tool, the alias above should allow you to run it from anywhere in your repo.
