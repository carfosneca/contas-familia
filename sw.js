const CACHE = 'cmf-v2';
const ASSETS = [
  '/contas-familia/',
  '/contas-familia/index.html',
  '/contas-familia/manifest.json',
  '/contas-familia/icon-192.png',
  '/contas-familia/icon-512.png',
];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(caches.keys().then(keys =>
    Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
  ).then(() => self.clients.claim()));
});

self.addEventListener('fetch', e => {
  // Nunca cacheia requisições para Supabase ou API externa
  const url = e.request.url;
  if (url.includes('supabase.co') || url.includes('anthropic.com') || url.includes('jsdelivr.net')) {
    e.respondWith(fetch(e.request));
    return;
  }
  e.respondWith(caches.match(e.request).then(r => r || fetch(e.request).then(res => {
    const clone = res.clone();
    caches.open(CACHE).then(c => c.put(e.request, clone));
    return res;
  })));
});
