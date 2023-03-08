# Statically linked git

> **⚠️ be careful**  
> It's not full git, it's built without curl and openssl support, you won't
> be able to clone repositories via http/s _(I'm still working on it)_  
> To work with SSH, you will need an SHH client, which can be taken
> from [static-openssh] or use the ready-made [CoreBox] solution

Statically linked [git] container image with [Bash]

> ~ 4,9M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-git:latest
ghcr.io/awesome-containers/static-git:2.39.2

docker.io/awesomecontainers/static-git:latest
docker.io/awesomecontainers/static-git:2.39.2
```

Slim statically linked [git] container image with [Bash] and packaged with [UPX]

> ~ 2,2M (578K bash)

```bash
ghcr.io/awesome-containers/static-git:latest-slim
ghcr.io/awesome-containers/static-git:2.39.2-slim

docker.io/awesomecontainers/static-git:latest-slim
docker.io/awesomecontainers/static-git:2.39.2-slim
```

[git]: https://github.com/git/git
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/
[CoreBox]: https://github.com/awesome-containers/corebox
[static-openssh]: https://github.com/awesome-containers/static-openssh

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_GIT_IMAGE="$image" \
  --build-arg STATIC_GIT_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
