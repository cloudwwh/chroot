#!/bin/sh
# Author Natraj Solai

# Checking Syntax

echo "Linux Program to install Chroot FTP User"
echo
if [ -z "$1" ] ; then
  echo
  echo "ERROR: Parameter missing. Did you forget the username?"
  echo "-------------------------------------------------------------"
  echo
  echo "USAGE:"
  echo "-> $0 username"
  echo "Error: Provide username."
  exit 1
fi

# Checking Root Permission

echo "Am I root?  "
if [ "$(whoami &2>/dev/null)" != "root" ] && [ "$(id -un &2>/dev/null)" != "root" ] ; then
  echo "  NO!

Error: You must be root to run this script."
  exit 1
fi

# Get Accountname

echo "Getting accountname"
echo "Checking if the user exists"
CHROOT_USERNAME=$1

# Check if the user exists

if ( id $CHROOT_USERNAME > /dev/null 2>&1 ) ; then {
echo " User $CHROOT_USERNAME exists...."
exit 1
}
else
  CREATEUSER="yes"
fi

# Create chroot user 

if [ "$CREATEUSER" = "yes" ] ; then {
echo "Adding User \"$CHROOT_USERNAME\" to system"
echo
useradd "$CHROOT_USERNAME"
mkdir /home/"$CHROOT_USERNAME"/.ssh
chmod 700 /home/"$CHROOT_USERNAME"/.ssh
touch /home/"$CHROOT_USERNAME"/.ssh/authorized_keys
chmod 600 /home/"$CHROOT_USERNAME"/.ssh/authorized_keys
echo
echo "-------- Creating Directory -----"
echo
mkdir -p /jail/"$CHROOT_USERNAME"/home
echo "-------- Modifying User-----"
echo
usermod -aG sftpusers "$CHROOT_USERNAME"
echo "-------- Assigining Permissions-----"
echo
chown "$CHROOT_USERNAME":sftpusers /jail/"$CHROOT_USERNAME"/home/
echo
echo "$CHROOT_USERNAME" user created successfully
}
fi

echo Chroot Jail User : "$CHROOT_USERNAME"
echo Chroot Home Directory : /jail/"$CHROOT_USERNAME"/home
echo Create SSH key and update /home/"$CHROOT_USERNAME"/.ssh/authorized_keys
exit
