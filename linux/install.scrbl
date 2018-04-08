#lang scribble/manual

@title{Installation}

If you only have windows, you probably want to use @emph{unetbootin}
to create LiveUSB. On Linux

@verbatim[#:indent 4]{
dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx && sync
# restore
dd count=1 bs=512 if=/dev/zero of=/dev/sdx && sync
}

On Max:

@verbatim[#:indent 4]{
hdiutil convert -format UDRW -o ~/path/to/target.img ~/path/to/ubuntu.iso
diskutil list, insert usb, diskutil list => /dev/disk1
diskutil unmountDisk /dev/diskN
sudo dd if=/path/to/downloaded.img of=/dev/rdiskN bs=1m
diskutil eject /dev/diskN
}

Create a Mac LiveUSB:
@verbatim[#:indent 4]{
sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia \
--volume /Volumes/Untitled \
--applicationpath /Applications/InstallXXX.app \
--nointeraction
}

