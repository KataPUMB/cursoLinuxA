sudo echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -s 192.168.56.1 -o wlp3s0 -j MASQUERADE
sudo iptables -A INPUT -p tcp --dport 137,445 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 138:139 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 137,445 -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 138:139 -j ACCEPT
