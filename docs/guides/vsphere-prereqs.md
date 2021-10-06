# Prerequisites for vSphere UPI

<!--- cSpell:ignore homelab dhcpd dhcpcd ddns rndc domainname arpa resolv dnsutils dnssec nxdomain CNAME ECDH AESGCM sslv httplog tcplog dontlognull errorfile maxconn uncommented  -->

In this example I describe the setup of a DNS/DHCP server and a Load Balancer on a Raspberry PI microcomputer. The instructions most certainly will also work for other environments.

I use Raspberry Pi OS (debian based).

## IP Addresses of components in this example

- Homelab subnet: 192.168.178.0/24
- DSL router/gateway: 192.168.178.1
- IP address of Raspberry Pi (DHCP/DNS/Load Balancer): 192.168.178.5
- local domain: homelab.net
- local cluster (name: c1) domain: c1.homelab.net
- DHCP range: 192.168.178.40 … 192.168.178.199
- Static IPs for OKD’s bootstrap, masters and workers

## Upgrade Raspberry Pi

```shell
sudo apt-get update
sudo apt-get upgrade
sudo reboot
```

## Set static IP address on Raspberry Pi

Add this:

```text
interface eth0 
static ip_address=192.168.178.5/24 
static routers=192.168.178.1 
static domain_name_servers=192.168.178.5 8.8.8.8
```

to **/etc/dhcpcd.conf**

## DHCP

Ensure that no other DHCP servers are activated in the network of your homelab e.g. in your internet router.

The DHCP server in this example is setup with DDNS (Dynamic DNS) enabled.

## Install

```sudo apt-get install isc-dhcp-server```

## Configure

Enable DHCP server for IPv4 on eth0:

**/etc/default/isc-dhcp-server**

```text
INTERFACESv4="eth0" 
INTERFACESv6=""
```

**/etc/dhcp/dhcpd.conf**

```text
# dhcpd.conf
#

####################################################################################
# Configuration for Dynamic DNS (DDNS) updates                                     #
# Clients requesting an IP and sending their hostname for domain *.homelab.net     #
# will be auto registered in the DNS server.                                       #
####################################################################################
ddns-updates on;
ddns-update-style standard;

# This option points to the copy rndc.key we created for bind9.
include "/etc/bind/rndc.key";

allow unknown-clients;
use-host-decl-names on;
default-lease-time 300; # 5 minutes
max-lease-time 300;     # 5 minutes

# homelab.net DNS zones
zone homelab.net. {
  primary 192.168.178.5; # This server is the primary DNS server for the zone
  key rndc-key;       # Use the key we defined earlier for dynamic updates
}
zone 178.168.192.in-addr.arpa. {
  primary 192.168.178.5; # This server is the primary reverse DNS for the zone
  key rndc-key;       # Use the key we defined earlier for dynamic updates
}

ddns-domainname "homelab.net.";
ddns-rev-domainname "in-addr.arpa.";
####################################################################################


####################################################################################
# Basic configuration                                                              #
####################################################################################
# option definitions common to all supported networks...
default-lease-time 300;
max-lease-time     300;

# If this DHCP server is the official DHCP server for the local
# network, the authoritative directive should be uncommented.
authoritative;

# Parts of this section will be put in the /etc/resolv.conf of your hosts later
option domain-name "homelab.net";
option routers 192.168.178.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 192.168.178.5;

subnet 192.168.178.0 netmask 255.255.255.0 {
  range 192.168.178.40 192.168.178.199;
}
####################################################################################


####################################################################################
# Static IP addresses                                                              #
# (Replace the MAC addresses here with the ones you set in vsphere for your vms)   #
####################################################################################
group {
  host bootstrap {
      hardware ethernet 00:1c:00:00:00:00;
      fixed-address 192.168.178.200;
  }

  host master0 {
      hardware ethernet 00:1c:00:00:00:10;
      fixed-address 192.168.178.210;
  }

  host master1 {
      hardware ethernet 00:1c:00:00:00:11;
      fixed-address 192.168.178.211;
  }

  host master2 {
      hardware ethernet 00:1c:00:00:00:12;
      fixed-address 192.168.178.212;
  }

  host worker0 {
      hardware ethernet 00:1c:00:00:00:20;
      fixed-address 192.168.178.220;
  }

  host worker1 {
      hardware ethernet 00:1c:00:00:00:21;
      fixed-address 192.168.178.221;
  }
  
  host worker2 {
      hardware ethernet 00:1c:00:00:00:22;
      fixed-address 192.168.178.222;
  }  
}
```

