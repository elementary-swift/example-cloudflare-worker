import { defineConfig } from "vite";
import { cloudflare } from "@cloudflare/vite-plugin";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [
    cloudflare(),
    swiftWasm({ useEmbeddedSDK: true }),
  ],
});


