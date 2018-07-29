export PATH="$coreutils/bin"

mkdir -p $out/bin
mkdir -p $out/artifact/bin


for i in $(ls $src); do
# TODO: may need xdo
    echo "
PATH=\$PATH:$xdotool/bin:$bspwm/bin:$xtitle/bin:$wmutils/bin:$wmctrl/bin
$out/artifact/bin/$i \$@" > $out/bin/$i 

    cp $src/$i $out/artifact/bin/$i

    chmod +x $out/artifact/bin/$i
    chmod +x $out/bin/$i
done;

