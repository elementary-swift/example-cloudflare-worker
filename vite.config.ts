import { defineConfig, Plugin } from "vite";
import { cloudflare } from "@cloudflare/vite-plugin";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [
    cloudflare({
      viteEnvironment: { name: "worker" }
    }),
    swiftWasmForEnvironment("worker", { useEmbeddedSDK: true, scratchPath: ".build-worker", }),
    swiftWasmForEnvironment("client", { useEmbeddedSDK: true }),
  ],
});

function swiftWasmForEnvironment(
  environment: string,
  options?: Parameters<typeof swiftWasm>[0],
): Plugin {
  return {
    ...swiftWasm({
      // NOTE: remove this once https://github.com/swiftwasm/JavaScriptKit/issues/796 is fixed
      extraBuildArgs: ["--build-system=native"],
      ...options,
    }),
    applyToEnvironment: (e) => e.name === environment,
  } as Plugin;
}
