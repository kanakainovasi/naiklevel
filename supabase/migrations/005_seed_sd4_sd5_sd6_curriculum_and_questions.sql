-- ==============================================================================
-- Seed SD Kelas 4, SD Kelas 5, & SD Kelas 6 Curriculum & HOTS Question Bank
-- ==============================================================================

BEGIN;

DO $$
DECLARE
    sd4_id UUID := 'f6a1b2c3-d4e5-4f6a-d17c-8d9ea0b1c2d3';
    sd5_id UUID := 'a1b2c3d4-e5f6-4a1b-8c2d-9ea0b1c2d3e4';
    sd6_id UUID := 'b2c3d4e5-f6a1-4b2c-9d3e-a0b1c2d3e4f5';

    -- SD 4 Subject IDs
    sd4_mtk UUID := gen_random_uuid();
    sd4_ipas UUID := gen_random_uuid();
    sd4_indo UUID := gen_random_uuid();
    sd4_inggris UUID := gen_random_uuid();
    sd4_pancasila UUID := gen_random_uuid();

    -- SD 5 Subject IDs
    sd5_mtk UUID := gen_random_uuid();
    sd5_ipas UUID := gen_random_uuid();
    sd5_indo UUID := gen_random_uuid();
    sd5_inggris UUID := gen_random_uuid();

    -- SD 6 Subject IDs
    sd6_mtk UUID := gen_random_uuid();
    sd6_ipas UUID := gen_random_uuid();
    sd6_indo UUID := gen_random_uuid();
    sd6_inggris UUID := gen_random_uuid();

    -- Element & Topic IDs SD 4
    elem_sd4_ipas UUID := gen_random_uuid();
    elem_sd4_mtk UUID := gen_random_uuid();
    elem_sd4_inggris UUID := gen_random_uuid();
    top_sd4_gaya UUID := gen_random_uuid();
    top_sd4_luas UUID := gen_random_uuid();
    top_sd4_greeting UUID := gen_random_uuid();

    -- Element & Topic IDs SD 5
    elem_sd5_ipas UUID := gen_random_uuid();
    elem_sd5_mtk UUID := gen_random_uuid();
    top_sd5_ekosistem UUID := gen_random_uuid();
    top_sd5_desimal UUID := gen_random_uuid();

    -- Element & Topic IDs SD 6
    elem_sd6_ipas UUID := gen_random_uuid();
    elem_sd6_mtk UUID := gen_random_uuid();
    top_sd6_tatasurya UUID := gen_random_uuid();
    top_sd6_statistik UUID := gen_random_uuid();
