import { init } from "virtual:swift-wasm?js&module&product=Worker";

let exports;

export default {
  async fetch(request, env, ctx) {
    exports ??= (await init()).exports;
    return exports.fetch(request);
  },
};
