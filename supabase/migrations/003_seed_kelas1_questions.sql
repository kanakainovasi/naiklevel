-- ==============================================================================
-- Migration: 003_seed_kelas1_questions.sql
-- Description: Inserts foundational Bank Soal for SD Kelas 1 (Matematika Flagship, Bahasa Indonesia, Pancasila, PJOK, Seni Rupa, Agama).
-- ==============================================================================

DO $$
DECLARE
    -- Matematika Topics
    t_bil20 UUID;
    t_bil100 UUID;
    t_tambah UUID;
    t_kurang UUID;
    t_ukur UUID;
    t_datar UUID;
    t_ruang UUID;
    t_kelompok UUID;

    -- Bahasa Indonesia Topics
    t_simak UUID;
    t_baca UUID;
    t_bicara UUID;
    t_tulis UUID;

    -- Pancasila Topics
    t_garuda UUID;
    t_aturan UUID;

BEGIN
    -- Get topic IDs from slug
    SELECT id INTO t_bil20 FROM public.topics WHERE slug = 'bilangan-cacah-sampai-20' LIMIT 1;
    SELECT id INTO t_bil100 FROM public.topics WHERE slug = 'bilangan-cacah-sampai-100' LIMIT 1;
    SELECT id INTO t_tambah FROM public.topics WHERE slug = 'penjumlahan-dasar' LIMIT 1;
    SELECT id INTO t_kurang FROM public.topics WHERE slug = 'pengurangan-dasar' LIMIT 1;
    SELECT id INTO t_ukur FROM public.topics WHERE slug = 'mengukur-panjang-tak-baku' LIMIT 1;
    SELECT id INTO t_datar FROM public.topics WHERE slug = 'mengenal-bangun-datar' LIMIT 1;
    SELECT id INTO t_ruang FROM public.topics WHERE slug = 'mengenal-bangun-ruang' LIMIT 1;
    SELECT id INTO t_kelompok FROM public.topics WHERE slug = 'mengelompokkan-benda' LIMIT 1;

    SELECT id INTO t_simak FROM public.topics WHERE slug = 'menyimak-cerita-sederhana' LIMIT 1;
    SELECT id INTO t_baca FROM public.topics WHERE slug = 'membaca-suku-kata' LIMIT 1;
    SELECT id INTO t_garuda FROM public.topics WHERE slug = 'simbol-garuda-pancasila' LIMIT 1;
    SELECT id INTO t_aturan FROM public.topics WHERE slug = 'aturan-di-rumah-dan-sekolah' LIMIT 1;

    -- ==============================================================================
    -- 1. MATEMATIKA — Bilangan Cacah sampai 20
    -- ==============================================================================
    IF t_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_bil20, 'regular', 'multiple_choice', 'Berapakah jumlah apel jika ada 7 apel merah dan 5 apel hijau?', 
            '[{"id":"a","text":"11"},{"id":"b","text":"12"},{"id":"c","text":"13"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '7 + 5 = 12 apel.', 1, 10, false, 1),
        (t_bil20, 'regular', 'multiple_choice', 'Manakah bilangan yang lebih besar dari 14?', 
            '[{"id":"a","text":"12"},{"id":"b","text":"14"},{"id":"c","text":"16"}]'::jsonb, 
            '{"option_id":"c"}'::jsonb, '16 lebih besar dari 14.', 1, 10, false, 2),
        (t_bil20, 'regular', 'multiple_choice', 'Urutkan bilangan berikut dari yang terkecil: 15, 9, 12', 
            '[{"id":"a","text":"9, 12, 15"},{"id":"b","text":"15, 12, 9"},{"id":"c","text":"12, 9, 15"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Urutan terkecil ke terbesar: 9, 12, 15.', 1, 10, false, 3),
        (t_bil20, 'olympiad', 'multiple_choice', 'Aku sebuah bilangan. Jika ditambah 4 hasilnya 15. Bilangan siapakah aku?', 
            '[{"id":"a","text":"10"},{"id":"b","text":"11"},{"id":"c","text":"12"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '15 - 4 = 11. Jadi aku adalah 11.', 2, 25, false, 4);
    END IF;

    -- ==============================================================================
    -- 2. MATEMATIKA — Penjumlahan Dasar
    -- ==============================================================================
    IF t_tambah IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_tambah, 'regular', 'multiple_choice', 'Hasil dari 8 + 6 adalah...', 
            '[{"id":"a","text":"13"},{"id":"b","text":"14"},{"id":"c","text":"15"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '8 + 6 = 14.', 1, 10, false, 1),
        (t_tambah, 'regular', 'multiple_choice', 'Budi punya 9 kelereng. Ibu memberi Budi 4 kelereng lagi. Berapa total kelereng Budi?', 
            '[{"id":"a","text":"13"},{"id":"b","text":"12"},{"id":"c","text":"14"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, '9 + 4 = 13 kelereng.', 1, 10, false, 2),
        (t_tambah, 'olympiad', 'multiple_choice', 'Ada 3 kotak. Kotak A berisi 4 bola, Kotak B berisi 5 bola, dan Kotak C berisi 6 bola. Berapa jumlah seluruh bola?', 
            '[{"id":"a","text":"14"},{"id":"b","text":"15"},{"id":"c","text":"16"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '4 + 5 + 6 = 15 bola.', 2, 25, false, 3);
    END IF;

    -- ==============================================================================
    -- 3. MATEMATIKA — Pengurangan Dasar
    -- ==============================================================================
    IF t_kurang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_kurang, 'regular', 'multiple_choice', 'Hasil dari 15 - 7 adalah...', 
            '[{"id":"a","text":"7"},{"id":"b","text":"8"},{"id":"c","text":"9"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '15 - 7 = 8.', 1, 10, false, 1),
        (t_kurang, 'regular', 'multiple_choice', 'Siti membawa 12 kue. Dimakan adik 5 kue. Berapa sisa kue Siti?', 
            '[{"id":"a","text":"7"},{"id":"b","text":"6"},{"id":"c","text":"8"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, '12 - 5 = 7 kue.', 1, 10, false, 2);
    END IF;

    -- ==============================================================================
    -- 4. MATEMATIKA — Mengenal Bangun Datar
    -- ==============================================================================
    IF t_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_datar, 'regular', 'multiple_choice', 'Bangun datar yang memiliki 3 sisi dan 3 sudut dinamakan...', 
            '[{"id":"a","text":"Persegi"},{"id":"b","text":"Segitiga"},{"id":"c","text":"Lingkaran"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Segitiga memiliki 3 sisi dan 3 sudut.', 1, 10, false, 1),
        (t_datar, 'regular', 'multiple_choice', 'Uang koin dan roda sepeda berbentuk bangun datar...', 
            '[{"id":"a","text":"Lingkaran"},{"id":"b","text":"Persegi"},{"id":"c","text":"Segitiga"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Koin dan roda berbentuk bulat lingkaran.', 1, 10, false, 2);
    END IF;

    -- ==============================================================================
    -- 5. BAHASA INDONESIA — Membaca Suku Kata
    -- ==============================================================================
    IF t_baca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_baca, 'regular', 'multiple_choice', 'Kata "BUKU" terdiri dari berapa suku kata?', 
            '[{"id":"a","text":"1 suku kata"},{"id":"b","text":"2 suku kata (bu - ku)"},{"id":"c","text":"3 suku kata"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bu-ku terdiri dari 2 suku kata.', 1, 10, false, 1),
        (t_baca, 'regular', 'multiple_choice', 'Gabungan suku kata "se - ka - lah" menjadi kata...', 
            '[{"id":"a","text":"Sekolah"},{"id":"b","text":"Sepeda"},{"id":"c","text":"Matahari"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'se-ka-lah dibaca sekolah.', 1, 10, false, 2);
    END IF;

    -- ==============================================================================
    -- 6. PENDIDIKAN PANCASILA — Simbol Garuda
    -- ==============================================================================
    IF t_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_garuda, 'regular', 'multiple_choice', 'Simbol sila pertama Pancasila ("Ketuhanan Yang Maha Esa") adalah...', 
            '[{"id":"a","text":"Bintang"},{"id":"b","text":"Rantai"},{"id":"c","text":"Pohon Beringin"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Sila ke-1 dilambangkan dengan Bintang Emas.', 1, 10, false, 1),
        (t_garuda, 'regular', 'multiple_choice', 'Pohon Beringin adalah simbol Pancasila sila ke-...', 
            '[{"id":"a","text":"Ke-2"},{"id":"b","text":"Ke-3"},{"id":"c","text":"Ke-4"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sila ke-3 (Persatuan Indonesia) dilambangkan Pohon Beringin.', 1, 10, false, 2);
    END IF;

END $$;
