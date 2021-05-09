FROM scratch
MAINTAINER Mucahit Buyukyilmaz<mucahit@yartu.io>
ADD rocky-8-docker.tar.xz /

LABEL \
    org.label-schema.schema-version="1.0" \
    org.label-schema.name="Rocky Linux Base Image" \
    org.label-schema.vendor="Rocky" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20210509" \
    org.opencontainers.image.title="Rocky Linux Base Image" \
    org.opencontainers.image.vendor="Rocky" \
    org.opencontainers.image.licenses="GPL-2.0-only" \
    org.opencontainers.image.created="2021-05-09 00:00:00+03:00"

CMD ["/bin/bash"]
