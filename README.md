# arm-beats

![](https://badgen.net/github/release/vrince/arm-beats)


Automated Elastic `filebeat`, `metricbeat`, `heartbeat` & `packagebeat` builds for `linux/armv7` & `linux/armv6` on `debian buster`.

## Goal

Currently elasticsearch team do not provide any `arm32` (`armv7` / `armv6`) builds, this repo provides those.

Originally this is meant to make `filebeat` work on `raspberry pi`.

[official builds](https://www.elastic.co/downloads/past-releases)

### Builds

[![CI](https://github.com/vrince/arm-beats/actions/workflows/beats.yml/badge.svg)](https://github.com/vrince/arm-beats/actions/workflows/beats.yml)

Uses emulated (`qemu`) multi-arch capability of docker. Performance is really not that great, so those builds only perform `go get` to build necessary binary file. Finally official elasticsearch official  (arm64) corresponding beat package is patch by swapping the main binary.

## Reference

* Elastic beat : https://www.elastic.co/beats/
* Built from source : https://github.com/elastic/beats
