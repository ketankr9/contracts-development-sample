#!/bin/bash
contract_name="samplecontract"

solc --overwrite -o . --bin --abi ${contract_name}.sol

code=$(cat "${contract_name}.bin")
sed -i -e "s/^\s\{4\}var\scode\s=\s".*";$/    var code = \"$code\";/" "${contract_name}.html"

abi=$(cat "${contract_name}.abi")
sed -i -e "s/^\s\{4\}var\sabi\s=\s.*;$/    var abi = $abi;/" "${contract_name}.html"

# check if ganache is already running
ganache_status=$(pgrep -f "ganache-cli")

# if not running then start  ganache-cli or display the ganache-cli process
if [ -z "$ganache_status" ]
then
	if [ -e "/tmp/ganache_output" ] && [ -z "$(pgrep -f "ganache-cli")" ]; then
		rm /tmp/ganache_output
		mkfifo /tmp/ganache_output
	fi
	ganache-cli >> /tmp/test
else
	echo "Ganache Already Running"
fi

#upload to DigitaOcean Server
#scp -r ~/ctf/q1/examples/question1.html root@139.59.70.210:~/

# check if python server is running
server_status=$(pgrep -f "python \-m SimpleHTTPServer")

# similar to ganache
if [ ! -z "$server_status" ]
then
	pkill -f "python \-m SimpleHTTPServer"
fi

python -m SimpleHTTPServer 8080 &
firefox http://localhost:8080/

#sleep infinity