## DNS

### Install

```shell
sudo apt install bind9 dnsutils
```

### Basic configuration

**/etc/bind/named.conf.options**

```text
include "/etc/bind/rndc.key";

acl internals {
    // lo adapter
    127.0.0.1;

    // CIDR for your homelab network
    192.168.178.0/24;
};

options {
        directory "/var/cache/bind";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable
        // nameservers, you probably want to use them as forwarders.
        // Uncomment the following block, and insert the addresses replacing
        // the all-0's placeholder.

        forwarders {
          8.8.8.8;
          8.8.4.4;
        };
        forward only;

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        dnssec-validation no;

        listen-on-v6 { none; };
        auth-nxdomain no;
        listen-on port 53 { any; };

        // Allow queries from my Homelab and also from Wireguard Clients.
        allow-query { internals; };
        allow-query-cache { internals; };
        allow-update { internals; };
        recursion yes;
        allow-recursion { internals; };
        allow-transfer { internals; };

        dnssec-enable no;

        check-names master ignore;
        check-names slave ignore;
        check-names response ignore;
};
```

**/etc/bind/named.conf.local**

```text
#include "/etc/bind/rndc.key";

//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

# All devices that don't belong to the OKD cluster will be maintained here.
zone "homelab.net" {
   type master;
   file "/etc/bind/forward.homelab.net";
   allow-update { key rndc-key; };
};

zone "c1.homelab.net" {
   type master;
   file "/etc/bind/forward.c1.homelab.net";
   allow-update { key rndc-key; };
};

zone "178.168.192.in-addr.arpa" {
   type master;
   notify no;
   file "/etc/bind/178.168.192.in-addr.arpa";
   allow-update { key rndc-key; };
};
```

Zone file for homlab.net: **/etc/bind/forward.homelab.net**

```text
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     homelab.net. root.homelab.net. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      homelab.net.
@       IN      A       192.168.178.5
@       IN      AAAA    ::1
```

The name of the next file depends on the subnet that is used:

**/etc/bind/178.168.192.in-addr.arpa**

```text
$TTL 1W
@ IN SOA ns1.homelab.net. root.homelab.net. (
                                2019070742 ; serial
                                10800      ; refresh (3 hours)
                                1800       ; retry (30 minutes)
                                1209600    ; expire (2 weeks)
                                604800     ; minimum (1 week)
                                )
                        NS      ns1.homelab.net.

200                     PTR     bootstrap.c1.homelab.net.

210                     PTR     master0.c1.homelab.net.
211                     PTR     master1.c1.homelab.net.
212                     PTR     master2.c1.homelab.net.

220                     PTR     worker0.c1.homelab.net.
221                     PTR     worker1.c1.homelab.net.
222                     PTR     worker2.c1.homelab.net.

5                       PTR     api.c1.homelab.net.
5                       PTR     api-int.c1.homelab.net.
```

### DNS records for OKD 4

Zone file for **c1.homelab.net** (our OKD 4 cluster will be in this domain):

**/etc/bind/forward.c1.homelab.net**

```text
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     c1.homelab.net. root.c1.homelab.net. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      c1.homelab.net.
@       IN      A       192.168.178.5
@       IN      AAAA    ::1

load-balancer IN A      192.168.178.5

bootstrap IN    A       192.168.178.200

master0 IN      A       192.168.178.210
master1 IN      A       192.168.178.211
master2 IN      A       192.168.178.212

worker0 IN      A       192.168.178.220
worker1 IN      A       192.168.178.221
worker2 IN      A       192.168.178.222
worker3 IN      A       192.168.178.223

*.apps.c1.homelab.net.  IN CNAME load-balancer.c1.homelab.net.
api-int.c1.homelab.net. IN CNAME load-balancer.c1.homelab.net.
api.c1.homelab.net.     IN CNAME load-balancer.c1.homelab.net.
```

