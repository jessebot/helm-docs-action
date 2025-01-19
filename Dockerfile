# Use a clean tiny image to store artifacts in
FROM alpine:3

ARG GITHUB_WORKSPACE=/github/workspace
ENV GITHUB_WORKSPACE=${GITHUB_WORKSPACE}

RUN set -x \
    && apk update \
    && apk add --no-cache \
        bash \
        git \
        git-lfs \
        jq \
        openssh \
        sed \
        yq

RUN wget https://github.com/norwoodj/helm-docs/releases/download/v1.14.2/helm-docs_1.14.2_Linux_x86_64.tar.gz \
    && tar -xvf helm-docs_1.14.2_Linux_x86_64.tar.gz \
    && install ./helm-docs /usr/local/bin/

# Copy all needed files
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
WORKDIR ${GITHUB_WORKSPACE}
ENTRYPOINT ["/entrypoint.sh"]
