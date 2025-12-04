import { defineConfig } from 'tsup'

const config = defineConfig({
  entry: ['src/app/main.ts'],
  format: ['esm'],
  target: 'es2022',
  platform: 'node',
  outDir: 'dist',
  clean: true,
  minify: true,
  treeshake: true,
  sourcemap: false,
  dts: false,
  splitting: false,
  skipNodeModulesBundle: true,
})

export { config }

export default config
