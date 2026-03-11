# ansible-template
My Ansible setup, without all my configs. I hope

## Start here

Run the below code to get a python environment setup

```bash
python3.10 -m venv .venv
source .venv/bin/activate
python3.10 -m pip install --upgrade pip
python3.10 -m pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
```

Now you will need to build out your inventory with all your hosts,
then make changes to configs with real hostnames/IPs.

# Testing on Proxmox

in the test dir is the tool, the alias above should allow you to run it from anywhere in your repo.
