rm -rf /etc/XrayR/4gviet.crt
rm -rf /etc/XrayR/4gviet.key
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/XrayR/4gviet.crt -keyout /etc/XrayR/4gviet.key -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku/O=Google Trust Services LLC/CN=google.com"
clear
read -p " NODE ID 1: " node_id1
  [ -z "${node_id1}" ] && node_id1=0
  
read -p " NODE ID 2: " node_id2
  [ -z "${node_id2}" ] && node_id2=0
  
read -p " DeviceLimit: " DeviceLimit
  [ -z "${DeviceLimit}" ] && DeviceLimit=0
  
read -p " CertDomain: " CertDomain
  [ -z "${CertDomain}" ] && CertDomain="vn.speed4g.me"
  
cd /etc/XrayR

cat >config.yml <<EOF
Log:
  Level: warning # Log level: none, error, warning, info, debug
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json # Path to dns config, check https://xtls.github.io/config/dns.html for help
RouteConfigPath: /etc/XrayR/route.json # Path to route config, check https://xtls.github.io/config/routing.html for help
InboundConfigPath: # /etc/XrayR/custom_inbound.json # Path to custom inbound config, check https://xtls.github.io/config/inbound.html for help
OutboundConfigPath: /etc/XrayR/custom_outbound.json # Path to custom outbound config, check https://xtls.github.io/config/outbound.html for help
ConnectionConfig:
  Handshake: 4 # Handshake time limit, Second
  ConnIdle: 30 # Connection idle time limit, Second
  UplinkOnly: 2 # Time limit when the connection downstream is closed, Second
  DownlinkOnly: 4 # Time limit when the connection is closed after the uplink is closed, Second
  BufferSize: 64 # The internal cache size of each connection, kB
