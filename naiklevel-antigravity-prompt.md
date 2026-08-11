# Prompt untuk Google Antigravity — Eksekusi "Naik Level"

Cara pakai: buka project di `C:\Users\LENOVO\naiklevel` dengan Antigravity, taruh file `naiklevel-master-plan.md` di root folder project (biar agent bisa baca sebagai referensi), lalu paste prompt di bawah ini ke agent.

---

```
Kamu adalah tech lead untuk project bernama "Naik Level" — aplikasi edukasi
untuk anak usia 4-12 tahun (TK A - SD Kelas 6), mengikuti Kurikulum Merdeka
Indonesia. Baca file `naiklevel-master-plan.md` di root project ini sebagai
sumber kebenaran utama untuk semua keputusan produk, sebelum memulai kerja
apa pun.

LANGKAH PERTAMA (wajib, jangan lewati):
1. Inspeksi seluruh kode yang sudah ada di folder project ini saat ini.
   Buat ringkasan: apa yang sudah dibuat, stack apa yang dipakai, struktur
   folder seperti apa, dan apakah sudah selaras dengan rencana di
   naiklevel-master-plan.md.
2. Kalau ada perbedaan stack/struktur antara kode existing dan master plan
   (Next.js untuk web, React Native untuk mobile, monorepo dengan shared
   package, Supabase sebagai backend), jangan langsung timpa/hapus kode
   lama. Sajikan opsi: (a) migrasi bertahap, (b) lanjutkan dari nol dengan
   kode lama diarsipkan, (c) sesuaikan rencana ke kode existing — lalu
   tunggu keputusanku sebelum eksekusi besar.
3. Setelah itu, buat task list bertahap (bukan langsung generate semua
   kode sekaligus) untuk fase MVP berikut, dan tunjukkan sebagai Artifact
   supaya bisa aku review sebelum lanjut ke fase berikutnya:

   FASE 1 — Fondasi
   - Setup monorepo (apps/web [Next.js], apps/mobile [React Native],
     packages/shared untuk logic soal, state gamifikasi, API client)
   - Setup koneksi Supabase (Postgres + Auth + Storage)
   - Desain skema database untuk hierarki:
     Jenjang > Mata Pelajaran/Aspek Perkembangan > Elemen/Domain >
     Topik/Bab > Konten Belajar (Latihan Soal, Soal Olimpiade,
     Photo Submission opsional)
   - Skema akun: 1 akun orang tua -> multi-profil anak, dengan consent
     orang tua saat registrasi (wajib, lihat bagian privasi di master plan)

   FASE 2 — Konten per Jenjang (SEQUENTIAL, bukan paralel semua jenjang)
   Urutan wajib, satu jenjang tuntas semua mapel sebelum lanjut ke
   jenjang berikutnya:
     1. SD Kelas 1 (semua mapel, lengkap — ini juga flagship SEO)
     2. TK A (semua aspek perkembangan, lengkap)
     3. TK B (semua aspek perkembangan, lengkap)
     4. SD Kelas 2
     5. SD Kelas 3
     6. SD Kelas 4
     7. SD Kelas 5
     8. SD Kelas 6
   Untuk tiap jenjang: bangun struktur data lengkap (Elemen, Topik,
   Latihan Soal, Soal Olimpiade) sesuai Capaian Pembelajaran resmi
   Kurikulum Merdeka untuk jenjang tsb. WAJIB: setiap mapel minimal
   punya 60 soal (gabungan Latihan Soal + Soal Olimpiade) supaya anak
   bisa mengulang latihan dengan variasi soal berbeda. Jangan mulai
   jenjang berikutnya sebelum jenjang saat ini benar-benar tuntas
   (semua mapel, semua topik, minimal 60 soal per mapel).

   FASE 3 — Fitur Inti
   - Latihan Soal: tanpa timer, hasil nilai + breakdown per elemen,
     riwayat nilai per sesi tersimpan
   - Soal Olimpiade: dengan timer
   - Gamifikasi: sistem XP, Level anak (terpisah dari kelas sekolah),
     Badge, streak harian
   - Raport Bayangan: laporan otomatis triwulanan (per 3 bulan) untuk
     orang tua, isi kekuatan & kekurangan anak per Elemen/Domain
     berdasarkan akumulasi hasil selama periode tersebut
   - Dashboard orang tua: progres, nilai per elemen, waktu belajar,
     kontrol batas waktu penggunaan, akses ke Raport Bayangan

   FASE 4 — SEO (khusus web)
   - SSR/SSG untuk semua halaman topik/bab publik (tidak di-lock login)
   - Meta tags dinamis, structured data (schema.org), sitemap.xml

   Untuk setiap fase, verifikasi hasil kerja (jalankan build/test,
   screenshot UI kalau relevan) sebelum menandai selesai.

BATASAN & PRINSIP DESAIN:
- UI/UX harus ceria, fleksibel, tidak kaku — sesuai karakter anak-anak.
  Untuk TK: visual-dominan (animasi, ikon besar, minim teks).
- Semua fitur yang menyentuh data anak (termasuk foto dari fitur
  take-a-picture) harus mengikuti prinsip privasi di master plan:
  minimalisasi data, tidak publik, consent orang tua eksplisit.
- Jangan asumsikan detail apa pun soal Capaian Pembelajaran resmi kalau
  tidak yakin — tandai sebagai "perlu validasi kurikulum" alih-alih
  mengarang isi soal.

Mulai dari Langkah Pertama di atas, dan tunggu review saya sebelum lanjut
ke Fase 1.
```
