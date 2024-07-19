const { build } = require("esbuild");
const { dependencies, peerDependencies } = require('./package.json')
const sharedConfig = {
    entryPoints: ["src/index.ts"],
    bundle: true,
    minify: true,
    external: []//Object?.keys(dependencies)?.concat(Object?.keys(peerDependencies)) || '',
};
/*build({
    ...sharedConfig,
    platform: 'node', // for CJS
    outfile: "build/index.js",
});*/
build({
    ...sharedConfig,
    outfile: "build/index.mjs",
    platform: 'neutral', // for ESM
    format: "esm",
});