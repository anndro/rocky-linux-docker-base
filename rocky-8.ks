# fork from: https://github.com/CentOS/sig-cloud-instance-build/tree/master/docker
#
# This is a minimal Rocky kickstart designed for docker.
# It will not produce a bootable system
# To use this kickstart, run the following command
# livemedia-creator --make-tar \
#   --iso=/path/to/boot.iso  \
#   --ks=rocky-8.ks \
#   --image-name=rocky-root.tar.xz
#

# Basic setup information
url --url="https://download.rockylinux.org/pub/rocky/8.3/BaseOS/x86_64/os/"
install
keyboard us
rootpw --lock --iscrypted locked
timezone --isUtc --nontp UTC
selinux --enforcing
firewall --disabled
network --bootproto=dhcp --device=link --activate --onboot=on
shutdown
bootloader --disable
lang en_US

# Disk setup
zerombr
clearpart --all --initlabel
autopart --noboot --nohome --noswap --nolvm --fstype=ext4

# Package setup
%packages --excludedocs --instLangs=en --nocore --ignoremissing
rocky-release
binutils
-brotli
bash
hostname
rootfiles
coreutils-single
glibc-minimal-langpack
vim-minimal
less
-gettext*
-firewalld
-os-prober*
tar
-iptables
iputils
-kernel
-dosfstools
-e2fsprogs
-fuse-libs
-gnupg2-smime
-libss
-pinentry
-shared-mime-info
-trousers
-xkeyboard-config
-xfsprogs
-qemu-guest-agent
yum
-grub\*

%end

%post --erroronfail --log=/root/anaconda-post.log
# container customizations inside the chroot

echo 'container' > /etc/dnf/vars/infra

#Generate installtime file record
/bin/date +%Y%m%d_%H%M > /etc/BUILDTIME

# Limit languages to help reduce size.
LANG="en_US"
echo "%_install_langs $LANG" > /etc/rpm/macros.image-language-conf


# systemd fixes
:> /etc/machine-id
umount /run
systemd-tmpfiles --create --boot
# mask mounts and login bits
systemctl mask systemd-logind.service getty.target console-getty.service sys-fs-fuse-connections.mount systemd-remount-fs.service dev-hugepages.mount

# Remove things we don't need
rm -f /etc/udev/hwdb.bin
rm -rf /usr/lib/udev/hwdb.d/
rm -rf /boot
rm -rf /var/lib/dnf/history.*


%end


