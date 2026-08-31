-- ==============================================================================
-- Seed TK A & TK B Curriculum (STPPA 6 Aspek Perkembangan) & Visual Bank Soal
-- ==============================================================================

BEGIN;

DO $$
DECLARE
    tka_id UUID := 'a1b2c3d4-e5f6-4a1b-8c2d-3e4f5a6b7c8d';
    tkb_id UUID := 'b2c3d4e5-f6a1-4b2c-9d3e-4f5a6b7c8d9e';

    -- TK A Subject IDs
    tka_lit UUID := gen_random_uuid();
    tka_mat UUID := gen_random_uuid();
    tka_sai UUID := gen_random_uuid();
    tka_sen UUID := gen_random_uuid();
    tka_moral UUID := gen_random_uuid();
    tka_diri UUID := gen_random_uuid();

    -- TK B Subject IDs
    tkb_lit UUID := gen_random_uuid();
    tkb_mat UUID := gen_random_uuid();
    tkb_sai UUID := gen_random_uuid();
    tkb_sen UUID := gen_random_uuid();
    tkb_moral UUID := gen_random_uuid();
    tkb_diri UUID := gen_random_uuid();

    -- Element & Topic IDs TK A
    elem_tka_lit UUID := gen_random_uuid();
    elem_tka_mat UUID := gen_random_uuid();
    elem_tka_sai UUID := gen_random_uuid();
    elem_tka_sen UUID := gen_random_uuid();
    elem_tka_moral UUID := gen_random_uuid();
    elem_tka_diri UUID := gen_random_uuid();

    top_tka_huruf UUID := gen_random_uuid();
    top_tka_angka UUID := gen_random_uuid();
    top_tka_hewan UUID := gen_random_uuid();
    top_tka_warna UUID := gen_random_uuid();
    top_tka_salam UUID := gen_random_uuid();
    top_tka_emosi UUID := gen_random_uuid();

    -- Element & Topic IDs TK B
    elem_tkb_lit UUID := gen_random_uuid();
    elem_tkb_mat UUID := gen_random_uuid();
    elem_tkb_sai UUID := gen_random_uuid();
    elem_tkb_sen UUID := gen_random_uuid();
    elem_tkb_moral UUID := gen_random_uuid();
    elem_tkb_diri UUID := gen_random_uuid();

    top_tkb_kata UUID := gen_random_uuid();
    top_tkb_hitung UUID := gen_random_uuid();
    top_tkb_tanaman UUID := gen_random_uuid();
    top_tkb_musik UUID := gen_random_uuid();
    top_tkb_berdoa UUID := gen_random_uuid();
    top_tkb_kebersihan UUID := gen_random_uuid();
