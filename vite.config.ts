import { defineConfig } from "vite";
import { cloudflare } from "@cloudflare/vite-plugin";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [
    cloudflare(),
    {
      ...swiftWasm({
        useEmbeddedSDK: true,
        scratchPath: ".build/worker",
        extraBuildArgs: ["--build-system=native"],
      }),
      name: "swift-wasm-worker",
      applyToEnvironment: (environment) =>
        environment.name === "elementary_swift_full_stack",
    },
    {
      ...swiftWasm({
        useEmbeddedSDK: true,
        extraBuildArgs: ["--build-system=native"],
      }),
      name: "swift-wasm-client",
      applyToEnvironment: (environment) => environment.name === "client",
    },
  ],
});
