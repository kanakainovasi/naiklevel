-- ==============================================================================
-- Seed SD Kelas 2 & SD Kelas 3 Curriculum & Question Bank
-- ==============================================================================

BEGIN;

DO $$
DECLARE
    sd2_id UUID := 'd4e5f6a1-b2c3-4d4e-bf5a-6b7c8d9ea0b1';
    sd3_id UUID := 'e5f6a1b2-c3d4-4e5f-c06b-7c8d9ea0b1c2';

    -- SD 2 Subject IDs
    sd2_mtk UUID := gen_random_uuid();
    sd2_indo UUID := gen_random_uuid();
    sd2_pancasila UUID := gen_random_uuid();
    sd2_pjok UUID := gen_random_uuid();
    sd2_seni UUID := gen_random_uuid();
    sd2_islam UUID := gen_random_uuid();

    -- SD 3 Subject IDs
    sd3_mtk UUID := gen_random_uuid();
    sd3_ipas UUID := gen_random_uuid();
    sd3_indo UUID := gen_random_uuid();
    sd3_pancasila UUID := gen_random_uuid();
    sd3_pjok UUID := gen_random_uuid();
    sd3_seni UUID := gen_random_uuid();
    sd3_islam UUID := gen_random_uuid();

    -- Element & Topic IDs SD 2
    elem_sd2_mtk UUID := gen_random_uuid();
    elem_sd2_indo UUID := gen_random_uuid();
    elem_sd2_pancasila UUID := gen_random_uuid();
    elem_sd2_pjok UUID := gen_random_uuid();
    elem_sd2_seni UUID := gen_random_uuid();
    elem_sd2_islam UUID := gen_random_uuid();

    top_sd2_perkalian UUID := gen_random_uuid();
    top_sd2_eyd UUID := gen_random_uuid();
    top_sd2_gotongroyong UUID := gen_random_uuid();
    top_sd2_senam UUID := gen_random_uuid();
    top_sd2_musik UUID := gen_random_uuid();
    top_sd2_sholat UUID := gen_random_uuid();

    -- Element & Topic IDs SD 3
    elem_sd3_mtk UUID := gen_random_uuid();
    elem_sd3_ipas UUID := gen_random_uuid();
    elem_sd3_indo UUID := gen_random_uuid();
    elem_sd3_pancasila UUID := gen_random_uuid();
    elem_sd3_pjok UUID := gen_random_uuid();
    elem_sd3_seni UUID := gen_random_uuid();
    elem_sd3_islam UUID := gen_random_uuid();

    top_sd3_pecahan UUID := gen_random_uuid();
    top_sd3_wujudbenda UUID := gen_random_uuid();
    top_sd3_idepokok UUID := gen_random_uuid();
    top_sd3_hak kewajiban UUID := gen_random_uuid();
    top_sd3_renang UUID := gen_random_uuid();
    top_sd3_tari UUID := gen_random_uuid();
    top_sd3_puasa UUID := gen_random_uuid();
