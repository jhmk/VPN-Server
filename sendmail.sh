#!/bin/bash
curl -s --user 'api:key-***********' \
    https://api.mailgun.net/v3/************.mailgun.org/messages \
    -F from='VPN Alert <mailgun@************.mailgun.org>' \
    -F to=YOUREMAIL \
    -F subject='VPN DOWN ON SERVER XYZ' \
    -F text='Looks like VPN is down and please restart it'
