install:
	sudo chmod +x src/switch_network.sh
	sudo cp src/switch_network.sh /usr/bin/
	sudo cp switch_network.service /etc/systemd/system/

start:
	sudo systemctl start switch_network.service

enable:
	sudo systemctl enable switch_network.service

stop:
	sudo systemctl stop switch_network.service

uninstall:stop
	sudo systemctl disable switch_network.service
	sudo rm /usr/bin/switch_network.sh
	sudo rm /etc/systemd/system/switch_network.service 

log:
	journalctl -f	
