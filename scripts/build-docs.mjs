import { spawnSync } from "node:child_process";

function run(cmd, args) {
  const res = spawnSync(cmd, args, { stdio: "inherit", shell: false });
  if (res.error) throw res.error;
  if (res.status !== 0) process.exit(res.status ?? 1);
}

const skip = String(process.env.SKIP_DOCS ?? "").toLowerCase();
if (["1", "true", "yes"].includes(skip)) {
  console.log("[docs] SKIP_DOCS set; skipping mkdocs build.");
  process.exit(0);
}

console.log("[docs] Installing mkdocs dependencies...");
run("python", ["-m", "pip", "install", "--disable-pip-version-check", "--no-cache-dir", "-r", "docs/requirements.txt"]);

console.log("[docs] Building mkdocs into public/docs...");
run("python", ["-m", "mkdocs", "build", "-f", "mkdocs.yml", "-d", "public/docs", "--clean"]);

console.log("[docs] Done.");
