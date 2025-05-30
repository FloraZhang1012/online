import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import path from "path"; // ⬅️ 确保这里有 `path`

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "src"), // ⬅️ 让 `@` 指向 `src` 目录
    },
  },
});
