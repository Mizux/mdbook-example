# Build image
FROM rust:latest AS builder

RUN set -xe; \
	apt-get update; \
	apt-get install -y musl musl-tools; \
	rm -rf /var/lib/apt/lists/*; \
	rustup target add x86_64-unknown-linux-musl;

# Install mdbook
# see: https://github.com/rust-lang/mdBook
ENV MDBOOK_VERSION=0.4.32
RUN set -xe; \
	cargo install --target x86_64-unknown-linux-musl mdbook --version ${MDBOOK_VERSION}; \
	mv /usr/local/cargo/bin/mdbook .; \
	rm -rf /usr/local/cargo/registry;

# Plugins
## mdbook-admonish
## see: https://github.com/tommilligan/mdbook-admonish
RUN set -xe; \
  cargo install --target x86_64-unknown-linux-musl mdbook-admonish; \
	mv /usr/local/cargo/bin/mdbook-admonish .; \
	rm -rf /usr/local/cargo/registry;

## mermaid plugin
## see: https://github.com/badboy/mdbook-mermaid
RUN set -xe; \
  cargo install --target x86_64-unknown-linux-musl mdbook-mermaid; \
	mv /usr/local/cargo/bin/mdbook-mermaid .; \
	rm -rf /usr/local/cargo/registry;

# Prod image
FROM alpine:latest AS mdbook

ENV MDBOOK_HOME=/opt/mdbook
ENV PATH="${MDBOOK_HOME}/bin:${PATH}"

COPY --from=builder ./mdbook ${MDBOOK_HOME}/bin/
COPY --from=builder ./mdbook-admonish ${MDBOOK_HOME}/bin/
COPY --from=builder ./mdbook-mermaid ${MDBOOK_HOME}/bin/
