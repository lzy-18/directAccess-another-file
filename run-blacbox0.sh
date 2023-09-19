set -x
#!/bin/bash
# Huaicheng Li <huaicheng@cs.uchicago.edu>
# Run FEMU as a black-box SSD (FTL managed by the device)

# image directory
IMGDIR=$HOME/images
# Virtual machine disk image
OSIMGF=$IMGDIR/u20s.qcow2

if [[ ! -e "$OSIMGF" ]]; then
	echo ""
	echo "VM disk image couldn't be found ..."
	echo "Please prepare a usable VM image and place it as $OSIMGF"
	echo "Once VM disk image is ready, please rerun this script again"
	echo ""
	exit
fi

# sudo x86_64-softmmu/qemu-system-x86_64 \
#     -name "FEMU-BBSSD-VM" \
#     -enable-kvm \
#     -cpu host \
#     -smp 4 \
#     -m 4G \
#     -device virtio-scsi-pci,id=scsi0 \
#     -device scsi-hd,drive=hd0 \
#     -drive file=$OSIMGF,if=none,aio=native,cache=none,format=qcow2,id=hd0 \
#     -device femu,devsz_mb=4096,femu_mode=1 \
#     -net user,hostfwd=tcp::8080-:22 \
#     -net nic,model=virtio \
#     -nographic \
#     -qmp unix:./qmp-sock,server,nowait 2>&1 | tee log

sudo x86_64-softmmu/qemu-system-x86_64 \
 -enable-kvm -machine q35 -smp 8 -m 8G -bios /usr/share/ovmf/OVMF.fd \
 -device virtio-scsi-pci,id=scsi0 \
 -drive if=pflash,format=raw,readonly,file=/home/lizhiyuan/plog0/output/build/ovmf_code.fd \
 -drive if=pflash,format=raw,file=/home/lizhiyuan/plog0/output/build/ovmf_vars.fd \
 -drive if=virtio,format=raw,file=/home/lizhiyuan/plog0/output/build/debian.raw \
 -device femu,devsz_mb=4096,femu_mode=1,femu_ip=192.168.3.18,masterip=192.168.3.18,slaveip=192.168.3.236  \
 -net tap,ifname=tapfemulzy,script=no,downscript=no -net nic,macaddr=`dd if=/dev/urandom count=1 2>/dev/null | md5sum | sed 's/^\(.\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\14:\2:\3:\4:\5:\6/g'` -nographic