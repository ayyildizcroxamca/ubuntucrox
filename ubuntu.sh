#!/data/data/com.termux/files/usr/bin/bash
folder=ubuntu-fs
if [ -d "$folder" ]; then
	first=1
	echo "indirmeyi atlama"
fi
tarball="ubuntu.tar.gz"
if [ "$first" != 1 ];then
	if [ ! -f $tarball ]; then
		echo "ubuntu-resim indiriliyor"
		case `dpkg --print-architecture` in
		aarch64)
			archurl="arm64" ;;
		arm)
			archurl="armhf" ;;
		amd64)
			archurl="amd64" ;;
		i*86)
			archurl="i386" ;;
		x86_64)
			archurl="amd64" ;;
		*)
			echo "bilinmeyen mimari"; exit 1 ;;
		esac
		wget "https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-${archurl}-root.tar.gz" -O $tarball
	fi
	cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	echo "ubuntu resmini açma"
	proot --link2symlink tar -xf ${cur}/${tarball} --exclude='dev'||:
	echo "nameserver'ı düzeltiniz, aksi halde internete bağlanamaz"
	echo "nameserver 1.1.1.1" > etc/resolv.conf
	cd "$cur"
fi
mkdir -p binds
bin=start-ubuntu.sh
echo "başlatma komut dosyası yazma"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A binds)" ]; then
    for f in binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo "$ bin'ın shebang sabitleme"
termux-fix-shebang $bin
echo "$ bin çalıştırılabilir hale getirme"
chmod +x $bin
echo "Artık Ubuntu'yu ./${bin} betiğiyle başlatabilirsiniz"
echo "AYYILDIZ.ORG - CROXAMCA"
