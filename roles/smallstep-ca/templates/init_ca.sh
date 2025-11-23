#!/bin/bash
#
# This script will launch and configure a step-ca SSH Certificate Authority
# with OIDC and AWS provisioners
#
# See https://smallstep.com/blog/diy-single-sign-on-for-ssh/ for full instructions

OIDC_CLIENT_ID="{{ stepca_oidc_client_id }}" # from Google
OIDC_CLIENT_SECRET="{{ stepca_oidc_client_secret }}" # from Google
ALLOWED_DOMAIN="{{ stepca_allowed_domain }}"
CA_NAME="{{ stepca_ca_name }}"
ROOT_KEY_PASSWORD="{{ stepca_root_key_password }}"
EMAIL="{{ stepca_email }}"
STEPCLI_VERSION="{{ stepcli_version }}"

# Setup the JWK
mkdir /root/step-ca
touch /root/step-ca/key
echo $ROOT_KEY_PASSWORD > /root/step-ca/key
step crypto jwk create /root/step-ca/jwk.pub.json /root/step-ca/jwk.json --password-file=/root/step-ca/key

OPENID_CONFIG_ENDPOINT="https://accounts.google.com/.well-known/openid-configuration"

# All your CA config and certificates will go into $STEPPATH.
export STEPPATH=/etc/step-ca
mkdir -p $STEPPATH
chmod 700 $STEPPATH
echo $ROOT_KEY_PASSWORD > $STEPPATH/password.txt

# Add a service to systemd for our CA.
cat<<EOF > /etc/systemd/system/step-ca.service
[Unit]
Description=step-ca service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
Environment=STEPPATH=/etc/step-ca
ExecStart=/usr/bin/step-ca ${STEPPATH}/config/ca.json --password-file=${STEPPATH}/password.txt

[Install]
WantedBy=multi-user.target
EOF

# Set up our basic CA configuration and generate root keys
step ca init --ssh --name="$CA_NAME" \
     --dns="{{ stepca_dns_names }}" \
     --address=":8443" --provisioner="$EMAIL" \
     --password-file="$STEPPATH/password.txt"

# Add the Google OAuth provisioner, for user certificates
step ca provisioner add Google --type=oidc --ssh \
    --client-id="$OIDC_CLIENT_ID" \
    --client-secret="$OIDC_CLIENT_SECRET" \
    --configuration-endpoint="$OPENID_CONFIG_ENDPOINT" \
    --domain="$ALLOWED_DOMAIN"

# Add a JWK provisioner, for host bootstrapping
step ca provisioner add "${CA_NAME}" /root/step-ca/jwk.json \
  --ca-config /etc/step-ca/config/ca.json --ssh –password-file=/root/step-ca/key

# The sshpop provisioner lets hosts renew their ssh certificates
step ca provisioner add SSHPOP --type=sshpop --ssh

# Use Google (OIDC) as the default provisioner in the end user's
# ssh configuration template.
sed -i 's/\%p$/%p --provisioner="Google"/g' /etc/step-ca/templates/ssh/config.tpl

systemctl daemon-reload
service step-ca start

echo "export STEPPATH=$STEPPATH" >> /root/.profile
