import { MetadataRoute } from 'next';

export default function robots(): MetadataRoute.Robots {
  const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://pixelsubz.lk';

  return {
    rules: [
      {
        userAgent: '*',
        allow: ['/', '/movies/*', '/request'],
        disallow: ['/admin', '/admin/*', '/api/*', '/_next/*'],
      },
      {
        userAgent: ['Googlebot', 'Bingbot', 'DuckDuckBot', 'Applebot', 'Yandex'],
        allow: ['/', '/movies/*', '/request'],
        disallow: ['/admin', '/admin/*', '/api/*'],
      },
    ],
    sitemap: `${baseUrl}/sitemap.xml`,
  };
}
