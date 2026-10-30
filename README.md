# Full-Stack Swift on Cloudflare

**Live demo: https://cloudflare-worker.examples.elementary.codes/**

## Run locally

Requires [Swiftly](https://github.com/swiftlang/swiftly) and [Node.js 24+](https://nodejs.org/en/download).

```sh
swiftly install
swift sdk install https://download.swift.org/swift-6.4.2-release/wasm-sdk/swift-6.4.2-RELEASE/swift-6.4.2-RELEASE_wasm.artifactbundle.tar.gz --checksum 83baca83553f8c443cda7b84800912e6e709c3acd2e7ebf277794ca5836c0da5
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
