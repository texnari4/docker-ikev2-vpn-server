## IKEv2 VPN Server

IKEv2 VPN Server based on Alpine image. Support OS clients - macOS, iOS, Linux, Windows, Android.

#### 1. Install IKEv2 VPN Server on vps

#### 1.1 Clone this repository

    git clone https://github.com/VictorBurtsev/ikev2-vpn-server-alpine.git && cd ikev2-vpn-server-alpine

#### 1.2 Build docker image

    docker build --no-cache -t ikev2-vpn-server-alpine:alpine .

#### 1.3 Start the IKEv2 VPN Server

    docker run --cap-add=NET_ADMIN -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp ikev2-vpn-server-alpine:alpine

#### 2. Configure client for iOS / macOS

#### 2.1 Generate the .mobileconfig (for iOS / macOS) to the current path

    docker exec -it ikev2-vpn-server-alpine generate-mobileconfig > ikev2-vpn.mobileconfig

Transfer the generated `ikev2-vpn.mobileconfig` file to your local computer via SSH tunnel (`scp`) or any other secure methods.

#### 2.2 Install the .mobileconfig (for iOS / macOS)

- **iOS 9 or later**: AirDrop the `.mobileconfig` file to your iOS 9 device, finish the **Install Profile** screen;

- **macOS 10.11 El Capitan or later**: Double click the `.mobileconfig` file to start the *profile installation* wizard.

#### 3. Configure client for Linux

#### 3.1 Install Strongswan

    apt install strongswan

#### 3.2 Copy config in */etc/ipsec.conf*

    # ipsec.conf - strongSwan IPsec configuration file
    
    conn %default
        type=tunnel
        keyexchange=ikev2
        authby=secret
        ike=aes256-sha2_256-modp2048!
        esp=aes256-sha2_256!
        
    conn ikev2-vpn
        right=your_server_ip
        rightsubnet=0.0.0.0/0
        leftsourceip=%config
        auto=start

#### 3.3 Copy secret from server */etc/ipsec.secrets* into client host */etc/ipsec.secrets*

    : PSK "your_psk"

#### 3.4 Option - if apparmor work on system add in file */etc/apparmor.d/usr.lib.ipsec.charon* line (or use resolvconf framework)

    /etc/resolv.conf          w,

And apply changes

    apparmor_parser -r /etc/apparmor.d/usr.lib.ipsec.charon

#### 3.5 Option - if any urls dont work try reduce MTU

     echo 'pre-up /sbin/ifconfig $IFACE mtu 1400' >> /etc/network/interfaces

#### 3.6 Start linux client

    ipsec reload && ipsec restart && ipsec up ikev2-vpn

#### 4. Configure client for Windows 7/10

#### 4.1 Windows 7/10 dont support built-in PSK auth method - simple install it:

    http://www.thegreenbow.com/

#### 5. Configure client for Android

#### 5.1 Use built-in PSK auth method in native Android client

#### Technical Details

Upon container creation, a *shared secret* was generated for authentication purpose, no *certificate*, *username*, or *password* was ever used, simple life!

#### License

Copyright (c) 2023 Mengdi Gao, Nebukad93, vl_burtsev  This software is licensed under the [MIT License](LICENSE).
