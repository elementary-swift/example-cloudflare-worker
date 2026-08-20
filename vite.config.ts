import { defineConfig, Plugin } from "vite";
import { cloudflare } from "@cloudflare/vite-plugin";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [
    cloudflare(),
    swiftWasm({
      // NOTE: remove this once https://github.com/swiftwasm/JavaScriptKit/issues/796 is fixed
      extraBuildArgs: ["--build-system=native"],
      useEmbeddedSDK: true,
    }),
  ],
});


