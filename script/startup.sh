#!/usr/bin/env bash
/usr/sbin/sshd

exec sudo -u jupyter /start_jupyter_lab.sh
