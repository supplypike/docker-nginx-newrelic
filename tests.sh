#!/usr/bin/env bash -e

img=nr
config_path=/etc/nginx-nr-agent/nginx-nr-agent.ini

e_license=foo
e_app=bar
e_url=http://demo.nginx.com/status


function run {
  docker build -t $img .
  test_sed
  test_service

  # TODO: probably should cleanup when tests fail too.
  docker rmi $img

  echo "All tests passed!"
}


function test_sed {
  echo "[+] test_sed"
  docker run -d --name=$img -e "NEWRELIC_LICENSE=$e_license" \
    -e "NEWRELIC_APP=$e_app" \
    -e "NGINX_STATUS_URL=$e_url" $img

  docker exec $img bash -c "grep -q newrelic_license_key=$e_license $config_path \
      || (echo 'NEWRELIC_LICENSE not found' && exit 1)"
  docker exec $img bash -c "grep -q name=$e_app $config_path \
      || (echo 'NEWRELIC_APP not found' && exit 1)"
  docker exec $img bash -c "grep -q url=$e_url $config_path \
      || (echo 'NGINX_STATUS_URL not found' && exit 1)"

  docker kill $img; docker rm $img
}


function test_service {
  echo "[+] test_service"
  docker run -d --name=$img -e "NEWRELIC_LICENSE=$e_license" \
    -e "NEWRELIC_APP=$e_app" \
    -e "NGINX_STATUS_URL=$e_url" $img

  sleep 3

  s=nginx-nr-agent
  docker exec $img bash -c "[[ \$(service $s status) == '$s is running.' ]] \
      || (echo '$s is not running' && exit 1)"

  docker kill $img; docker rm $img
}

run
