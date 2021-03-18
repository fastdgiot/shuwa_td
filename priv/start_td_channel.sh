#!/bin/bash
export PATH=$PATH:/usr/local/bin
workdir=`pwd`
echo  $workdir

systemctl stop {{shuwa_td_channel}}

rm /usr/lib/systemd/system/{{shuwa_td_channel}}.service  -rf
cat > /lib/systemd/system/{{shuwa_td_channel}}.service << "EOF"
[Unit]
Description={{shuwa_td_channel}}_service

[Service]
Type=simple
ExecStart=/usr/sbin/shuwa_td {{host}} {{channelid}} {{app}}
ExecReload=/bin/kill -HUP $MAINPID
KillMode=mixed
KillSignal=SIGINT
TimeoutSec=300
OOMScoreAdjust=-1000
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable {{shuwa_td_channel}}
systemctl start {{shuwa_td_channel}}



