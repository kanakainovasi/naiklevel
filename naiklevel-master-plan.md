# Naik Level — Master Plan

*Dokumen acuan tunggal sebelum eksekusi development. Update terakhir: 11 Agustus 2026.*

## 1. Visi & Misi
Aplikasi belajar untuk anak usia 4-12 tahun (TK A - SD Kelas 6), mencakup semua mata pelajaran sesuai **Kurikulum Merdeka**. Tujuan: membantu orang tua mendampingi anak belajar di rumah, di tengah tren penurunan kualitas pembelajaran TK/SD dibanding 20-30 tahun lalu, sekaligus mengubah waktu screen time anak jadi produktif.

## 2. Struktur Hierarki Konten

```
Jenjang (TK A, TK B, SD Kelas 1–6)
  └── Mata Pelajaran / Aspek Perkembangan
        └── Elemen / Domain (sesuai CP resmi Kurikulum Merdeka)
              └── Topik / Bab
                    └── Konten Belajar
                          ├── Latihan Soal (±80%, waktu bebas, nilai + breakdown per elemen)
                          ├── Soal Olimpiade (±20%, dengan timer, level menantang)
                          └── Photo Submission (opsional, hanya untuk topik yang butuh hardcopy, misal Seni Budaya)
```

**Progress dikelola per kelas individual** (bukan per Fase), meski data Elemen/Domain tetap disimpan untuk mapping ke CP resmi per Fase (A/B/C) — berguna untuk pelaporan formal ke orang tua.

### Catatan kurikulum penting: TK vs SD
- **TK A/B**: tidak pakai "mata pelajaran" formal, tapi **6 Aspek Perkembangan (STPPA)**. Di UI dibungkus label familiar untuk orang tua (lihat mapping di bawah), tapi backend tetap merujuk aspek resmi.
- **SD Kelas 1-6**: pakai mata pelajaran resmi Kurikulum Merdeka per Fase (A: kelas 1-2, B: kelas 3-4, C: kelas 5-6).

| Label di App (TK) | Aspek Perkembangan Resmi |
|---|---|
| Mengenal Huruf & Membaca | Dasar-dasar Literasi |
| Berhitung & Angka | Dasar-dasar Matematika |
| Sains & Alam Sekitar | Dasar-dasar Sains, Teknologi, Rekayasa |
| Kreativitas & Seni | Seni |
| Budi Pekerti & Kebiasaan Baik | Nilai Agama & Budi Pekerti |
| Mandiri & Bersosialisasi | Jati Diri |

## 3. Fitur Inti
- **Latihan Soal**: tanpa tekanan waktu, hasil nilai ditampilkan lengkap dengan breakdown per Elemen/Domain (bukan cuma nilai akhir), riwayat nilai tersimpan per sesi (bukan cuma nilai terakhir)
- **Soal Olimpiade** (~20% dari total soal): pakai timer, melatih kecepatan berpikir gaya OSN/KSN
- **Take a Picture**: fitur opsional per topik, untuk mapel yang butuh hasil kerja hardcopy (misal Seni Budaya); tidak wajib ada di semua mapel
- **Gamifikasi** (inti brand "Naik Level"):
  - XP dari tiap soal selesai (olimpiade beri XP lebih besar)
  - Level anak terpisah dari kelas sekolah — anak rajin latihan tetap termotivasi naik level walau kelas sekolah sama
  - Badge/lencana per pencapaian (contoh: "Juara Bilangan", "Berani Tantangan", "Konsisten"/streak harian)
  - Visual dominan untuk TK (animasi, suara, bintang — minim teks/angka); boleh lebih kompleks untuk SD atas
- **Raport Bayangan** (triwulanan, per 3 bulan): laporan otomatis untuk orang tua berisi kekuatan & kekurangan anak per Elemen/Domain, berdasarkan akumulasi hasil Latihan Soal & Soal Olimpiade selama periode tersebut

## 4. Akun & Privasi
- 1 akun orang tua → multi-profil anak (mendukung keluarga dengan >1 anak, beda jenjang)
- Dashboard orang tua terpisah dari tampilan anak: progres, nilai per elemen, waktu belajar harian, badge
- Kontrol orang tua: batas waktu penggunaan harian
- **Kepatuhan UU PDP** (wajib sejak awal, bukan nanti): consent orang tua saat registrasi, minimalisasi data pribadi anak, kebijakan privasi eksplisit soal data anak, foto (take-a-picture) tidak publik/tidak bisa diakses user lain

## 5. Model Bisnis: Freemium
- **Gratis**: semua Latihan Soal reguler, semua jenjang & mapel (mendukung growth organik & SEO)
- **Berbayar** (langganan, harga terjangkau): Soal Olimpiade, laporan progres detail, tema/badge eksklusif, multi-anak dalam 1 akun

