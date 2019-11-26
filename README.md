# chroot
Choot Jail SFTP User Centos7

The following needs to be done before executing the script first time

Add SFTP User Group::

groupadd sftpusers

Update SSH Configuration::

vi /etc/ssh/sshd_config

####Comment the following

#Subsystem      sftp    /usr/libexec/openssh/sftp-server

####Add the follwoing Lines at the bottom of the file 

Subsystem   sftp    internal-sftp -d /home
Match Group sftpusers
ChrootDirectory /jail/%u

Restart SSH::

systemctl restart sshd


Script Usage:

chmod u+x cloudwwh_chroot.sh
./cloudwwh_chroot.sh USERNAME
