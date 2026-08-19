import { defineConfig, perEnvironmentPlugin } from "vite";
import { cloudflare } from "@cloudflare/vite-plugin";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [
    cloudflare(),
    perEnvironmentPlugin("swift-wasm", (environment) => {
      switch (environment.name) {
        case "elementaryui_cloudflare_worker_demo":
          return swiftWasm({
            extraBuildArgs: ["--build-system=native"],
            scratchPath: ".build/worker",
          });
        case "client":
          return swiftWasm({
            useEmbeddedSDK: true,
            extraBuildArgs: ["--build-system=native"],
          });
      }
    }),
  ],
});
