# arm-beats

Automated Elastic `filebeat`, `metricbeat`, `heartbeat` & `packagebeat` builds for `linux/armv7` & `linux/armv6` on `debian buster`.

## Goal

Currently elastic do not provide any `arm32` (`armv7` / `armv6`) builds, this repo provides those builds.

Originally this is meant to make `filebeat` work on `raspberry pi`, being at it added more `beats`.

### Builds

[![CI](https://github.com/vrince/arm-beats/actions/workflows/beats.yml/badge.svg)](https://github.com/vrince/arm-beats/actions/workflows/beats.yml)

[![](http://github-actions.40ants.com/vrince/arm-beats/matrix.svg)](https://github.com/vrince/arm-beats)
## How it works

Use emulated (`qemu`) multi-arch capability of docker. Performance is really not that great, so those builds only perform `go get` to build necessary binary file. Finally official elasticsearch corresponding beat package is patch by swapping main binary.

## Reference

* Elastic beat : https://www.elastic.co/beats/
* Built from source : https://github.com/elastic/beats
