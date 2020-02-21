# SoalShift_modul1_D02

**Soal 1**
___
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit

b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a

c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b

Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan laporan tersebut.
*Gunakan Awk dan Command pendukung

Pada soal nomor 1.a kita diminta untuk mencari region mana yang memiliki keuntungan atau profit yang paling sedikit dimana semua data diambil dari "Sample-Superstore.tsv".
	
	echo " 1.a : Wilayah bagian(Region) yang memiliki profit paling sedikit"

	region=$(awk -F $'	' '
         NR == 1 {next}
         { a[$13] += $21 }
         END { for (b in a) { printf "%s %.4f\n", b, a[i]} }
         ' Sample-Superstore.tsv | sort -n | awk '{print $1}' | head -1)

	echo  "	$region"

Untuk 1.b kita diminta menampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin soal 1.a

	echo -e "\n 1.b : 2 Negara bagian(State) yang memiliki profit paling sedikit"

	state=$(awk -v region="$region" -F $'	' '
        NR == 1 {next}
        ( $13 == region ) { a[$11] += $21 }
        END { for (b in a) { printf "%s %.4f\n", b, a[b]} }
        ' Sample-Superstore.tsv | sort -nk2 | awk '{print $1}' | head -2)

	state1=$(echo -e "$state" | sed -n '1p')
	state2=$(echo -e "$state" | sed -n '2p')

	echo "	- $state1"
	echo "	- $state2"

Untuk 1.c kita diminta menampilkan 10  produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil dari negara bagian (state) yang dihasilkan di poin 1.b
	
	echo -e "\n 1.c : 10 produk dengan profit paling sedikit berdasarkan poin 1.b"

	product=$(awk -v state1="$state1" -v state2="$state2" -F '	' '
        NR == 1 {next}
        ( $11 == state1 ) || ( $11 == state2 ) { a[$17] += $21 }
        END {for (b in a) {printf "	- %s:%.4f\n", b, a[b]}}
        ' Sample-Superstore.tsv | sort -t $":" -nk2 | awk -F: '{print $1}' | head -10 )

	echo  "$product"
	
	
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

**Program untuk mengenerate random password dan menyimpan dalam sebuah file berekstensi .txt**
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

**Program untuk enkripsi file**
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

**Program untuk dekripsi file**
```
#!/bin/bash

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

name=$(echo "$1" | tr -d '.txt')
#jam=$(date +"%k")
time=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
echo "$time"
rename=$(echo $name | tr "${upper:$time:26}${lower:$time:26}" "${upper:0:26}${lower:0:26}")

mv $1 $rename.txt
```
sama seperti pada enkripsi, hanya saja set pertama dan kedua dibalik, sehingga pergeseran substring yang terjadi juga terbalik dan file akan kembali ke nama sebelum di enkripsi.

``` time=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')``` berfungsi untuk mengambil data jam ketika file sebelumnya dibuat atau di akses.

**Soal 3**
___
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing.

a. Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan

b. Setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi.

c. Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan  dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

**Program**
```
#!/bin/bash

for ((i=0; i<28;i++))
do
	wget -O pdkt_kusuma_$i -o asd.log  https://loremflickr.com/320/240/cat 
	cat asd.log >> wget.log
done
	cat wget.log | grep Location: > location.log
#cat location.log

mkdir duplicate 
mkdir kenangan

awk '{ printf("%s;%02d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > file.log

awk -F ';' '{ i = $2+0; 
		if( L == $1 ){ 
			move = " mv pdkt_kusuma_" i " duplicate/duplicate_" i; } 
  		else {
			  L = $1; 
			  move = " mv pdkt_kusuma_" i " kenangan/kenangan_" i ; }
				system(move); }' file.log 

for namafile in *.log; 
do 
	mv "$namafile" "${namafile%.log}.log.bak"
done 
```

```
wget -O pdkt_kusuma_$i -o asd.log  https://loremflickr.com/320/240/cat 
	cat asd.log >> wget.log
```
Program untuk mendownload file dari link yang telah ada dan di looping sebanyak 28 kali.

```
cat wget.log | grep Location: > location.log
```
Berfungsi mengcopy tiap isi yang diterima asd.log kedalam location.log

```
mkdir duplicate 
mkdir kenangan
```
Untuk membuat file kenangan dan duplicate
```
awk '{ printf("%s;%02d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > file.log
```
Berungsi untuk mengambil string dari location.log kemudian diletakkan di file file.log dengan menambahkan index dengan format ```%02d``` dengan separator ```;```.
``` sort -n -k1``` untuk sorting isi string di file location.org 

```-n ``` untuk mengurutkan secara numerik string

```-k1``` untuk mengurutkan pada kolom ke 1

```
awk -F ';' '{ i = $2+0; 
		if( L == $1 ){ 
			move = " mv pdkt_kusuma_" i " duplicate/duplicate_" i; } 
  		else {
			  L = $1; 
			  move = " mv pdkt_kusuma_" i " kenangan/kenangan_" i ; }
				system(move); }' file.log 
```

Dilakukan awk pada file file.log dengan membandingkan perbaris string yang telah di urutkan pada awk sebelumnya. Apabila sama maka akan masuk ke kondisi if dan file di pindah kan ke folder duplicate. Apa bila string yang dibandingkan tidak sama maka file akan dipindahkan ke folder kenangan.
```i = $2+0;``` berfungsi untuk menghilangkan 0 di depan angka index.

```system(move)``` berfungsi untuk menjalankan ```move```

```
for namafile in *.log; 
do 
	mv "$namafile" "${namafile%.log}.log.bak"
done 
```
untuk mengubah semua namafile berekstensi .log menjadi ekstensi .log.bak
___
untuk menjalankan script dimulai setiap 8 jam sekali dimulai jam 6.05 kecuali hari sabtu, dibuat cron job berikut:

``` 5 6,14,22 * * 0-5 /home/soal3.sh```

``` 5 6,14,22 * * 0-5``` merupakan format untuk menjalankan script 8 jam sekali dimulai jam 06:50 kecuali hari sabtu.
```/home/soal3.sh``` merupakan lokasi file.

