# termux-ubuntu

Termux’de Ubuntu chroot’u kurmak için bir betik

Bu betiği kullanmadan önce Termux'da wget ve proot yüklemeniz gerekir.

`
pkg install wget proot
`

Komut dosyası dosyalarını geçerli dizinde yapar. Dolayısıyla, Ubuntu dosya sisteminizin belirli bir konumdaki olmasını istiyorsanız, önce bu klasöre geçin ve daha sonra, göreceli yolla komut dosyasını çağırın. Örnek:
`
mkdir -p ~ / jails / ubuntu
cd ~ / jails / ubuntu
wget https://raw.githubusercontent.com/Neo-Oli/termux-ubuntu/master/ubuntu.sh
bash ubuntu.sh
`

Çalıştırdıktan sonra ubuntu'nuza geçmek için "start-ubuntu.sh" komutunu çalıştırabilirsiniz.

#CROXAMCA - AYYILDIZ.ORG