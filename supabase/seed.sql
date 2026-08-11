-- ==============================================================================
-- Seed Data for Naik Level App
-- Description: Inserts foundational curriculum structure and initial badges.
-- ==============================================================================

BEGIN;

-- ==============================================================================
-- 1. Education Levels
-- ==============================================================================
INSERT INTO public.education_levels (id, name, slug, phase, order_index, level_type) VALUES
  ('a1b2c3d4-e5f6-4a1b-8c2d-3e4f5a6b7c8d', 'TK A', 'tk-a', 'Fondasi', 1, 'tk'),
  ('b2c3d4e5-f6a1-4b2c-9d3e-4f5a6b7c8d9e', 'TK B', 'tk-b', 'Fondasi', 2, 'tk'),
  ('c3d4e5f6-a1b2-4c3d-ae4f-5a6b7c8d9ea0', 'SD Kelas 1', 'sd-kelas-1', 'A', 3, 'sd'),
  ('d4e5f6a1-b2c3-4d4e-bf5a-6b7c8d9ea0b1', 'SD Kelas 2', 'sd-kelas-2', 'A', 4, 'sd'),
  ('e5f6a1b2-c3d4-4e5f-c06b-7c8d9ea0b1c2', 'SD Kelas 3', 'sd-kelas-3', 'B', 5, 'sd'),
  ('f6a1b2c3-d4e5-4f6a-d17c-8d9ea0b1c2d3', 'SD Kelas 4', 'sd-kelas-4', 'B', 6, 'sd'),
  ('a1b2c3d4-e5f6-4a1b-8c2d-9ea0b1c2d3e4', 'SD Kelas 5', 'sd-kelas-5', 'C', 7, 'sd'),
  ('b2c3d4e5-f6a1-4b2c-9d3e-a0b1c2d3e4f5', 'SD Kelas 6', 'sd-kelas-6', 'C', 8, 'sd');

-- Retrieve ID for SD Kelas 1 to use for referencing
DO $$
DECLARE
    sd1_id UUID := 'c3d4e5f6-a1b2-4c3d-ae4f-5a6b7c8d9ea0';
    
    -- Subject IDs
    subj_pancasila UUID := gen_random_uuid();
    subj_indo UUID := gen_random_uuid();
    subj_mtk UUID := gen_random_uuid();
    subj_islam UUID := gen_random_uuid();
    subj_kristen UUID := gen_random_uuid();
    subj_katolik UUID := gen_random_uuid();
    subj_hindu UUID := gen_random_uuid();
    subj_buddha UUID := gen_random_uuid();
    subj_konghucu UUID := gen_random_uuid();
    subj_pjok UUID := gen_random_uuid();
    subj_seni UUID := gen_random_uuid();

    -- Element IDs (Pancasila — 4 elements)
    elem_p_pancasila UUID := gen_random_uuid();
    elem_p_uud UUID := gen_random_uuid();
    elem_p_bhinneka UUID := gen_random_uuid();
    elem_p_nkri UUID := gen_random_uuid();
    
    -- Element IDs (Bahasa Indonesia — 4 elements)
    elem_menyimak UUID := gen_random_uuid();
    elem_membaca UUID := gen_random_uuid();
    elem_berbicara UUID := gen_random_uuid();
    elem_menulis UUID := gen_random_uuid();

    -- Element IDs (Matematika — 5 elements)
    elem_bilangan UUID := gen_random_uuid();
    elem_aljabar UUID := gen_random_uuid();
    elem_pengukuran UUID := gen_random_uuid();
    elem_geometri UUID := gen_random_uuid();
    elem_analisis_data UUID := gen_random_uuid();
    
    -- Element IDs (Islam — 5 elements)
    elem_islam_alquran UUID := gen_random_uuid();
    elem_islam_aqidah UUID := gen_random_uuid();
    elem_islam_akhlak UUID := gen_random_uuid();
    elem_islam_fiqih UUID := gen_random_uuid();
    elem_islam_sejarah UUID := gen_random_uuid();

    -- Element IDs (Kristen — 3 elements)
    elem_kristen_allah UUID := gen_random_uuid();
    elem_kristen_manusia UUID := gen_random_uuid();
    elem_kristen_gereja UUID := gen_random_uuid();
    
    -- Element IDs (Katolik — 4 elements)
    elem_katolik_pribadi UUID := gen_random_uuid();
    elem_katolik_yesus UUID := gen_random_uuid();
    elem_katolik_gereja UUID := gen_random_uuid();
    elem_katolik_masyarakat UUID := gen_random_uuid();
    
    -- Element IDs (Hindu — 5 elements)
    elem_hindu_veda UUID := gen_random_uuid();
    elem_hindu_tattwa UUID := gen_random_uuid();
    elem_hindu_susila UUID := gen_random_uuid();
    elem_hindu_acara UUID := gen_random_uuid();
    elem_hindu_sejarah UUID := gen_random_uuid();
    
    -- Element IDs (Buddha — 5 elements)
    elem_buddha_sejarah UUID := gen_random_uuid();
    elem_buddha_kitab UUID := gen_random_uuid();
    elem_buddha_saddha UUID := gen_random_uuid();
    elem_buddha_sila UUID := gen_random_uuid();
    elem_buddha_samadhi UUID := gen_random_uuid();

    -- Element IDs (Konghucu — 4 elements)
    elem_konghucu_kitab UUID := gen_random_uuid();
    elem_konghucu_keimanan UUID := gen_random_uuid();
    elem_konghucu_junzi UUID := gen_random_uuid();
    elem_konghucu_ibadah UUID := gen_random_uuid();

    -- Element IDs (PJOK — 5 elements)
    elem_pjok_keterampilan UUID := gen_random_uuid();
    elem_pjok_pengetahuan UUID := gen_random_uuid();
    elem_pjok_pemanfaatan UUID := gen_random_uuid();
    elem_pjok_karakter UUID := gen_random_uuid();
    elem_pjok_nilai UUID := gen_random_uuid();
    
    -- Element IDs (Seni Budaya — 5 elements)
    elem_seni_mengalami UUID := gen_random_uuid();
    elem_seni_menciptakan UUID := gen_random_uuid();
    elem_seni_merefleksikan UUID := gen_random_uuid();
    elem_seni_artistik UUID := gen_random_uuid();
    elem_seni_berdampak UUID := gen_random_uuid();

