#!/bin/bash

sed -i "s|\$sed\.NEWRELIC_LICENSE|$NEWRELIC_LICENSE|g; \
  s|\$sed\.NEWRELIC_APP|$NEWRELIC_APP|g; \
  s|\$sed\.NGINX_STATUS_URL|$NGINX_STATUS_URL|g" /etc/nginx-nr-agent/nginx-nr-agent.ini \
  && service nginx-nr-agent start \
  && tail -f /var/log/nginx-nr-agent.log
