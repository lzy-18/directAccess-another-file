sudo modprobe nvme
sudo modprobe nvme-tcp

sudo nvme discover -t tcp -a 192.168.3.14 -s 4420 --hostnqn=nqn.2014-08.org.nvmexpress:uuid:1b4e28ba-2fa1-11d2-883f-0016d3ccabcd

sudo nvme connect -t tcp -n nvme-test-target -a 192.168.3.14 -s 4420 --hostnqn=nqn.2014-08.org.nvmexpress:uuid:1b4e28ba-2fa1-11d2-883f-0016d3ccabcd

sudo nvme list