### Set file permissions

For dynamic DNS (ddns) to work you should do this: 

```shell
sudo chown -R bind:bind /etc/bind
```

## Load Balancer

### Install

```shell
sudo apt-get install haproxy
```

### Configure

**/etc/haproxy/haproxy.cfg**

```text
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # Default ciphers to use on SSL-enabled listening sockets.
        # For more information, see ciphers(1SSL). This list is from:
        #  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
        # An alternative list with additional directives can be obtained from
        #  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
        ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
        ssl-default-bind-options no-sslv3

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 20000
        timeout client  10000
        timeout server  10000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http


# You can see the stats and observe OKD's bootstrap process by opening
# http://<IP>:4321/haproxy?stats
listen stats
    bind :4321
    mode            http
    log             global
    maxconn 10

    timeout client  100s
    timeout server  100s
    timeout connect 100s
    timeout queue   100s

    stats enable
    stats hide-version
    stats refresh 30s
    stats show-node
    stats auth admin:password
    stats uri  /haproxy?stats


frontend openshift-api-server
    bind *:6443
    default_backend openshift-api-server
    mode tcp
    option tcplog

backend openshift-api-server
    balance source
    mode tcp
    server bootstrap bootstrap.c1.homelab.net:6443 check
    server master0 master0.c1.homelab.net:6443 check
    server master1 master1.c1.homelab.net:6443 check
    server master2 master2.c1.homelab.net:6443 check


frontend machine-config-server
    bind *:22623
    default_backend machine-config-server
    mode tcp
    option tcplog

backend machine-config-server
    balance source
    mode tcp
    server bootstrap bootstrap.c1.homelab.net:22623 check
    server master0 master0.c1.homelab.net:22623 check
    server master1 master1.c1.homelab.net:22623 check
    server master2 master2.c1.homelab.net:22623 check


frontend ingress-http
    bind *:80
    default_backend ingress-http
    mode tcp
    option tcplog

backend ingress-http
    balance source
    mode tcp
    server master0 master0.c1.homelab.net:80 check
    server master1 master1.c1.homelab.net:80 check
    server master2 master2.c1.homelab.net:80 check

    server worker0 worker0.c1.homelab.net:80 check
    server worker1 worker1.c1.homelab.net:80 check
    server worker2 worker2.c1.homelab.net:80 check
    server worker3 worker3.c1.homelab.net:80 check


frontend ingress-https
    bind *:443
    default_backend ingress-https
    mode tcp
    option tcplog

backend ingress-https
    balance source
    mode tcp

    server master0 master0.c1.homelab.net:443 check
    server master1 master1.c1.homelab.net:443 check
    server master2 master2.c1.homelab.net:443 check

    server worker0 worker0.c1.homelab.net:443 check
    server worker1 worker1.c1.homelab.net:443 check
    server worker2 worker2.c1.homelab.net:443 check
    server worker3 worker3.c1.homelab.net:443 check
```

## Reboot and check status

Reboot Raspberry Pi:

```shell
sudo reboot
```

Check status of DNS/DHCP server and Load Balancer:

```shell
sudo systemctl status haproxy.service 
sudo systemctl status isc-dhcp-server.service 
sudo systemctl status bind9
```

## Proxy (if on a private network)

If the cluster will sit on a private network, you’ll need a proxy for outgoing traffic, both for the install process and for regular operation. In the case of the former, the installer needs to pull containers from the external registries. In the case of the latter, the proxy is needed when application containers need access to the outside world (e.g. yum installs, external code repositories like gitlab, etc.)

The proxy should be configured to accept connections from the IP subnet for your cluster. A simple proxy to use for this purpose is squid