BEGIN

    -- ==============================================================================
    -- 1. Subjects TK A
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (tka_lit, tka_id, 'Mengenal Huruf & Membaca', 'Dasar-dasar Literasi', 'huruf-membaca-tk-a', '🔤', 'Belajar mengenal huruf fonik vokal dan bentuk kata dasar', 1),
    (tka_mat, tka_id, 'Berhitung & Angka', 'Dasar-dasar Matematika', 'berhitung-angka-tk-a', '🔢', 'Mengenal angka 1-10, menghitung objek visual, dan pola warna', 2),
    (tka_sai, tka_id, 'Sains & Alam Sekitar', 'Dasar Sains & Rekayasa', 'sains-alam-tk-a', '🌿', 'Mengenal nama hewan, tumbuhan, cuaca, dan anggota tubuh', 3),
    (tka_sen, tka_id, 'Kreativitas & Seni', 'Seni', 'kreativitas-seni-tk-a', '🎨', 'Mengenal warna dasar, bentuk visual, dan kreasi warna', 4),
    (tka_moral, tka_id, 'Budi Pekerti & Doa', 'Nilai Agama dan Moral', 'budi-pekerti-tk-a', '🕊️', 'Mengenal ucapan terima kasih, maaf, salam, dan kebiasaan baik', 5),
    (tka_diri, tka_id, 'Mandiri & Bersosialisasi', 'Jati Diri', 'mandiri-bersosialisasi-tk-a', '🤝', 'Mengenal ekspresi emosi, merapikan mainan, dan berbagi', 6);

    -- ==============================================================================
    -- 2. Subjects TK B
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (tkb_lit, tkb_id, 'Mengenal Huruf & Membaca', 'Dasar-dasar Literasi', 'huruf-membaca-tk-b', '🔤', 'Mencocokkan suku kata awal dan membaca kata bergambar', 1),
    (tkb_mat, tkb_id, 'Berhitung & Angka', 'Dasar-dasar Matematika', 'berhitung-angka-tk-b', '🔢', 'Mengenal angka 1-20 dan penjumlahan sederhana gambar', 2),
    (tkb_sai, tkb_id, 'Sains & Alam Sekitar', 'Dasar Sains & Rekayasa', 'sains-alam-tk-b', '🌿', 'Bagian-bagian tanaman, hewan air/darat, dan siang/malam', 3),
    (tkb_sen, tkb_id, 'Kreativitas & Seni', 'Seni', 'kreativitas-seni-tk-b', '🎵', 'Mengenal alat musik sederhana dan pola irama nada', 4),
    (tkb_moral, tkb_id, 'Budi Pekerti & Doa', 'Nilai Agama dan Moral', 'budi-pekerti-tk-b', '🕊️', 'Doa sebelum makan/tidur dan menolong teman', 5),
    (tkb_diri, tkb_id, 'Mandiri & Bersosialisasi', 'Jati Diri', 'mandiri-bersosialisasi-tk-b', '🧼', 'Mencuci tangan, memakai sepatu sendiri, dan menjaga kebersihan', 6);

    -- ==============================================================================
    -- 3. Elements TK A & TK B
    -- ==============================================================================
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_tka_lit, tka_lit, 'Pengenalan Huruf Vokal & Consonant', 1),
    (elem_tka_mat, tka_mat, 'Pengenalan Angka 1-10 & Jumlah', 1),
    (elem_tka_sai, tka_sai, 'Pengenalan Lingkungan Sekitar', 1),
    (elem_tka_sen, tka_sen, 'Eksplorasi Warna & Bentuk', 1),
    (elem_tka_moral, tka_moral, 'Sikap & Kebiasaan Baik', 1),
    (elem_tka_diri, tka_diri, 'Mengenal Diri & Perasaan', 1),

    (elem_tkb_lit, tkb_lit, 'Penggabungan Suku Kata & Kata', 1),
    (elem_tkb_mat, tkb_mat, 'Pengenalan Angka 1-20 & Penjumlahan Gambar', 1),
    (elem_tkb_sai, tkb_sai, 'Pengamatan Alam & Makhluk Hidup', 1),
    (elem_tkb_sen, tkb_sen, 'Apresiasi Bunyi & Seni Visual', 1),
    (elem_tkb_moral, tkb_moral, 'Doa Harian & Kepedulian Sosial', 1),
    (elem_tkb_diri, tkb_diri, 'Kemandirian & Perilaku Sehat', 1);

    -- ==============================================================================
    -- 4. Topics TK A & TK B
    -- ==============================================================================
    INSERT INTO public.topics (id, element_id, name, slug, order_index, is_published) VALUES
    (top_tka_huruf, elem_tka_lit, 'Huruf Vokal A, I, U, E, O', 'huruf-vokal-tka', 1, true),
    (top_tka_angka, elem_tka_mat, 'Membilang Angka 1 sampai 10', 'membilang-1-10-tka', 1, true),
    (top_tka_hewan, elem_tka_sai, 'Mengenal Hewan di Sekitar Kita', 'mengenal-hewan-tka', 1, true),
    (top_tka_warna, elem_tka_sen, 'Mengenal Warna Primer', 'mengenal-warna-tka', 1, true),
    (top_tka_salam, elem_tka_moral, 'Kata Ajaib: Tolong & Terima Kasih', 'kata-ajaib-tka', 1, true),
    (top_tka_emosi, elem_tka_diri, 'Ekspresi Senang dan Sedih', 'ekspresi-emosi-tka', 1, true),

    (top_tkb_kata, elem_tkb_lit, 'Membaca Kata Bergambar', 'membaca-kata-tkb', 1, true),
    (top_tkb_hitung, elem_tkb_mat, 'Penjumlahan Bergambar 1-10', 'penjumlahan-gambar-tkb', 1, true),
    (top_tkb_tanaman, elem_tkb_sai, 'Bagian-bagian Tumbuhan', 'bagian-tumbuhan-tkb', 1, true),
    (top_tkb_musik, elem_tkb_sen, 'Mengenal Alat Musik Sederhana', 'alat-musik-tkb', 1, true),
    (top_tkb_berdoa, elem_tkb_moral, 'Doa Sebelum & Sesudah Makan', 'doa-makan-tkb', 1, true),
    (top_tkb_kebersihan, elem_tkb_diri, 'Cara Mencuci Tangan yang Benar', 'cuci-tangan-tkb', 1, true);
    IF top_tka_huruf IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_huruf, 'regular', 'multiple_choice', 'Huruf pertama dari kata 🍎 "APEL" adalah...', '[{"id": "opt_1", "text": "A"}, {"id": "opt_2", "text": "I"}, {"id": "opt_3", "text": "U"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kata APEL diawali huruf A.', 1, 10);
    END IF;

    IF top_tka_huruf IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_huruf, 'regular', 'multiple_choice', 'Huruf pertama dari gambar 🐟 "IKAN" adalah...', '[{"id": "opt_1", "text": "U"}, {"id": "opt_2", "text": "I"}, {"id": "opt_3", "text": "O"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Kata IKAN diawali huruf I.', 1, 10);
    END IF;

    IF top_tka_huruf IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_huruf, 'regular', 'multiple_choice', 'Huruf pertama dari kata 🐘 "GAJAH" adalah...', '[{"id": "opt_1", "text": "G"}, {"id": "opt_2", "text": "B"}, {"id": "opt_3", "text": "K"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kata GAJAH diawali huruf G.', 1, 10);
    END IF;

    IF top_tka_angka IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_angka, 'regular', 'multiple_choice', 'Hitung jumlah bintang ini: ⭐️ ⭐️ ⭐️', '[{"id": "opt_1", "text": "2"}, {"id": "opt_2", "text": "3"}, {"id": "opt_3", "text": "4"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Ada 3 bintang.', 1, 10);
    END IF;

    IF top_tka_angka IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_angka, 'regular', 'multiple_choice', 'Hitung jumlah apel ini: 🍎 🍎 🍎 🍎 🍎', '[{"id": "opt_1", "text": "4"}, {"id": "opt_2", "text": "5"}, {"id": "opt_3", "text": "6"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Ada 5 apel.', 1, 10);
    END IF;

    IF top_tka_angka IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_angka, 'regular', 'multiple_choice', 'Mana angka LIMA?', '[{"id": "opt_1", "text": "3"}, {"id": "opt_2", "text": "5"}, {"id": "opt_3", "text": "7"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Angka 5 melambangkan lima.', 1, 10);
    END IF;

    IF top_tka_hewan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_hewan, 'regular', 'multiple_choice', 'Hewan yang memiliki belalai panjang adalah...', '[{"id": "opt_1", "text": "Gajah \ud83d\udc18"}, {"id": "opt_2", "text": "Kucing \ud83d\udc31"}, {"id": "opt_3", "text": "Kelinci \ud83d\udc30"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Gajah memiliki belalai panjang.', 1, 10);
    END IF;

    IF top_tka_hewan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_hewan, 'regular', 'multiple_choice', 'Hewan yang suka makan wortel dan melompat adalah...', '[{"id": "opt_1", "text": "Kelinci \ud83d\udc30"}, {"id": "opt_2", "text": "Anjing \ud83d\udc36"}, {"id": "opt_3", "text": "Ikan \ud83d\udc1f"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kelinci suka makan wortel.', 1, 10);
    END IF;

    IF top_tka_warna IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_warna, 'regular', 'multiple_choice', 'Warna buah Pisang yang sudah matang adalah...', '[{"id": "opt_1", "text": "Merah"}, {"id": "opt_2", "text": "Kuning"}, {"id": "opt_3", "text": "Biru"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Pisang matang berwarna kuning.', 1, 10);
    END IF;

    IF top_tka_warna IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_warna, 'regular', 'multiple_choice', 'Warna daun pohon segar pada umumnya adalah...', '[{"id": "opt_1", "text": "Hijau"}, {"id": "opt_2", "text": "Kuning"}, {"id": "opt_3", "text": "Merah"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Daun segar berwarna hijau.', 1, 10);
    END IF;

    IF top_tka_salam IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_salam, 'regular', 'multiple_choice', 'Saat kita diberi hadiah oleh teman, kita mengabaikan atau mengucapkan...', '[{"id": "opt_1", "text": "Terima Kasih"}, {"id": "opt_2", "text": "Maaf"}, {"id": "opt_3", "text": "Dada"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Ucapkan terima kasih saat diberi hadiah.', 1, 10);
    END IF;

    IF top_tka_emosi IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tka_emosi, 'regular', 'multiple_choice', 'Gambar wajah yang tersenyum 😃 menunjukkan perasaan...', '[{"id": "opt_1", "text": "Senang / Bahagia"}, {"id": "opt_2", "text": "Sedih"}, {"id": "opt_3", "text": "Marah"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Wajah tersenyum artinya senang.', 1, 10);
    END IF;

    IF top_tkb_kata IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_kata, 'regular', 'multiple_choice', 'Gambar 🐱 "K-U-C-I-N-G" diawali dengan suku kata...', '[{"id": "opt_1", "text": "KU"}, {"id": "opt_2", "text": "BA"}, {"id": "opt_3", "text": "CA"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kucing diawali suku kata KU.', 1, 10);
    END IF;

    IF top_tkb_kata IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_kata, 'regular', 'multiple_choice', 'Gambar 🎒 "T-A-S" diawali dengan huruf...', '[{"id": "opt_1", "text": "T"}, {"id": "opt_2", "text": "S"}, {"id": "opt_3", "text": "A"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Tas diawali huruf T.', 1, 10);
    END IF;

    IF top_tkb_hitung IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_hitung, 'regular', 'multiple_choice', 'Hitung: 🍎🍎 + 🍎🍎🍎 = ...', '[{"id": "opt_1", "text": "4"}, {"id": "opt_2", "text": "5"}, {"id": "opt_3", "text": "6"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '2 apel + 3 apel = 5 apel.', 1, 10);
    END IF;

    IF top_tkb_hitung IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_hitung, 'regular', 'multiple_choice', 'Hitung: ⭐️⭐️⭐️ + ⭐️⭐️ = ...', '[{"id": "opt_1", "text": "5"}, {"id": "opt_2", "text": "6"}, {"id": "opt_3", "text": "7"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '3 bintang + 2 bintang = 5 bintang.', 1, 10);
    END IF;

    IF top_tkb_tanaman IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_tanaman, 'regular', 'multiple_choice', 'Bagian tumbuhan yang berada di dalam tanah adalah...', '[{"id": "opt_1", "text": "Akar"}, {"id": "opt_2", "text": "Daun"}, {"id": "opt_3", "text": "Bunga"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Akar berada di dalam tanah.', 1, 10);
    END IF;

    IF top_tkb_musik IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_musik, 'regular', 'multiple_choice', 'Alat musik yang dimainkan dengan cara dipukul adalah...', '[{"id": "opt_1", "text": "Gendang \ud83e\udd41"}, {"id": "opt_2", "text": "Gitar \ud83c\udfb8"}, {"id": "opt_3", "text": "Seruling \ud83e\ude88"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Gendang dimainkan dengan dipukul.', 1, 10);
    END IF;

    IF top_tkb_berdoa IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_berdoa, 'regular', 'multiple_choice', 'Sebelum dan sesudah makan kita wajib...', '[{"id": "opt_1", "text": "Berdoa"}, {"id": "opt_2", "text": "Tidur"}, {"id": "opt_3", "text": "Lari"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Berdoa adalah wujud rasa syukur sebelum dan sesudah makan.', 1, 10);
    END IF;

    IF top_tkb_kebersihan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward)
        VALUES (top_tkb_kebersihan, 'regular', 'multiple_choice', 'Mencuci tangan sebaiknya menggunakan air mengalir dan...', '[{"id": "opt_1", "text": "Sabun \ud83e\uddfc"}, {"id": "opt_2", "text": "Minyak"}, {"id": "opt_3", "text": "Tepung"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Cuci tangan pakai sabun agar kuman hilang.', 1, 10);
    END IF;

END $$;

COMMIT;