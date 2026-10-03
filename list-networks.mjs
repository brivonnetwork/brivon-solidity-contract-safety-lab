const baseUrl = process.env.BRIVON_API_BASE_URL?.trim();
const publicAppKey = process.env.BRIVON_PUBLIC_APP_KEY?.trim();
if (!baseUrl || !publicAppKey) {
  throw new Error("Set BRIVON_API_BASE_URL and BRIVON_PUBLIC_APP_KEY in .env.");
}

const url = new URL(baseUrl);
if (url.protocol !== "https:" || url.username || url.password || url.search || url.hash) {
  throw new Error("BRIVON_API_BASE_URL must be a credential-free HTTPS URL.");
}

const response = await fetch(new URL("/v1/networks", url), {
  signal: AbortSignal.timeout(15_000),
  headers: {
    Accept: "application/json",
    "X-API-Key": publicAppKey,
  },
});
const bytes = new Uint8Array(await response.arrayBuffer());
if (bytes.byteLength > 256 * 1024) throw new Error("The API response was too large.");
let payload;
try {
  payload = JSON.parse(new TextDecoder().decode(bytes));
} catch {
  throw new Error("The API returned an invalid JSON response.");
}
if (!response.ok) {
  throw new Error(response.status + " " + (payload?.error?.message ?? "Network lookup failed."));
}
if (!Array.isArray(payload?.data)) {
  throw new Error("The API returned no network catalogue.");
}

console.log(JSON.stringify({
  networks: payload.data,
  message: "Read-only catalogue lookup. No deployment or transaction was sent.",
}, null, 2));
