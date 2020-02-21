# SoalShift_modul1_D02
**Soal 2**
___
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan.

a. Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka.

b. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

c. Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.)

d. jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.

HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script*

**Syntax untuk mengenerate random password dan menyimpan dalam sebuah file berekstensi .txt**
```
#!/bin/bash 
if [[ $1 =~ ^[a-zA-Z]+$ ]] 
then
	dd if=/dev/urandom|tr -dc A-Za-z0-9|head -c 28 >> $1.txt
else
	echo "error"
fi
```
``` dd if=/dev/urandom|tr -dc A-Za-z0-9|head -c 28 >> $1.txt ``` berfungsi untuk mengenerate random password yang otomatis akan di simpan kedalam sebuah file .txt yang nama nya telah ditulis dalam bentuk argumen.

```if [[ $1 =~ ^[a-zA-Z]+$ ]]``` pembuatan kondisi dimana program akan mencetak error bila tidak memenuhi kodisi nama argumen yang mengandung karakter selain a-z dan A-Z

**Syntax untuk enkripsi file**
```
#!/bin/bash

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

name=$(echo "$1" | tr -d '.txt')
jam=$(date +"%k")
rename=$(echo $name | tr "${upper:0:26}${lower:0:26}" "${upper:$jam:26}${lower:$jam:26}")

mv $1 $rename.txt
```
```
lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper
``` 
Pembuatan dua variable berisi urutan alphabet kecil dan kapital sebanyak dua kali perulangan.

```name=$(echo "$1" | tr -d '.txt')``` mengambil hanya nama argumennya saja agar ekstensi file (.txt) tidak ikut terenkripsi.

```jam=$(date +"%k")``` mengambil angka pada jam file dibuat.

```rename=$(echo $name | tr "${upper:0:26}${lower:0:26}" "${upper:$jam:26}${lower:$jam:26}")``` merename nama file dengan menggeser masing masing huruf sebanyak jam pada saat file dibuat dengan melakukan caesar chiper dengan cara membuat dua set urutan karakter. ```"${upper:0:26}``` untuk mengambil substring A-Z, ```${lower:0:26}``` untuk mengambil substring a-z.```"${upper:$jam:26}${lower:$jam:26}")``` menggeser substring susuai jam.

```mv $1 $rename.txt``` perintah untuk mengubah nama file.

**Syntax untuk dekripsi file**
```
#!/bin/bash

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

name=$(echo "$1" | tr -d '.txt')
jam=$(date +"%k")
#amt=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
echo "$amt"
rename=$(echo $name | tr "${upper:$jam:26}${lower:$jam:26}" "${upper:0:26}${lower:0:26}")

mv $1 $rename.txt
```
sama seperti pada ekripsi, hanya saja set pertama dan kedua dibalik, sehingga pergeseran substring yang terjadi juga terbalik dan file akan kembali ke nama sebelum di enkripsi.
