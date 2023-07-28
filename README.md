# MDBook Example 

## Build mdbook

First generate the mdbook (mdbook-mermaid mdbook-admonish) in a container

```sh
docker build -t mdbook .
```

## Init mdbook
```
docker run --rm -u=$UID:$GID -v $(pwd):/data mdbook:latest mdbook init /data
docker run --rm -u=$UID:$GID -v $(pwd):/data mdbook:latest mdbook-admonish install /data
docker run --rm -u=$UID:$GID -v $(pwd):/data mdbook:latest mdbook-mermaid install /data
```

## Usage

```sh
docker run --rm -u=$UID:$GID -v $(pwd):/data mdbook:latest mdbook build /data
```

note: You can use `--dest-dir docs/` to output it in `docs/` dir

## References

* https://github.com/rust-lang/mdBook
* https://github.com/tommilligan/mdbook-admonish
* https://github.com/badboy/mdbook-mermaid

