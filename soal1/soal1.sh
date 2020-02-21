echo -e "Soal 1\n"

echo " 1.a : Wilayah bagian(Region) yang memiliki profit paling sedikit"

region=$(awk -F $'	' '
         NR == 1 {next}
         { a[$13] += $21 }
         END { for (b in a) { printf "%s %.4f\n", b, a[i]} }
         ' Sample-Superstore.tsv | sort -n | awk '{print $1}' | head -1)

echo  "	$region"



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



echo -e "\n 1.c : 10 produk dengan profit paling sedikit berdasarkan poin 1.b"

product=$(awk -v state1="$state1" -v state2="$state2" -F '	' '
        NR == 1 {next}
        ( $11 == state1 ) || ( $11 == state2 ) { a[$17] += $21 }
        END {for (b in a) {printf "	- %s:%.4f\n", b, a[b]}}
        ' Sample-Superstore.tsv | sort -t $":" -nk2 | awk -F: '{print $1}' | head -10 )

echo  "$product"
