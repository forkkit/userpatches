#!/bin/bash
# set date to UTC
timedatectl set-timezone UTC

# check to see if download is still in progress
if systemctl status | grep wget | grep digitalocean; then
  echo "download is taking a long time" >> /root/logs
  exit 1
fi

# check if service is installed
systemctl is-active --quiet deviceplane-agent.service && echo deviceplane running >> /root/logs && crontab -r 


case "$(curl -k -s --max-time 3 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
  [23]) echo "HTTP connectivity is up" >> /root/logs && cat /root/deviceplane.sh | VERSION=1.16.0 PROJECT=prj_1gh85hT2F6qmPZryKM9b2ib5Zsd REGISTRATION_TOKEN=drt_1gh85ef2BtrXa7fcIHmxSmgdQ9c CONTROLLER=https://deviceplane.novachat-helsinki.kubesail-ops.com/api bash ;;
  5) echo "The web proxy won't let us through" >> /root/logs;;
  *) echo "The network is down or very slow" >> /root/logs ;;
esac

date >> /root/logs