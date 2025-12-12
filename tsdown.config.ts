import { defineConfig } from 'tsdown'

const config = defineConfig({
  entry: ['src/app/main.ts'],
  format: 'es',
  platform: 'node',
  outDir: 'dist',
  clean: true,
  minify: true,
  treeshake: true,
  sourcemap: false,
  dts: false,
  skipNodeModulesBundle: true,
  tsconfig: './tsconfig.json',
})

export default config
