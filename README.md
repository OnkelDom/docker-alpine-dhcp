# DHCP server on Alpine

Show current OS Package Version:
[https://pkgs.alpinelinux.org/packages?name=dhcp&branch=v3.11]

For my test a addet the following setting to sysctl for binding ports <1024 as my user
```
# Persistant
echo "net.ipv4.ip_unprivileged_port_start=0" | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
# One time only (next reboot)
sudo sysctl net.ipv4.ip_unprivileged_port_start=0
```

Build with:
```
# x86_64 Systems (default):
podman build -t amd64/dhcp:4.4.1 --build-arg ARCH=amd64 --build-arg OS_VERSION=3.11 -f Dockerfile
# arm32v7 Systems:
podman build -t amd64/dhcp:4.4.1 --build-arg ARCH=arm32v7 --build-arg OS_VERSION=3.11 -f Dockerfile
# aarch64 Systems:
podman build -t amd64/dhcp:4.4.1 --build-arg ARCH=aarch64 --build-arg OS_VERSION=3.11 -f Dockerfile
```

Run with:
```bash
podman run -d -p 67:67/tcp -p 67:67/udp --name dhcp --hostname dhcp localhost/amd64/dhcp:4.4.1
``` 
