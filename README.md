# arm-beats

![](https://badgen.net/github/release/vrince/arm-beats)


Automated Elastic `filebeat`, `metricbeat`, `heartbeat` & `packagebeat` builds for `linux/armv7` & `linux/armv6` on `debian buster`.

## Goal

Currently elasticsearch team do not provide any `arm32` (`armv7` / `armv6`) builds, this repo provides those.

Originally this is meant to make `filebeat` work on `raspberry pi`.

[official builds](https://www.elastic.co/downloads/past-releases)

## Run `filebeat` on a raspberry pi

```bash
wget https://github.com/vrince/arm-beats/releases/download/v7.16.3/filebeat-7.16.3-linux-armv7l.tar.gz
tar -xf filebeat-7.16.3-linux-armv7l.tar.gz
cd filebeat-7.16.3-linux-armv7l
file ./filebeat
```

Should return:

```bash
./filebeat: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, Go BuildID=q4tFca9OleP0Dj0JFsYO/wQvX_IvIiVb7CA7NFq-6/-Rsiwc2soS0qHYJ-YXvB/uOnOPHVTGBXMRzHgpC_p, BuildID[sha1]=0e3df053441d84a4a3e6aa3de827bd6984c2dd3a, not stripped
```

For more information about how to configure `filebeat` --> [documentation](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-overview.html)

## Run `metricbeat` on raspberry pi

```bash
wget https://github.com/vrince/arm-beats/releases/download/v7.16.3/metricbeat-7.16.3-linux-armv7l.tar.gz
tar -xf metricbeat-7.16.3-linux-armv7l.tar.gz
cd metricbeat-7.16.3-linux-armv7l
file ./metricbeat
```

Should return:

```bash
./metricbeat: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, Go BuildID=KYjs2CEqzT9uxFYhahi8/A1OvIW-ClpB3kNBN-iU3/QZUh6d5es2uGo50jjYgF/i5J85A49bJtxHOYThpA7, BuildID[sha1]=6e5aa658d895ea6c01e21286b29faaedd658803f, not stripped
```

For more information about how to configure `metricbeat` --> [documentation](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html)

## Builds

[![CI](https://github.com/vrince/arm-beats/actions/workflows/beats.yml/badge.svg)](https://github.com/vrince/arm-beats/actions/workflows/beats.yml)

Uses emulated (`qemu`) multi-arch capability of docker. Performance is really not that great, so those builds only perform `go get` to build necessary binary file. Finally official elasticsearch official  (arm64) corresponding beat package is patch by swapping the main binary.

## Reference

* Elastic beat : https://www.elastic.co/beats/
* Built from source : https://github.com/elastic/beats
