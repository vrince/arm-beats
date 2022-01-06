# arm-beats

![](https://badgen.net/github/release/vrince/arm-beats)


Automated Elastic `filebeat`, `metricbeat`, `heartbeat` & `packagebeat` builds for `linux/armv7` & `linux/armv6` on `debian buster`.

## Goal

Currently elasticsearch team do not provide any `arm32` (`armv7` / `armv6`) builds, this repo provides those.

Originally this is meant to make `filebeat` work on `raspberry pi`.

[official builds](https://www.elastic.co/downloads/past-releases)

## Run `filebeat` on a rasperry pi 3

```bash
wget https://github.com/vrince/arm-beats/releases/download/v7.16.2/filebeat-7.16.2-linux-armv7l.tar.gz
tar -xf filebeat-7.16.2-linux-armv7l.tar.gz
cd filebeat-7.16.2-linux-armv7l
./filebeat version
```

This should return :

```bash
filebeat version 7.16.2 (arm), libbeat 7.16.2 [unknown built unknown]
```

For more infor about how to configure `filebeat` --> [documentation](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-overview.html)

## Builds

[![CI](https://github.com/vrince/arm-beats/actions/workflows/beats.yml/badge.svg)](https://github.com/vrince/arm-beats/actions/workflows/beats.yml)

Uses emulated (`qemu`) multi-arch capability of docker. Performance is really not that great, so those builds only perform `go get` to build necessary binary file. Finally official elasticsearch official  (arm64) corresponding beat package is patch by swapping the main binary.

## Reference

* Elastic beat : https://www.elastic.co/beats/
* Built from source : https://github.com/elastic/beats