BEGIN
    -- ==============================================================================
    -- 2. Subjects (SD Kelas 1)
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, order_index) VALUES
    (subj_pancasila, sd1_id, 'Pendidikan Pancasila', 'Pendidikan Pancasila', 'pancasila-sd-1', '🦅', 1),
    (subj_indo, sd1_id, 'Bahasa Indonesia', 'Bahasa Indonesia', 'bahasa-indonesia-sd-1', '📖', 2),
    (subj_mtk, sd1_id, 'Matematika', 'Matematika', 'matematika-sd-1', '🔢', 3),
    (subj_islam, sd1_id, 'Agama Islam', 'Pendidikan Agama Islam dan Budi Pekerti', 'agama-islam-sd-1', '☪️', 4),
    (subj_kristen, sd1_id, 'Agama Kristen', 'Pendidikan Agama Kristen dan Budi Pekerti', 'agama-kristen-sd-1', '✝️', 5),
    (subj_katolik, sd1_id, 'Agama Katolik', 'Pendidikan Agama Katolik dan Budi Pekerti', 'agama-katolik-sd-1', '⛪', 6),
    (subj_hindu, sd1_id, 'Agama Hindu', 'Pendidikan Agama Hindu dan Budi Pekerti', 'agama-hindu-sd-1', '🕉️', 7),
    (subj_buddha, sd1_id, 'Agama Buddha', 'Pendidikan Agama Buddha dan Budi Pekerti', 'agama-buddha-sd-1', '☸️', 8),
    (subj_konghucu, sd1_id, 'Agama Konghucu', 'Pendidikan Agama Konghucu dan Budi Pekerti', 'agama-konghucu-sd-1', '☯️', 9),
    (subj_pjok, sd1_id, 'PJOK', 'Pendidikan Jasmani, Olahraga, dan Kesehatan', 'pjok-sd-1', '⚽', 10),
    (subj_seni, sd1_id, 'Seni Budaya', 'Seni Rupa', 'seni-rupa-sd-1', '🎨', 11);

    -- ==============================================================================
    -- 3. Elements (SD Kelas 1) — Complete per Capaian Pembelajaran
    -- ==============================================================================
    
    -- Pancasila (4 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_p_pancasila, subj_pancasila, 'Pancasila', 1),
    (elem_p_uud, subj_pancasila, 'UUD 1945', 2),
    (elem_p_bhinneka, subj_pancasila, 'Bhinneka Tunggal Ika', 3),
    (elem_p_nkri, subj_pancasila, 'NKRI', 4);

    -- Bahasa Indonesia (4 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_menyimak, subj_indo, 'Menyimak', 1),
    (elem_membaca, subj_indo, 'Membaca dan Memirsa', 2),
    (elem_berbicara, subj_indo, 'Berbicara dan Mempresentasikan', 3),
    (elem_menulis, subj_indo, 'Menulis', 4);

    -- Matematika (5 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_bilangan, subj_mtk, 'Bilangan', 1),
    (elem_aljabar, subj_mtk, 'Aljabar', 2),
    (elem_pengukuran, subj_mtk, 'Pengukuran', 3),
    (elem_geometri, subj_mtk, 'Geometri', 4),
    (elem_analisis_data, subj_mtk, 'Analisis Data dan Peluang', 5);

    -- Islam (5 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_islam_alquran, subj_islam, 'Al-Qur''an dan Hadis', 1),
    (elem_islam_aqidah, subj_islam, 'Aqidah', 2),
    (elem_islam_akhlak, subj_islam, 'Akhlak', 3),
    (elem_islam_fiqih, subj_islam, 'Fiqih', 4),
    (elem_islam_sejarah, subj_islam, 'Sejarah Peradaban Islam', 5);

    -- Kristen (3 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_kristen_allah, subj_kristen, 'Allah Berkarya', 1),
    (elem_kristen_manusia, subj_kristen, 'Manusia dan Nilai-nilai Kristiani', 2),
    (elem_kristen_gereja, subj_kristen, 'Gereja dan Masyarakat Majemuk', 3);

    -- Katolik (4 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_katolik_pribadi, subj_katolik, 'Pribadi Peserta Didik', 1),
    (elem_katolik_yesus, subj_katolik, 'Yesus Kristus', 2),
    (elem_katolik_gereja, subj_katolik, 'Gereja', 3),
    (elem_katolik_masyarakat, subj_katolik, 'Masyarakat', 4);

    -- Hindu (5 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_hindu_veda, subj_hindu, 'Kitab Suci Veda', 1),
    (elem_hindu_tattwa, subj_hindu, 'Tattwa / Filsafat', 2),
    (elem_hindu_susila, subj_hindu, 'Susila / Etika', 3),
    (elem_hindu_acara, subj_hindu, 'Acara / Ritual', 4),
    (elem_hindu_sejarah, subj_hindu, 'Sejarah', 5);

    -- Buddha (5 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_buddha_sejarah, subj_buddha, 'Sejarah', 1),
    (elem_buddha_kitab, subj_buddha, 'Kitab Suci Tipitaka', 2),
    (elem_buddha_saddha, subj_buddha, 'Saddha / Keyakinan', 3),
    (elem_buddha_sila, subj_buddha, 'Sila / Moralitas', 4),
    (elem_buddha_samadhi, subj_buddha, 'Samadhi / Meditasi', 5);

    -- Konghucu (4 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_konghucu_kitab, subj_konghucu, 'Kitab Suci Si Shu Wu Jing', 1),
    (elem_konghucu_keimanan, subj_konghucu, 'Keimanan', 2),
    (elem_konghucu_junzi, subj_konghucu, 'Perilaku Junzi', 3),
    (elem_konghucu_ibadah, subj_konghucu, 'Tata Ibadah', 4);

    -- PJOK (5 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_pjok_keterampilan, subj_pjok, 'Keterampilan Gerak', 1),
    (elem_pjok_pengetahuan, subj_pjok, 'Pengetahuan Gerak', 2),
    (elem_pjok_pemanfaatan, subj_pjok, 'Pemanfaatan Gerak', 3),
    (elem_pjok_karakter, subj_pjok, 'Pengembangan Karakter', 4),
    (elem_pjok_nilai, subj_pjok, 'Nilai-Nilai Gerak', 5);

    -- Seni Budaya (5 elements)
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_seni_mengalami, subj_seni, 'Mengalami', 1),
    (elem_seni_menciptakan, subj_seni, 'Menciptakan', 2),
    (elem_seni_merefleksikan, subj_seni, 'Merefleksikan', 3),
    (elem_seni_artistik, subj_seni, 'Berpikir dan Bekerja Artistik', 4),
    (elem_seni_berdampak, subj_seni, 'Berdampak', 5);

    -- ==============================================================================
    -- 4. Topics (SD Kelas 1)
    -- ==============================================================================

    -- Pancasila (4 topics, one per element)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_p_pancasila, 'Simbol Garuda Pancasila', 'simbol-garuda-pancasila', 1, true),
    (elem_p_uud, 'Aturan di Rumah dan Sekolah', 'aturan-di-rumah-dan-sekolah', 1, true),
    (elem_p_bhinneka, 'Keberagaman Karakteristik Individu', 'keberagaman-karakteristik-individu', 1, true),
    (elem_p_nkri, 'Mengenal Lingkungan Rumah', 'mengenal-lingkungan-rumah', 1, true);

    -- Bahasa Indonesia (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_menyimak, 'Menyimak Cerita Sederhana', 'menyimak-cerita-sederhana', 1, true),
    (elem_membaca, 'Membaca Suku Kata dan Kata', 'membaca-suku-kata', 1, true),
    (elem_berbicara, 'Menceritakan Pengalaman', 'menceritakan-pengalaman', 1, true),
    (elem_menulis, 'Menulis Huruf dan Kata Sederhana', 'menulis-huruf-dan-kata', 1, true);

    -- Matematika (8 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_bilangan, 'Bilangan Cacah sampai 20', 'bilangan-cacah-sampai-20', 1, true),
    (elem_bilangan, 'Bilangan Cacah sampai 100', 'bilangan-cacah-sampai-100', 2, true),
    (elem_aljabar, 'Penjumlahan Dasar', 'penjumlahan-dasar', 1, true),
    (elem_aljabar, 'Pengurangan Dasar', 'pengurangan-dasar', 2, true),
    (elem_pengukuran, 'Mengukur Panjang dengan Satuan Tak Baku', 'mengukur-panjang-tak-baku', 1, true),
    (elem_geometri, 'Mengenal Bangun Datar', 'mengenal-bangun-datar', 1, true),
    (elem_geometri, 'Mengenal Bangun Ruang', 'mengenal-bangun-ruang', 2, true),
    (elem_analisis_data, 'Mengelompokkan Benda', 'mengelompokkan-benda', 1, true);

    -- Agama Islam (6 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_islam_alquran, 'Huruf Hijaiyah', 'huruf-hijaiyah', 1, true),
    (elem_islam_alquran, 'Surah Al-Fatihah', 'surah-al-fatihah', 2, true),
    (elem_islam_aqidah, 'Mengenal Allah (Rukun Iman)', 'mengenal-allah', 1, true),
    (elem_islam_akhlak, 'Berperilaku Jujur dan Hormat', 'berperilaku-jujur', 1, true),
    (elem_islam_fiqih, 'Syahadat (Rukun Islam)', 'syahadat', 1, true),
    (elem_islam_sejarah, 'Kisah Nabi Adam a.s.', 'kisah-nabi-adam', 1, true);

    -- Agama Kristen (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_kristen_allah, 'Allah Pencipta', 'allah-pencipta', 1, true),
    (elem_kristen_manusia, 'Aku Ciptaan Allah yang Unik', 'aku-ciptaan-unik', 1, true),
    (elem_kristen_manusia, 'Hidup Bersyukur', 'hidup-bersyukur', 2, true),
    (elem_kristen_gereja, 'Mengasihi Sesama', 'mengasihi-sesama', 1, true);

    -- Agama Katolik (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_katolik_pribadi, 'Aku Anak Allah', 'aku-anak-allah', 1, true),
    (elem_katolik_pribadi, 'Keluarga sebagai Anugerah', 'keluarga-anugerah', 2, true),
    (elem_katolik_yesus, 'Mencintai Sesama', 'mencintai-sesama', 1, true),
    (elem_katolik_masyarakat, 'Bersyukur kepada Tuhan', 'bersyukur-kepada-tuhan', 1, true);

    -- Agama Hindu (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_hindu_veda, 'Mengenal Doa Tri Sandhya', 'doa-tri-sandhya', 1, true),
    (elem_hindu_tattwa, 'Mengenal Tri Murti', 'mengenal-tri-murti', 1, true),
    (elem_hindu_susila, 'Perilaku Satya (Jujur)', 'perilaku-satya', 1, true),
    (elem_hindu_acara, 'Mengenal Hari Raya Hindu', 'hari-raya-hindu', 1, true);

    -- Agama Buddha (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_buddha_sejarah, 'Riwayat Pangeran Siddharta', 'riwayat-siddharta', 1, true),
    (elem_buddha_sejarah, 'Mengenal Vihara', 'mengenal-vihara', 2, true),
    (elem_buddha_sila, 'Pancasila Buddhis', 'pancasila-buddhis', 1, true),
    (elem_buddha_samadhi, 'Meditasi Sederhana', 'meditasi-sederhana', 1, true);

    -- Agama Konghucu (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_konghucu_kitab, 'Mengenal Nabi Kongzi', 'mengenal-nabi-kongzi', 1, true),
    (elem_konghucu_junzi, 'Delapan Kebajikan', 'delapan-kebajikan', 1, true),
    (elem_konghucu_keimanan, 'Berdoa dengan Xiao', 'berdoa-dengan-xiao', 1, true),
    (elem_konghucu_ibadah, 'Mengenal Litang', 'mengenal-litang', 1, true);

    -- PJOK (5 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_pjok_keterampilan, 'Gerak Dasar Lokomotor', 'gerak-lokomotor', 1, true),
    (elem_pjok_keterampilan, 'Gerak Dasar Non-Lokomotor', 'gerak-non-lokomotor', 2, true),
    (elem_pjok_keterampilan, 'Gerak Dasar Manipulatif', 'gerak-manipulatif', 3, true),
    (elem_pjok_pemanfaatan, 'Menjaga Kebersihan Tubuh', 'menjaga-kebersihan-tubuh', 1, true),
    (elem_pjok_karakter, 'Sikap Sportif dalam Bermain', 'sikap-sportif', 1, true);

    -- Seni Budaya (4 topics)
    INSERT INTO public.topics (element_id, name, slug, order_index, is_published) VALUES
    (elem_seni_mengalami, 'Mengenal Garis Bentuk dan Warna', 'garis-bentuk-warna', 1, true),
    (elem_seni_menciptakan, 'Membuat Kolase Sederhana', 'membuat-kolase', 1, true),
    (elem_seni_merefleksikan, 'Mengapresiasi Karya Teman', 'mengapresiasi-karya-teman', 1, true),
    (elem_seni_artistik, 'Menggunakan Alat Gambar dengan Aman', 'alat-gambar-aman', 1, true);

