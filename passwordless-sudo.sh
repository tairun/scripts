#Add the current user to sudoers file and disable password prompt

ADDLINE="$(whoami) ALL=(ALL) NOPASSWD: ALL"

visudo
cat >> /etc/sudoers << EOF
$ADDLINE
EOF