## openldap-exporter

[openldap-exporter](https://github.com/tomcz/openldap_exporter)

### openldap server配置
_slapd_ supports an optional LDAP monitoring interface you can use to obtain information regarding the current state of your _slapd_ instance. Documentation for this backend can be found in the OpenLDAP [backend guide](http://www.openldap.org/doc/admin24/backends.html#Monitor) and [administration guide](http://www.openldap.org/doc/admin24/monitoringslapd.html).

To enable the backend add the following to the bottom of your `slapd.conf` file:

```
database monitor
rootdn "cn=monitoring,cn=Monitor"
rootpw YOUR_MONITORING_ROOT_PASSWORD
```

Technically you don't need `rootdn` or `rootpw`, but having unauthenticated access to _slapd_ feels a little wrong.

You may need to also load the monitoring backend module if your _slapd_ installation needs to load backends as modules by adding this to your `slapd.conf`:

```
moduleload  back_monitor
```

### 构建
```bash
TAG="handsomexu/openldap-exporter:v2.2.2"
docker build -t ${TAG} .
```

### 运行
```bash
#对localhost:389上运行的openldap server进行监控
docker run -dit --restart always --name openldap-exporter -p 9330:9330 ${TAG}

#指定openldap server地址及认证密码
docker run -dit --restart always --name openldap-exporter -p 9330:9330 ${TAG} --ldapAddr 192.168.5.22:389 --ldapUser cn=root,dc=handsomexu,dc=com --ldapPass password

# 运行日志
docker logs -f --tail=200 openldap-exporter
```