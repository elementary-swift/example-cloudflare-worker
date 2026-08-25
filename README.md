# Full-Stack Swift on Cloudflare

**Live demo: https://cloudflare-worker.examples.elementary.codes/**

## Run locally

Requires [Swiftly](https://github.com/swiftlang/swiftly) and [Node.js 24+](https://nodejs.org/en/download).

```sh
swiftly install
swift sdk install https://download.swift.org/swift-6.4.x-branch/wasm-sdk/swift-6.4.x-DEVELOPMENT-SNAPSHOT-2026-08-14-a/swift-6.4.x-DEVELOPMENT-SNAPSHOT-2026-08-14-a_wasm.artifactbundle.tar.gz --checksum 11fabfac6804222569d330fbbb5fa34eef736abda46790e723ac73b256fd1c7a
npm install
npm run dev
```

## Includes

- [ElementaryUI](https://elementary.codes) frontend app (Swift/WebAssembly)
- [Cloudflare Worker](https://developers.cloudflare.com/workers/) edge backend (Swift/WebAssembly)
- [BridgeJS](https://swiftpackageindex.com/swiftwasm/javascriptkit/documentation/javascriptkit/introducing-bridgejs) interop in the browser and worker
- Shared, typed JSON messages via ["NewCodable"](https://github.com/swiftlang/swift-foundation/tree/experimental/new-codable)
- [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) and [Cloudflare Worker handler](https://developers.cloudflare.com/workers/runtime-apis/handlers/fetch/)
- Vite [Cloudflare deployment](https://developers.cloudflare.com/workers/vite-plugin/)
