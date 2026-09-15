FROM node:22-bookworm-slim AS build

WORKDIR /app

COPY package.json package-lock.json .npmrc ./
COPY scripts ./scripts
RUN npm ci --include=dev --include=optional --no-audit --no-fund

COPY . .
RUN npm run build

FROM node:22-bookworm-slim AS runtime

WORKDIR /app
ENV NODE_ENV=production
ENV PORT=8787
ENV SITES_RUNTIME_ROOT=/app/data/runtime

COPY --from=build /app/package.json /app/package-lock.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/drizzle ./drizzle
COPY --from=build /app/scripts ./scripts
COPY docker/start.sh /usr/local/bin/start-crm

RUN chmod +x /usr/local/bin/start-crm

VOLUME ["/app/data"]
EXPOSE 8787

CMD ["/usr/local/bin/start-crm"]