BEGIN

    -- ==============================================================================
    -- 1. Subjects SD Kelas 2
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (sd2_mtk, sd2_id, 'Matematika', 'Matematika', 'matematika-sd-2', '🔢', 'Penjumlahan bersusun, perkalian dasar, dan bangun datar', 1),
    (sd2_indo, sd2_id, 'Bahasa Indonesia', 'Bahasa Indonesia', 'bahasa-indonesia-sd-2', '📖', 'Membaca lancar, kosakata baru, dan penulisan EYD', 2),
    (sd2_pancasila, sd2_id, 'Pendidikan Pancasila', 'Pendidikan Pancasila', 'pancasila-sd-2', '🦅', 'Musyawarah, gotong royong, dan hak & kewajiban di rumah', 3),
    (sd2_pjok, sd2_id, 'PJOK', 'Pendidikan Jasmani, Olahraga, dan Kesehatan', 'pjok-sd-2', '⚽', 'Gerak berirama, senam lantai, dan kebersihan diri', 4),
    (sd2_seni, sd2_id, 'Seni Budaya', 'Seni Rupa & Musik', 'seni-budaya-sd-2', '🎨', 'Mengenal tekstur, bunyi nada, dan kreasi barang bekas', 5),
    (sd2_islam, sd2_id, 'Agama Islam', 'Pendidikan Agama Islam', 'agama-islam-sd-2', '☪️', 'Hafalan surah pendek, sholat fardhu, dan akhlak terpuji', 6);

    -- ==============================================================================
    -- 2. Subjects SD Kelas 3
    -- ==============================================================================
    INSERT INTO public.subjects (id, education_level_id, name, official_name, slug, icon, description, order_index) VALUES
    (sd3_mtk, sd3_id, 'Matematika', 'Matematika', 'matematika-sd-3', '🔢', 'Perkalian, pembagian, pecahan sederhana, dan membaca jam', 1),
    (sd3_ipas, sd3_id, 'IPAS (Sains & Sosial)', 'Ilmu Pengetahuan Alam dan Sosial', 'ipas-sd-3', '🔬', 'Wujud benda, panca indra, siklus hidup, dan denah lingkungan', 2),
    (sd3_indo, sd3_id, 'Bahasa Indonesia', 'Bahasa Indonesia', 'bahasa-indonesia-sd-3', '📖', 'Ide pokok paragraf, dongeng, dan menulis karangan pendek', 3),
    (sd3_pancasila, sd3_id, 'Pendidikan Pancasila', 'Pendidikan Pancasila', 'pancasila-sd-3', '🦅', 'Keberagaman suku & budaya, norma masyarakat, dan SIM', 4),
    (sd3_pjok, sd3_id, 'PJOK', 'Pendidikan Jasmani', 'pjok-sd-3', '🏊‍♂️', 'Renang dasar, permainan bola kecil, dan daya tahan tubuh', 5),
    (sd3_seni, sd3_id, 'Seni Budaya', 'Seni Tari & Musik', 'seni-budaya-sd-3', '💃', 'Gerak tari daerah, pola irama lagu nasional, dan prakarya', 6),
    (sd3_islam, sd3_id, 'Agama Islam', 'Pendidikan Agama Islam', 'agama-islam-sd-3', '☪️', 'Kisah Nabi Muhammad SAW, puasa Ramadan, dan zakat', 7);

    -- ==============================================================================
    -- 3. Elements & Topics SD 2 & SD 3
    -- ==============================================================================
    INSERT INTO public.elements (id, subject_id, name, order_index) VALUES
    (elem_sd2_mtk, sd2_mtk, 'Perkalian Dasar & Bangun Datar', 1),
    (elem_sd2_indo, sd2_indo, 'Membaca Pemahaman & EYD', 1),
    (elem_sd2_pancasila, sd2_pancasila, 'Gotong Royong & Musyawarah', 1),
    (elem_sd3_mtk, sd3_mtk, 'Pecahan Sederhana & Waktu', 1),
    (elem_sd3_ipas, sd3_ipas, 'Wujud Benda & Siklus Hidup', 1),
    (elem_sd3_indo, sd3_indo, 'Ide Pokok & Teks Dongeng', 1);

    INSERT INTO public.topics (id, element_id, name, slug, order_index, is_published) VALUES
    (top_sd2_perkalian, elem_sd2_mtk, 'Konsep Perkalian sebagai Penjumlahan Berulang', 'konsep-perkalian-sd-2', 1, true),
    (top_sd2_eyd, elem_sd2_indo, 'Penggunaan Huruf Kapital dan Tanda Baca', 'penggunaan-eyd-sd-2', 1, true),
    (top_sd2_gotongroyong, elem_sd2_pancasila, 'Gotong Royong di Lingkungan Rumah', 'gotong-royong-sd-2', 1, true),
    (top_sd3_pecahan, elem_sd3_mtk, 'Mengenal Pecahan Sederhana (1/2, 1/3, 1/4)', 'pecahan-sederhana-sd-3', 1, true),
    (top_sd3_wujudbenda, elem_sd3_ipas, 'Wujud Benda Padat, Cair, dan Gas', 'wujud-benda-sd-3', 1, true),
    (top_sd3_idepokok, elem_sd3_indo, 'Menentukan Ide Pokok Paragraf', 'ide-pokok-sd-3', 1, true);
    IF top_sd2_perkalian IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd2_perkalian, 'regular', 'multiple_choice', '4 x 3 sama artinya dengan penjumlahan berulang...', '[{"id": "opt_1", "text": "3 + 3 + 3 + 3"}, {"id": "opt_2", "text": "4 + 4 + 4"}, {"id": "opt_3", "text": "4 + 3"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '4 x 3 artinya angka 3 dijumlahkan sebanyak 4 kali.', 1, 10, NULL);
    END IF;

    IF top_sd2_perkalian IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd2_perkalian, 'regular', 'multiple_choice', 'Hasil dari 5 x 2 adalah...', '[{"id": "opt_1", "text": "8"}, {"id": "opt_2", "text": "10"}, {"id": "opt_3", "text": "12"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '5 x 2 = 10.', 1, 10, NULL);
    END IF;

    IF top_sd2_perkalian IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd2_perkalian, 'olympiad', 'multiple_choice', 'Ada 6 piring. Setiap piring berisi 4 kue. Berapa jumlah seluruh kue?', '[{"id": "opt_1", "text": "20 kue"}, {"id": "opt_2", "text": "24 kue"}, {"id": "opt_3", "text": "28 kue"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '6 x 4 = 24 kue.', 1, 25, 40);
    END IF;

    IF top_sd2_eyd IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd2_eyd, 'regular', 'multiple_choice', 'Penulisan nama kota yang benar di bawah ini adalah...', '[{"id": "opt_1", "text": "jakarta"}, {"id": "opt_2", "text": "Jakarta"}, {"id": "opt_3", "text": "jaKarta"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Nama kota harus diawali huruf kapital.', 1, 10, NULL);
    END IF;

    IF top_sd2_gotongroyong IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd2_gotongroyong, 'regular', 'multiple_choice', 'Manfaat dari kegiatan gotong royong adalah...', '[{"id": "opt_1", "text": "Pekerjaan menjadi lebih cepat selesai"}, {"id": "opt_2", "text": "Pekerjaan menjadi makin berat"}, {"id": "opt_3", "text": "Membuat tetangga bertengkar"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Gotong royong membuat pekerjaan berat menjadi ringan.', 1, 10, NULL);
    END IF;

    IF top_sd3_pecahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd3_pecahan, 'regular', 'multiple_choice', 'Sebuah kue dibagi menjadi 4 bagian sama besar. Satu bagian nilainya...', '[{"id": "opt_1", "text": "1/2"}, {"id": "opt_2", "text": "1/3"}, {"id": "opt_3", "text": "1/4"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, '1 bagian dari 4 bagian bernilai pecahan 1/4.', 1, 10, NULL);
    END IF;

    IF top_sd3_pecahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd3_pecahan, 'regular', 'multiple_choice', 'Pecahan 1/2 dibaca...', '[{"id": "opt_1", "text": "Satu per dua (setengah)"}, {"id": "opt_2", "text": "Satu per tiga"}, {"id": "opt_3", "text": "Satu per empat"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '1/2 dibaca satu per dua atau setengah.', 1, 10, NULL);
    END IF;

    IF top_sd3_pecahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd3_pecahan, 'olympiad', 'multiple_choice', 'Ibu memotong semangka menjadi 8 bagian. Budi makan 2 bagian. Berapa bagian pecahan semangka yang dimakan Budi?', '[{"id": "opt_1", "text": "1/8"}, {"id": "opt_2", "text": "2/8"}, {"id": "opt_3", "text": "3/8"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Budi makan 2 dari 8 bagian = 2/8.', 1, 25, 40);
    END IF;

    IF top_sd3_wujudbenda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd3_wujudbenda, 'regular', 'multiple_choice', 'Minyak goreng dan air teh termasuk benda berwujud...', '[{"id": "opt_1", "text": "Padat"}, {"id": "opt_2", "text": "Cair"}, {"id": "opt_3", "text": "Gas"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Minyak dan air teh adalah benda cair.', 1, 10, NULL);
    END IF;

    IF top_sd3_wujudbenda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd3_wujudbenda, 'regular', 'multiple_choice', 'Batu, meja, dan pensil termasuk benda berwujud...', '[{"id": "opt_1", "text": "Padat"}, {"id": "opt_2", "text": "Cair"}, {"id": "opt_3", "text": "Gas"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Batu dan pensil adalah benda padat.', 1, 10, NULL);
    END IF;

    IF top_sd3_idepokok IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (top_sd3_idepokok, 'regular', 'multiple_choice', 'Gagasan utama yang menjadi inti pembahasan dalam sebuah paragraf disebut...', '[{"id": "opt_1", "text": "Ide pokok"}, {"id": "opt_2", "text": "Judul"}, {"id": "opt_3", "text": "Kalimat penutup"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Ide pokok adalah inti atau gagasan utama paragraf.', 1, 10, NULL);
    END IF;

END $$;

COMMIT;