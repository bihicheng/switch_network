# switch network service
some simple script to switch my custome network 

## Usage
this service identify network changed and auto switch 


#### Install Daemon Service
install src/switch_network.sh into /usr/bin
```
make install
```

#### Start switch network service
systemctl start switch_network.service
```
make start
```

#### Enable boot startup run switch network service
systemctl enable switch_network.service
```
make enable 
```


#### remove switch network script
remove bin file from /usr/bin/ and remove switch_network.service from /etc/systemd/system/
```
make uninstall
```

#### you can watch the service log
```
make log
```

## License
This library is free software; you can redistribute it and/or modify it under
the terms of the MIT license. See [LICENSE](LICENSE) for details.

