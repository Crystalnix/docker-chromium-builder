[![](https://badge.imagelayers.io/crystalnix/docker-chromium-builder:latest.svg)](https://imagelayers.io/?images=crystalnix/docker-chromium-builder:latest 'Get your own badge on imagelayers.io')

## Example

```shell
$ export CHROMIUM_SRC=~/chromium
$ docker pull crystalnix/docker-chromium-builder
$ docker create -v $CHROMIUM_SRC:/src --name chromium_src crystalnix/docker-chromium-builder /bin/true
$ docker run --rm -it --volumes-from=chromium_src  crystalnix/docker-chromium-builder
chromium@7c56f908616f:/src$ ninja -C out/Release
chromium@7c56f908616f:/src$ ./out/Release/base_unittests
```