END $$;

-- ==============================================================================
-- 5. Badges
-- ==============================================================================

INSERT INTO public.badges (name, description, icon_url, criteria) VALUES
('Petualang Pertama', 'Menyelesaikan kuis pertama — selamat, petualanganmu dimulai!', '/badges/petualang-pertama.png', '{"type": "first_quiz"}'),
('Juara Bilangan', 'Menyelesaikan semua topik Matematika', '/badges/juara-bilangan.png', '{"type": "complete_subject", "subject_slug": "matematika-sd-1"}'),
('Berani Tantangan', 'Menyelesaikan soal olimpiade pertama', '/badges/berani-tantangan.png', '{"type": "first_olympiad"}'),
('Konsisten', 'Belajar 3 hari berturut-turut — hebat!', '/badges/konsisten.png', '{"type": "streak", "days": 3}'),
('Rajin Sekali', 'Belajar 7 hari berturut-turut — luar biasa!', '/badges/rajin-sekali.png', '{"type": "streak", "days": 7}'),
('Bintang Kelas', 'Mendapatkan nilai sempurna 100!', '/badges/bintang-kelas.png', '{"type": "perfect_score"}'),
('Kutu Buku', 'Menyelesaikan semua topik Bahasa Indonesia', '/badges/kutu-buku.png', '{"type": "complete_subject", "subject_slug": "bahasa-indonesia-sd-1"}'),
('Warga Negara Cilik', 'Menyelesaikan semua topik Pendidikan Pancasila', '/badges/warga-negara-cilik.png', '{"type": "complete_subject", "subject_slug": "pancasila-sd-1"}'),
('Seniman Muda', 'Menyelesaikan semua topik Seni Budaya', '/badges/seniman-muda.png', '{"type": "complete_subject", "subject_slug": "seni-rupa-sd-1"}'),
('Atlet Cilik', 'Menyelesaikan semua topik PJOK', '/badges/atlet-cilik.png', '{"type": "complete_subject", "subject_slug": "pjok-sd-1"}');

COMMIT;
