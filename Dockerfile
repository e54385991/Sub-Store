# syntax=docker/dockerfile:1.7

ARG NODE_VERSION=26.5.0

# The output is architecture-independent JavaScript; keep Node build steps native
# so multi-platform builds do not depend on emulated Node processes.
FROM --platform=$BUILDPLATFORM node:${NODE_VERSION}-alpine AS build

WORKDIR /app/backend

RUN npm install --global pnpm@11.0.9

COPY backend/package.json backend/pnpm-lock.yaml backend/pnpm-workspace.yaml ./
COPY backend/.babelrc backend/jsconfig.json ./
COPY backend/patches ./patches

RUN pnpm install --frozen-lockfile

COPY backend/bundle-esbuild.js backend/dev-esbuild.js backend/esbuild-dev.js ./
COPY backend/src ./src

RUN mkdir -p dist \
    && pnpm bundle:esbuild \
    && test -s dist/sub-store.bundle.js

FROM node:${NODE_VERSION}-alpine AS runtime

ENV NODE_ENV=production \
    SUB_STORE_DATA_BASE_PATH=/opt/app/data \
    SUB_STORE_BACKEND_API_HOST=0.0.0.0 \
    SUB_STORE_BACKEND_API_PORT=3000

RUN apk add --no-cache su-exec

RUN addgroup -S substore \
    && adduser -S -G substore -h /opt/sub-store substore \
    && mkdir -p /opt/sub-store /opt/app/data \
    && chown -R substore:substore /opt/sub-store /opt/app/data

WORKDIR /opt/sub-store

COPY --from=build --chown=substore:substore \
    /app/backend/dist/sub-store.bundle.js \
    /opt/sub-store/sub-store.bundle.js

COPY docker/entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD node -e "const net=require('net');const s=net.connect(3000,'127.0.0.1',()=>s.end());s.on('error',()=>process.exit(1))"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["node", "/opt/sub-store/sub-store.bundle.js"]