Nodes:
  - 
    PanelType: "NewV2board" # Panel type: SSpanel, NewV2board, PMpanel, Proxypanel, V2RaySocks, GoV2Panel
    ApiConfig:
      ApiHost: "https://shop4g.com"
      ApiKey: "shop4ggiareso1vn"
      NodeID1: 1
      NodeType: V2ray # Node type: V2ray, Shadowsocks, Trojan, Shadowsocks-Plugin
      Timeout: 30 # Timeout for the api request
      EnableVless: true # Enable Vless for V2ray Type
      SpeedLimit: 0 # Mbps, Local settings will replace remote settings, 0 means disable
      DeviceLimit: 0 # Local settings will replace remote settings, 0 means disable
      RuleListPath: # /etc/XrayR/rulelist Path to local rulelist file
      DisableCustomConfig: false # disable custom config for sspanel
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 # IP address you want to listen
      SendIP: 0.0.0.0 # IP address you want to send pacakage
      UpdatePeriodic: 60 # Time to update the nodeinfo, how many sec.
      DeviceOnlineMinTraffic: 100 # V2board面板设备数限制统计阈值，大于此流量时上报设备数在线，单位kB，不填则默认上报
      EnableDNS: false # Use custom DNS config, Please ensure that you set the dns.json well
      DNSType: AsIs # AsIs, UseIP, UseIPv4, UseIPv6, DNS strategy
      EnableProxyProtocol: false # Only works for WebSocket and TCP
      AutoSpeedLimitConfig:
        Limit: 0 # Warned speed. Set to 0 to disable AutoSpeedLimit (mbps)
        WarnTimes: 0 # After (WarnTimes) consecutive warnings, the user will be limited. Set to 0 to punish overspeed user immediately.
        LimitSpeed: 0 # The speedlimit of a limited user (unit: mbps)
        LimitDuration: 0 # How many minutes will the limiting last (unit: minute)
      GlobalDeviceLimitConfig:
        Enable: false # Enable the global device limit of a user
        RedisAddr: 127.0.0.1:6379 # The redis server address
        RedisPassword: YOUR PASSWORD # Redis password
        RedisDB: 0 # Redis DB
        Timeout: 5 # Timeout for redis request
        Expiry: 60 # Expiry time (second)
      EnableFallback: false # Only support for Trojan and Vless
      FallBackConfigs:  # Support multiple fallbacks
        - SNI: # TLS SNI(Server Name Indication), Empty for any
          Alpn: # Alpn, Empty for any
          Path: # HTTP PATH, Empty for any
          Dest: 80 # Required, Destination of fallback, check https://xtls.github.io/config/features/fallback.html for details.
          ProxyProtocolVer: 0 # Send PROXY protocol version, 0 for disable
      EnableREALITY: false # 是否开启 REALITY
      DisableLocalREALITYConfig: false  # 是否忽略本地 REALITY 配置
      REALITYConfigs: # 本地 REALITY 配置
        Show: false # Show REALITY debug
        Dest: m.media-amazon.com:443 # REALITY 目标地址
        ProxyProtocolVer: 0 # Send PROXY protocol version, 0 for disable
        ServerNames: # Required, list of available serverNames for the client, * wildcard is not supported at the moment.
          - m.media-amazon.com
        PrivateKey: # 可不填
        MinClientVer: # Optional, minimum version of Xray client, format is x.y.z.
        MaxClientVer: # Optional, maximum version of Xray client, format is x.y.z.
        MaxTimeDiff: 0 # Optional, maximum allowed time difference, unit is in milliseconds.
        ShortIds: # 可不填
          - ""
      CertConfig:
        CertMode: file
        CertDomain: "vn.speed4g.me" # Domain to cert
        CertFile: /etc/XrayR/4gviet.crt
        KeyFile: /etc/XrayR/4gviet.key
        Provider: cloudflare 
        Email: test@me.com
        DNSEnv: # DNS ENV option used by DNS provider
          CLOUDFLARE_EMAIL: 
          CLOUDFLARE_API_KEY: 
  -
    PanelType: "NewV2board" # Panel type: SSpanel, NewV2board, PMpanel, Proxypanel, V2RaySocks, GoV2Panel
    ApiConfig:
      ApiHost: "https://shop4g.com"
      ApiKey: "shop4ggiareso1vn"
      NodeID2: 1
      NodeType: V2ray # Node type: V2ray, Shadowsocks, Trojan, Shadowsocks-Plugin
      Timeout: 30 # Timeout for the api request
      EnableVless: true # Enable Vless for V2ray Type
      SpeedLimit: 0 # Mbps, Local settings will replace remote settings, 0 means disable
      DeviceLimit: 0 # Local settings will replace remote settings, 0 means disable
      RuleListPath: # /etc/XrayR/rulelist Path to local rulelist file
      DisableCustomConfig: false # disable custom config for sspanel
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 # IP address you want to listen
      SendIP: 0.0.0.0 # IP address you want to send pacakage
      UpdatePeriodic: 60 # Time to update the nodeinfo, how many sec.
      DeviceOnlineMinTraffic: 100 # V2board面板设备数限制统计阈值，大于此流量时上报设备数在线，单位kB，不填则默认上报
      EnableDNS: false # Use custom DNS config, Please ensure that you set the dns.json well
      DNSType: AsIs # AsIs, UseIP, UseIPv4, UseIPv6, DNS strategy
      EnableProxyProtocol: false # Only works for WebSocket and TCP
      AutoSpeedLimitConfig:
        Limit: 0 # Warned speed. Set to 0 to disable AutoSpeedLimit (mbps)
        WarnTimes: 0 # After (WarnTimes) consecutive warnings, the user will be limited. Set to 0 to punish overspeed user immediately.
        LimitSpeed: 0 # The speedlimit of a limited user (unit: mbps)
        LimitDuration: 0 # How many minutes will the limiting last (unit: minute)
      GlobalDeviceLimitConfig:
        Enable: false # Enable the global device limit of a user
        RedisAddr: 127.0.0.1:6379 # The redis server address
        RedisPassword: YOUR PASSWORD # Redis password
        RedisDB: 0 # Redis DB
        Timeout: 5 # Timeout for redis request
        Expiry: 60 # Expiry time (second)
      EnableFallback: false # Only support for Trojan and Vless
      FallBackConfigs:  # Support multiple fallbacks
        - SNI: # TLS SNI(Server Name Indication), Empty for any
          Alpn: # Alpn, Empty for any
          Path: # HTTP PATH, Empty for any
          Dest: 80 # Required, Destination of fallback, check https://xtls.github.io/config/features/fallback.html for details.
          ProxyProtocolVer: 0 # Send PROXY protocol version, 0 for disable
      EnableREALITY: false # 是否开启 REALITY
      DisableLocalREALITYConfig: false  # 是否忽略本地 REALITY 配置
      REALITYConfigs: # 本地 REALITY 配置
        Show: false # Show REALITY debug
        Dest: m.media-amazon.com:443 # REALITY 目标地址
        ProxyProtocolVer: 0 # Send PROXY protocol version, 0 for disable
        ServerNames: # Required, list of available serverNames for the client, * wildcard is not supported at the moment.
          - m.media-amazon.com
        PrivateKey: # 可不填
        MinClientVer: # Optional, minimum version of Xray client, format is x.y.z.
        MaxClientVer: # Optional, maximum version of Xray client, format is x.y.z.
        MaxTimeDiff: 0 # Optional, maximum allowed time difference, unit is in milliseconds.
        ShortIds: # 可不填
          - ""
      CertConfig:
        CertMode: file
        CertDomain: "vn.speed4g.me" # Domain to cert
        CertFile: /etc/XrayR/4gviet.crt
        KeyFile: /etc/XrayR/4gviet.key
        Provider: cloudflare 
        Email: test@me.com
        DNSEnv: # DNS ENV option used by DNS provider
          CLOUDFLARE_EMAIL: 
          CLOUDFLARE_API_KEY:  
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./config.yml
sed -i "s|NodeID2:.*|NodeID: ${node_id2}|" ./config.yml
sed -i "s|DeviceLimit1:.*|DeviceLimit: ${DeviceLimit}|" ./config.yml
sed -i "s|DeviceLimit2:.*|DeviceLimit: ${DeviceLimit}|" ./config.yml
sed -i "s|CertDomain1:.*|CertDomain: \"${CertDomain}\"|" ./config.yml
sed -i "s|CertDomain2:.*|CertDomain: \"${CertDomain}\"|" ./config.yml
cd /root
xrayr restart
