# nginx-newrelic

[![](https://img.shields.io/docker/pulls/casestack/nginx-newrelic.svg?maxAge=2592000?style=plastic)](https://hub.docker.com/r/casestack/nginx-newrelic/)
[![](https://img.shields.io/docker/automated/casestack/nginx-newrelic.svg?maxAge=2592000)](https://hub.docker.com/r/casestack/nginx-newrelic/builds/)
[![](https://images.microbadger.com/badges/image/casestack/nginx-newrelic.svg)](https://microbadger.com/images/casestack/nginx-newrelic)

Docker image for the Nginx NewRelic plugin. More info about the plugin
[here](https://blog.newrelic.com/2014/10/17/nginx-new-relic-plugin/) and [here](https://newrelic.com/plugins/nginx-inc/13).

## Usage

```
$ docker run -e "NEWRELIC_LICENSE=foo" \
    -e "NEWRELIC_APP=foo" \
    -e "NGINX_STATUS_URL=foo" \
    casestack/nginx-newrelic
```

After a few seconds the data will be available in your NewRelic dashboard -> Plugins -> Nginx.

* **NEWRELIC_LICENSE**: NewRelic-generated license key token for your account. Get this from [here](https://newrelic.com/plugins/nginx-inc/13).
* **NEWRELIC_APP**: application name for NewRelic UI
* **NGINX_STATUS_URL**: full URL to a Nginx [stub status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html#stub_status)
    or JSON [status](http://nginx.org/en/docs/http/ngx_http_status_module.html#status)

Sample nginx.conf:

```
location = /basic-status {
  stub_status on;
  access_log off;
}
```

## License

MIT
