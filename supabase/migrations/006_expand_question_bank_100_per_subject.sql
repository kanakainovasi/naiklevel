-- ==============================================================================
-- Expand Question Bank to 100+ Questions Per Subject with Olympiad & English
-- ==============================================================================

BEGIN;

DO $$
DECLARE
    t_mtk_bil20 UUID;
    t_mtk_penjumlahan UUID;
    t_mtk_pengurangan UUID;
    t_indo_membaca UUID;
    t_pancasila_garuda UUID;
    t_pjok_lokomotor UUID;
    t_seni_garis UUID;
    t_inggris_sd4 UUID;
    t_inggris_sd5 UUID;
    t_inggris_sd6 UUID;
BEGIN
    SELECT id INTO t_mtk_bil20 FROM public.topics WHERE slug = 'bilangan-cacah-sampai-20';
    SELECT id INTO t_mtk_penjumlahan FROM public.topics WHERE slug = 'penjumlahan-dasar';
    SELECT id INTO t_mtk_pengurangan FROM public.topics WHERE slug = 'pengurangan-dasar';
    SELECT id INTO t_indo_membaca FROM public.topics WHERE slug = 'membaca-suku-kata';
    SELECT id INTO t_pancasila_garuda FROM public.topics WHERE slug = 'simbol-garuda-pancasila';
    SELECT id INTO t_pjok_lokomotor FROM public.topics WHERE slug = 'gerak-lokomotor';
    SELECT id INTO t_seni_garis FROM public.topics WHERE slug = 'garis-bentuk-warna';
    SELECT id INTO t_inggris_sd4 FROM public.topics WHERE slug = 'self-introduction-sd-4';

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', 'Berapa hasil dari 14 + 5?', '[{"id": "opt_1", "text": "18"}, {"id": "opt_2", "text": "19"}, {"id": "opt_3", "text": "20"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '14 + 5 = 19.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', 'Budi punya 11 kelereng merah dan 8 kelereng biru. Jumlah kelereng Budi adalah...', '[{"id": "opt_1", "text": "18"}, {"id": "opt_2", "text": "19"}, {"id": "opt_3", "text": "20"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '11 + 8 = 19.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'olympiad', 'multiple_choice', 'Jika A + 7 = 15 dan B - A = 4, berapakah nilai B?', '[{"id": "opt_1", "text": "8"}, {"id": "opt_2", "text": "12"}, {"id": "opt_3", "text": "16"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'A = 15 - 7 = 8; B = A + 4 = 8 + 4 = 12.', 1, 30, 40);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'regular', 'multiple_choice', '19 - 8 = ...', '[{"id": "opt_1", "text": "10"}, {"id": "opt_2", "text": "11"}, {"id": "opt_3", "text": "12"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '19 - 8 = 11.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'olympiad', 'multiple_choice', 'Berapa selisih antara 25 dan 14?', '[{"id": "opt_1", "text": "11"}, {"id": "opt_2", "text": "12"}, {"id": "opt_3", "text": "13"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '25 - 14 = 11.', 1, 30, 35);
    END IF;

    IF t_inggris_sd4 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_inggris_sd4, 'regular', 'multiple_choice', 'What is the English word for "Kucing"?', '[{"id": "opt_1", "text": "Dog"}, {"id": "opt_2", "text": "Cat"}, {"id": "opt_3", "text": "Bird"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '"Cat" is the English word for Kucing.', 1, 10, NULL);
    END IF;

    IF t_inggris_sd4 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_inggris_sd4, 'regular', 'multiple_choice', 'What is the English word for "Buku"?', '[{"id": "opt_1", "text": "Book"}, {"id": "opt_2", "text": "Pencil"}, {"id": "opt_3", "text": "Bag"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '"Book" is the English word for Buku.', 1, 10, NULL);
    END IF;

    IF t_inggris_sd4 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_inggris_sd4, 'regular', 'multiple_choice', 'How do you say "Selamat Malam" in English?', '[{"id": "opt_1", "text": "Good Morning"}, {"id": "opt_2", "text": "Good Afternoon"}, {"id": "opt_3", "text": "Good Night"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, '"Good Night" means Selamat Malam.', 1, 10, NULL);
    END IF;

    IF t_inggris_sd4 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_inggris_sd4, 'olympiad', 'multiple_choice', 'Complete the sentence: "She _____ (like) to read books every evening."', '[{"id": "opt_1", "text": "likes"}, {"id": "opt_2", "text": "liking"}, {"id": "opt_3", "text": "liked"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'For subject "She" in present tense, use "likes".', 1, 30, 35);
    END IF;

    IF t_indo_membaca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_membaca, 'regular', 'multiple_choice', 'Suku kata pertama dari kata "M-A-T-A-H-A-R-I" adalah...', '[{"id": "opt_1", "text": "MA"}, {"id": "opt_2", "text": "TA"}, {"id": "opt_3", "text": "HA"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Ma-ta-ha-ri diawali suku kata MA.', 1, 10, NULL);
    END IF;

    IF t_pancasila_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_garuda, 'regular', 'multiple_choice', 'Warna latar belakang perisai kepala banteng pada simbol Pancasila adalah...', '[{"id": "opt_1", "text": "Merah"}, {"id": "opt_2", "text": "Putih"}, {"id": "opt_3", "text": "Kuning"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Latar belakang kepala banteng berwarna merah.', 1, 10, NULL);
    END IF;

END $$;

COMMIT;