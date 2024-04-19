## IKEv2 VPN Server

IKEv2 VPN Server based on Alpine image. Support OS clients - macOS, iOS, Linux, Windows, Android.

#### 1. Install IKEv2 VPN Server on vps

#### 1.1 Clone this repository

    git clone https://github.com/texnari4/docker-ikev2-vpn-server.git && cd docker-ikev2-vpn-server

#### 1.2 Build docker image

    docker build --no-cache -t docker-ikev2-vpn-server:alpine .

#### 1.3 Start the IKEv2 VPN Server

    docker run --cap-add=NET_ADMIN -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp docker-ikev2-vpn-server:alpine