## 6. Strategi Produksi Konten (bertahap)
1. **Fase MVP**: draft soal dibuat dengan bantuan AI sesuai CP per elemen → divalidasi sendiri, fokus ke scope MVP dulu (lihat bagian 7)
2. **Setelah traction**: rekrut 1-2 guru freelance sebagai reviewer kurikulum untuk kredibilitas
3. Ekspansi jenjang/mapel dilakukan bertahap, tidak sekaligus semua

## 7. Scope MVP & Urutan Build

**Perubahan strategi**: bukan lagi breadth-first (semua jenjang sekaligus tipis). Sekarang **sequential per jenjang, tiap jenjang tuntas semua mapel** sebelum lanjut ke jenjang berikutnya. Urutan build:

```
1. SD Kelas 1  (semua mapel, lengkap — sekaligus flagship SEO)
2. TK A        (semua aspek perkembangan, lengkap)
3. TK B        (semua aspek perkembangan, lengkap)
4. SD Kelas 2  (semua mapel, lengkap)
5. SD Kelas 3
6. SD Kelas 4
7. SD Kelas 5
8. SD Kelas 6
```

**Alasan urutan ini**: SD Kelas 1 dikerjakan lebih dulu karena sekaligus menjadi flagship SEO (lihat di bawah) — jadi tidak ada lagi konflik antara urutan build dan prioritas SEO seperti versi sebelumnya. Setelah SD Kelas 1 tuntas, mundur ke TK A & TK B (fondasi paling dasar), baru lanjut naik ke SD Kelas 2 dst.

**Minimum konten per mapel**: setiap mapel di tiap jenjang wajib punya **minimal 60 soal** (gabungan Latihan Soal + Soal Olimpiade), supaya anak bisa mengulang latihan dengan soal yang berbeda-beda tiap kali, bukan soal yang itu-itu saja.

### Flagship SEO: SD Kelas 1 — Matematika
- Karena SD Kelas 1 adalah jenjang pertama yang dibangun **lengkap** (bukan tipis), Matematika Kelas 1 otomatis jadi konten paling dalam & lengkap duluan — cocok sebagai target ranking SEO pertama
- Alasan flagship ini penting: Google merangking konten dalam/lengkap per topik, bukan halaman tipis tersebar

### SEO Teknis (wajib dari hari 1)
- Web pakai SSR/SSG (bukan pure client-side SPA) agar Google bisa crawl
- Structured data (schema.org), sitemap.xml, meta tags per halaman
- Tiap topik/bab idealnya punya landing page publik (tidak di-lock login) agar ditemukan lewat pencarian organik
- Ekspektasi realistis: ranking halaman 1 butuh waktu (~3-6 bulan+ setelah publish konsisten), bukan instan saat launch

## 8. Tech Stack
| Layer | Pilihan | Alasan |
|---|---|---|
| Web | Next.js (React, SSR/SSG) | SEO-friendly, ekosistem besar |
| Mobile | React Native | Share logic & UI dengan web via monorepo, 1 skillset (JS/TS) untuk tim kecil |
| Shared | Monorepo (misal Turborepo): logic soal, state gamifikasi, API client | Efisiensi & konsistensi lintas platform |
| Backend | Supabase (DB Postgres + Auth + Storage all-in-one) | Kurangi beban DevOps untuk tim kecil |
| Storage foto | Supabase Storage / Cloudflare R2 | Murah untuk file gambar |

*Catatan: stack ini rekomendasi awal — perlu disesuaikan/dicek ulang begitu kode existing di `C:\Users\LENOVO\naiklevel` direview, kalau ternyata sudah pakai stack berbeda.*

## 9. Peluncuran
- Web dan mobile app diluncurkan **bersamaan**, setelah SD Kelas 1 (jenjang pertama di urutan build) tuntas sebagai basis awal
- Data hemat kuota: konten teks + gambar ringan (bukan video), cache soal di mobile untuk latihan offline, sync progres saat online

## 10. Belum Diputuskan / Perlu Ditindaklanjuti
- [ ] Riset kata kunci detail untuk validasi/prioritas flagship SEO
- [ ] Nama domain & branding visual (logo, maskot, palet warna resmi)
- [ ] Daftar lengkap Elemen/Domain per mapel per jenjang (breakdown CP resmi)
- [ ] Rencana testing/QA sebelum rilis
- [ ] Strategi pemasaran di luar SEO (media sosial, komunitas orang tua, dll)
- [ ] Payment gateway untuk model berlangganan
- [ ] Review kode existing di folder lokal untuk menyesuaikan/migrasi ke stack rekomendasi
