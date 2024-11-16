
#usefull functions for install and launch distros on qemu

MEM_DISK="100G"
RAM=16000


function install_distro(){
	
	#read -p "[]	insert the amount of disk space: " MEM_DISK
	#read -p "[]	insert the amount of ram reserved for the vm [in mb] : " RAM
	read -p "[]	insert the distro image name: " DISTRO_ISO
	read -p "[]	insert the disk image name: " DISK_IMAGE_NAME
	
	echo $DISTRO_ISO
	echo $RAM
}

function qemu_create_img(){
	qemu-img create -f qcow2 $DISK_IMAGE_NAME $MEM_DISK
}

function qemu_install_distro(){
qemu-system-x86_64 -m $RAM -smp 1 -enable-kvm -nic user,model=virtio-net-pci -boot menu=on,order=d -drive file=$DISK_IMAGE_NAME   -drive media=cdrom,file=$DISTRO_ISO
}


function start(){

	install_distro
	qemu_create_img
	qemu_install_distro
}

start
