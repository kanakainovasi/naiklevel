import type { Metadata, Viewport } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: {
    default: "Naik Level — Aplikasi Belajar Anak Kurikulum Merdeka",
    template: "%s | Naik Level",
  },
  description:
    "Tingkatkan level prestasi anak usia 4-12 tahun (TK–SD Kelas 6) dengan latihan soal, olimpiade, dan raport bayangan berbasis Kurikulum Merdeka. Interaktif, gamified, dan ramah anak.",
  keywords: [
    "belajar anak",
    "kurikulum merdeka",
    "soal SD",
    "olimpiade OSN",
    "aplikasi edukasi",
    "latihan soal",
    "naik level",
    "TK",
    "SD",
  ],
  authors: [{ name: "Naik Level" }],
  openGraph: {
    type: "website",
    locale: "id_ID",
    url: "https://naiklevel.id",
    siteName: "Naik Level",
    title: "Naik Level — Aplikasi Belajar Anak Kurikulum Merdeka",
    description:
      "Tingkatkan level prestasi anak usia 4-12 tahun dengan latihan soal & olimpiade berbasis Kurikulum Merdeka.",
  },
  twitter: {
    card: "summary_large_image",
    title: "Naik Level — Aplikasi Belajar Anak Kurikulum Merdeka",
    description:
      "Tingkatkan level prestasi anak usia 4-12 tahun dengan latihan soal & olimpiade berbasis Kurikulum Merdeka.",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: "#0284c7",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="id">
      <head>
        <link rel="icon" href="/favicon.ico" sizes="any" />
        <meta name="application-name" content="Naik Level" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-title" content="Naik Level" />
      </head>
      <body>{children}</body>
    </html>
  );
}
