# Sub-Store

Sub-Store is a self-hosted subscription management backend supporting formats used by Quantumult X, Loon, Surge, Stash, Egern, Shadowrocket, Clash.Meta, sing-box, and more.

## Usage

- The container listens on port `3000`; the host port can be changed during installation.
- Data is persisted in the application's `data` directory. Back it up before uninstalling or upgrading.
- When using the official frontend at `https://sub-store.vercel.app/`, set the backend path to `/sub-store` and add the frontend origin to the CORS allowlist. Use `*` only when appropriate.
- With the backend path enabled, an API URL looks like `http://server-address:port/sub-store/api/`.

## Security

Subscription data may contain node addresses, credentials, and access tokens. Use an HTTPS reverse proxy and replace `*` with the actual frontend origin in production.

Documentation: [Sub-Store Wiki](https://github.com/sub-store-org/Sub-Store/wiki)

