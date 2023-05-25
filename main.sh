#!/bin/bash
URL="https://cdn.ipip.net/17mon/besttrace4linux.zip"
ARCH=$(uname -m)
FILE_NAME_SPACE="bestTrace"
list=('广州电信,14.215.116.1' '厦门电信,117.28.254.129')

download_file() {
    if [ ! -f "bestTrace.zip" ]; then
        wget -c -O bestTrace.zip $URL
    fi
    unzip bestTrace.zip -d $FILE_NAME_SPACE
    rm bestTrace.zip
    cd $FILE_NAME_SPACE
    if [ "${ARCH}" == "i686" ]; then
        cp besttrace32 app
    else
        cp besttrace app
    fi
    chmod +x app
}

split() {
    echo "$(printf '=%.0s' {1..100})"
}

run() {
    for item in ${list[@]}
    do
        array=(${item//,/ })
        echo "${array[0]} ${array[1]}"
        ./app -q 1 ${array[1]}
        split
    done
}

download_file
run
  
  