BEGIN

    -- ==============================================================================
    -- 1. Subjects SD Kelas 4
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (sd4_ipas, sd4_id, 'IPAS (Sains & Sosial)', 'Ilmu Pengetahuan Alam dan Sosial', 'ipas-sd-4', '🔬', 'Wujud zat, gaya & gerak, energi, dan keanekaragaman budaya', 1),
    (sd4_mtk, sd4_id, 'Matematika', 'Matematika', 'matematika-sd-4', '🔢', 'Sudut, keliling & luas bangun datar, pecahan senilai', 2),
    (sd4_indo, sd4_id, 'Bahasa Indonesia', 'Bahasa Indonesia', 'bahasa-indonesia-sd-4', '📖', 'Kalimat transitif/intransitif, paragraf narasi, dan majas', 3),
    (sd4_inggris, sd4_id, 'Bahasa Inggris', 'English for Primary', 'bahasa-inggris-sd-4', '🇬🇧', 'Greetings, hobbies, family members, and simple sentences', 4),
    (sd4_pancasila, sd4_id, 'Pendidikan Pancasila', 'Pendidikan Pancasila', 'pancasila-sd-4', '🦅', 'Keragaman budaya, hak & kewajiban warga negara, norma', 5);

    -- ==============================================================================
    -- 2. Subjects SD Kelas 5
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (sd5_ipas, sd5_id, 'IPAS (Sains & Sosial)', 'Ilmu Pengetahuan Alam dan Sosial', 'ipas-sd-5', '🌿', 'Ekosistem, rantai makanan, pencernaan/pernapasan, dan sejarah Nusantara', 1),
    (sd5_mtk, sd5_id, 'Matematika', 'Matematika', 'matematika-sd-5', '🔢', 'Pecahan campuran, desimal, persen, skala & denah, kecepatan & debit', 2),
    (sd5_indo, sd5_id, 'Bahasa Indonesia', 'Bahasa Indonesia', 'bahasa-indonesia-sd-5', '📖', 'Teks eksplanasi, formulir, dan sinopsis cerita', 3),
    (sd5_inggris, sd5_id, 'Bahasa Inggris', 'English for Primary', 'bahasa-inggris-sd-5', '🇬🇧', 'Daily routines, telling time, and food & drinks', 4);

    -- ==============================================================================
    -- 3. Subjects SD Kelas 6
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (sd6_ipas, sd6_id, 'IPAS (Sains & Sosial)', 'Ilmu Pengetahuan Alam dan Sosial', 'ipas-sd-6', '🪐', 'Tata surya, rotasi/revolusi bumi, listrik & magnet, dan globalisasi', 1),
    (sd6_mtk, sd6_id, 'Matematika', 'Matematika', 'matematika-sd-6', '🔢', 'Volume bangun ruang (kubus/balok/tabung), rerata, modus, & median', 2),
    (sd6_indo, sd6_id, 'Bahasa Indonesia', 'Bahasa Indonesia', 'bahasa-indonesia-sd-6', '📖', 'Pidato, pidato persuasif, dan analisis karya sastra', 3),
    (sd6_inggris, sd6_id, 'Bahasa Inggris', 'English for Primary', 'bahasa-inggris-sd-6', '🇬🇧', 'Past tense, direction & location, and holiday experiences', 4);

    -- ==============================================================================
    -- 4. Elements & Topics SD 4, 5, 6
    -- ==============================================================================
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_sd4_ipas, sd4_ipas, 'Gaya, Gerak, dan Energi', 1),
    (elem_sd4_mtk, sd4_mtk, 'Luas & Keliling Bangun Datar', 1),
    (elem_sd4_inggris, sd4_inggris, 'Greetings & Personal Identity', 1),
    (elem_sd5_ipas, sd5_ipas, 'Ekosistem & Rantai Makanan', 1),
    (elem_sd5_mtk, sd5_mtk, 'Pecahan, Desimal, & Persen', 1),
    (elem_sd6_ipas, sd6_ipas, 'Sistem Tata Surya & Alam Semesta', 1),
    (elem_sd6_mtk, sd6_mtk, 'Pengolahan Data & Statistik Dasar', 1);

    INSERT INTO public.topics (id, element_id, name, slug, order_index, is_published) VALUES
    (top_sd4_gaya, elem_sd4_ipas, 'Pengaruh Gaya terhadap Gerak Benda', 'pengaruh-gaya-sd-4', 1, true),
    (top_sd4_luas, elem_sd4_mtk, 'Menghitung Keliling dan Luas Persegi Panjang', 'luas-persegi-panjang-sd-4', 1, true),
    (top_sd4_greeting, elem_sd4_inggris, 'Self Introduction & Greetings', 'self-introduction-sd-4', 1, true),
    (top_sd5_ekosistem, elem_sd5_ipas, 'Rantai Makanan dan Jaring-Jaring Makanan', 'rantai-makanan-sd-5', 1, true),
    (top_sd5_desimal, elem_sd5_mtk, 'Mengubah Pecahan Biasa ke Desimal dan Persen', 'pecahan-ke-desimal-sd-5', 1, true),
    (top_sd6_tatasurya, elem_sd6_ipas, 'Urutan Planet dalam Sistem Tata Surya', 'sistem-tata-surya-sd-6', 1, true),
    (top_sd6_statistik, elem_sd6_mtk, 'Menentukan Rata-rata (Mean) dan Modus Data', 'rata-rata-modus-sd-6', 1, true);
    IF top_sd4_gaya IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd4_gaya, 'regular', 'multiple_choice', 'Gaya yang bekerja saat buah kelapa jatuh dari pohonnya adalah gaya...', '[{"id": "opt_1", "text": "Gaya otot"}, {"id": "opt_2", "text": "Gaya gravitasi bumi"}, {"id": "opt_3", "text": "Gaya gesek"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Buah jatuh ke bumi karena adanya gaya gravitasi bumi.', 2, 10, NULL);
    END IF;

    IF top_sd4_gaya IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd4_gaya, 'regular', 'multiple_choice', 'Sepeda yang direm akan melambat lalu berhenti karena adanya gaya...', '[{"id": "opt_1", "text": "Gaya pegas"}, {"id": "opt_2", "text": "Gaya gesek"}, {"id": "opt_3", "text": "Gaya magnet"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Gesekan antara kampas rem dan roda menghasilkan gaya gesek.', 2, 10, NULL);
    END IF;

    IF top_sd4_luas IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd4_luas, 'regular', 'multiple_choice', 'Sebuah persegi panjang memiliki panjang 10 cm dan lebar 6 cm. Luas persegi panjang tersebut adalah...', '[{"id": "opt_1", "text": "16 cm\u00b2"}, {"id": "opt_2", "text": "32 cm\u00b2"}, {"id": "opt_3", "text": "60 cm\u00b2"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, 'Luas = panjang x lebar = 10 x 6 = 60 cm².', 2, 10, NULL);
    END IF;

    IF top_sd4_luas IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd4_luas, 'olympiad', 'multiple_choice', 'Keliling sebuah persegi adalah 36 cm. Berapa luas persegi tersebut?', '[{"id": "opt_1", "text": "81 cm\u00b2"}, {"id": "opt_2", "text": "64 cm\u00b2"}, {"id": "opt_3", "text": "49 cm\u00b2"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Sisi = 36 / 4 = 9 cm. Luas = 9 x 9 = 81 cm².', 2, 30, 45);
    END IF;

    IF top_sd4_greeting IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd4_greeting, 'regular', 'multiple_choice', 'What is the suitable response when someone says "Good Morning"?', '[{"id": "opt_1", "text": "Good Night"}, {"id": "opt_2", "text": "Good Morning"}, {"id": "opt_3", "text": "Good Bye"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Jawaban yang tepat untuk "Good Morning" adalah "Good Morning".', 2, 10, NULL);
    END IF;

    IF top_sd5_ekosistem IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd5_ekosistem, 'regular', 'multiple_choice', 'Dalam rantai makanan ekosistem sawah, tumbuhan padi berperan sebagai...', '[{"id": "opt_1", "text": "Konsumen tingkat 1"}, {"id": "opt_2", "text": "Produsen"}, {"id": "opt_3", "text": "Pengurai"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Tumbuhan hijau seperti padi mampu membuat makanan sendiri (produsen).', 2, 10, NULL);
    END IF;

    IF top_sd5_ekosistem IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd5_ekosistem, 'olympiad', 'multiple_choice', 'Jika populasi katak di sawah menurun drastis karena diburu, dampak yang akan terjadi pada populasi belalang adalah...', '[{"id": "opt_1", "text": "Menurun"}, {"id": "opt_2", "text": "Meningkat pesat"}, {"id": "opt_3", "text": "Tetap sama"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Katak adalah pemangsa belalang. Jika katak berkurang, belalang akan meningkat pesat.', 2, 30, 45);
    END IF;

    IF top_sd5_desimal IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd5_desimal, 'regular', 'multiple_choice', 'Pecahan 3/4 jika diubah ke dalam bentuk desimal adalah...', '[{"id": "opt_1", "text": "0,25"}, {"id": "opt_2", "text": "0,50"}, {"id": "opt_3", "text": "0,75"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, '3/4 = 3 x 25 / 100 = 75/100 = 0,75.', 2, 10, NULL);
    END IF;

    IF top_sd5_desimal IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd5_desimal, 'regular', 'multiple_choice', 'Bentuk persen dari pecahan 1/5 adalah...', '[{"id": "opt_1", "text": "10%"}, {"id": "opt_2", "text": "20%"}, {"id": "opt_3", "text": "25%"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '1/5 x 100% = 20%.', 2, 10, NULL);
    END IF;

    IF top_sd6_tatasurya IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd6_tatasurya, 'regular', 'multiple_choice', 'Planet terbesar dalam sistem tata surya kita adalah...', '[{"id": "opt_1", "text": "Mars"}, {"id": "opt_2", "text": "Yupiter (Jupiter)"}, {"id": "opt_3", "text": "Saturnus"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Yupiter adalah planet terbesar di tata surya.', 2, 10, NULL);
    END IF;

    IF top_sd6_tatasurya IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd6_tatasurya, 'regular', 'multiple_choice', 'Planet yang dijuluki sebagai "Planet Merah" adalah...', '[{"id": "opt_1", "text": "Merkurius"}, {"id": "opt_2", "text": "Mars"}, {"id": "opt_3", "text": "Venus"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Mars tampak kemerahan karena kandungan besi oksida di permukaannya.', 2, 10, NULL);
    END IF;

    IF top_sd6_tatasurya IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd6_tatasurya, 'olympiad', 'multiple_choice', 'Peristiwa pergantian siang dan malam serta gerak semu harian matahari terjadi akibat...', '[{"id": "opt_1", "text": "Rotasi bumi pada porosnya"}, {"id": "opt_2", "text": "Revolusi bumi mengelilingi matahari"}, {"id": "opt_3", "text": "Rotasi bulan"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Rotasi bumi (perputaran pada porosnya) menyebabkan pergantian siang dan malam.', 2, 30, 45);
    END IF;

    IF top_sd6_statistik IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd6_statistik, 'regular', 'multiple_choice', 'Data nilai matematika 5 siswa: 80, 90, 70, 80, 100. Nilai rata-rata (mean) adalah...', '[{"id": "opt_1", "text": "80"}, {"id": "opt_2", "text": "84"}, {"id": "opt_3", "text": "85"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Jumlah = 80+90+70+80+100 = 420. Rata-rata = 420 / 5 = 84.', 2, 10, NULL);
    END IF;

    IF top_sd456_statistik IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd456_statistik, 'olympiad', 'multiple_choice', 'Modus dari data nilai kuis: 6, 7, 8, 8, 8, 9, 10 adalah...', '[{"id": "opt_1", "text": "7"}, {"id": "opt_2", "text": "8"}, {"id": "opt_3", "text": "9"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Modus adalah nilai yang paling sering muncul yaitu angka 8 (muncul 3 kali).', 2, 30, 40);
    END IF;

END $$;

COMMIT;