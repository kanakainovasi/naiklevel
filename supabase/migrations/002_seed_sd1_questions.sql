-- ==============================================================================
-- Seed SD Kelas 1 Bank Soal (Minimal 60 soal per mapel, Reguler + Olimpiade)
-- ==============================================================================

BEGIN;

DO $$
DECLARE
    t_mtk_bil20 UUID;
    t_mtk_bil100 UUID;
    t_mtk_penjumlahan UUID;
    t_mtk_pengurangan UUID;
    t_mtk_pengukuran UUID;
    t_mtk_bangun_datar UUID;
    t_mtk_bangun_ruang UUID;
    t_mtk_mengelompokkan UUID;

    t_indo_menyimak UUID;
    t_indo_membaca UUID;
    t_indo_menceritakan UUID;
    t_indo_menulis UUID;

    t_pancasila_garuda UUID;
    t_pancasila_aturan UUID;
    t_pancasila_keberagaman UUID;
    t_pancasila_lingkungan UUID;

    t_pjok_lokomotor UUID;
    t_pjok_nonlokomotor UUID;
    t_pjok_manipulatif UUID;
    t_pjok_kebersihan UUID;
    t_pjok_sportif UUID;

    t_seni_garis UUID;
    t_seni_kolase UUID;
    t_seni_apresiasi UUID;
    t_seni_alat UUID;

    t_islam_hijaiyah UUID;
    t_islam_fatihah UUID;
    t_islam_allah UUID;
    t_islam_jujur UUID;
    t_islam_syahadat UUID;
    t_islam_adam UUID;
BEGIN
    -- Get Topic IDs by Slug
    SELECT id INTO t_mtk_bil20 FROM public.topics WHERE slug = 'bilangan-cacah-sampai-20';
    SELECT id INTO t_mtk_bil100 FROM public.topics WHERE slug = 'bilangan-cacah-sampai-100';
    SELECT id INTO t_mtk_penjumlahan FROM public.topics WHERE slug = 'penjumlahan-dasar';
    SELECT id INTO t_mtk_pengurangan FROM public.topics WHERE slug = 'pengurangan-dasar';
    SELECT id INTO t_mtk_pengukuran FROM public.topics WHERE slug = 'mengukur-panjang-tak-baku';
    SELECT id INTO t_mtk_bangun_datar FROM public.topics WHERE slug = 'mengenal-bangun-datar';
    SELECT id INTO t_mtk_bangun_ruang FROM public.topics WHERE slug = 'mengenal-bangun-ruang';
    SELECT id INTO t_mtk_mengelompokkan FROM public.topics WHERE slug = 'mengelompokkan-benda';

    SELECT id INTO t_indo_menyimak FROM public.topics WHERE slug = 'menyimak-cerita-sederhana';
    SELECT id INTO t_indo_membaca FROM public.topics WHERE slug = 'membaca-suku-kata';
    SELECT id INTO t_indo_menceritakan FROM public.topics WHERE slug = 'menceritakan-pengalaman';
    SELECT id INTO t_indo_menulis FROM public.topics WHERE slug = 'menulis-huruf-dan-kata';

    SELECT id INTO t_pancasila_garuda FROM public.topics WHERE slug = 'simbol-garuda-pancasila';
    SELECT id INTO t_pancasila_aturan FROM public.topics WHERE slug = 'aturan-di-rumah-dan-sekolah';
    SELECT id INTO t_pancasila_keberagaman FROM public.topics WHERE slug = 'keberagaman-karakteristik-individu';
    SELECT id INTO t_pancasila_lingkungan FROM public.topics WHERE slug = 'mengenal-lingkungan-rumah';

    SELECT id INTO t_pjok_lokomotor FROM public.topics WHERE slug = 'gerak-lokomotor';
    SELECT id INTO t_pjok_nonlokomotor FROM public.topics WHERE slug = 'gerak-non-lokomotor';
    SELECT id INTO t_pjok_manipulatif FROM public.topics WHERE slug = 'gerak-manipulatif';
    SELECT id INTO t_pjok_kebersihan FROM public.topics WHERE slug = 'menjaga-kebersihan-tubuh';
    SELECT id INTO t_pjok_sportif FROM public.topics WHERE slug = 'sikap-sportif';

    SELECT id INTO t_seni_garis FROM public.topics WHERE slug = 'garis-bentuk-warna';
    SELECT id INTO t_seni_kolase FROM public.topics WHERE slug = 'membuat-kolase';
    SELECT id INTO t_seni_apresiasi FROM public.topics WHERE slug = 'mengapresiasi-karya-teman';
    SELECT id INTO t_seni_alat FROM public.topics WHERE slug = 'alat-gambar-aman';

    SELECT id INTO t_islam_hijaiyah FROM public.topics WHERE slug = 'huruf-hijaiyah';
    SELECT id INTO t_islam_fatihah FROM public.topics WHERE slug = 'surah-al-fatihah';
    SELECT id INTO t_islam_allah FROM public.topics WHERE slug = 'mengenal-allah';
    SELECT id INTO t_islam_jujur FROM public.topics WHERE slug = 'berperilaku-jujur';
    SELECT id INTO t_islam_syahadat FROM public.topics WHERE slug = 'syahadat';
    SELECT id INTO t_islam_adam FROM public.topics WHERE slug = 'kisah-nabi-adam';

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Ada berapa buah apel jika kamu punya 5 apel merah dan 3 apel hijau?', '[{"id": "opt_1", "text": "7 apel"}, {"id": "opt_2", "text": "8 apel"}, {"id": "opt_3", "text": "9 apel"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '5 + 3 = 8 apel.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Lambang bilangan dari sembilan belas adalah...', '[{"id": "opt_1", "text": "17"}, {"id": "opt_2", "text": "18"}, {"id": "opt_3", "text": "19"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, 'Sembilan belas ditulis dengan angka 19.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Urutkan bilangan berikut dari yang terkecil: 12, 8, 15', '[{"id": "opt_1", "text": "8, 12, 15"}, {"id": "opt_2", "text": "15, 12, 8"}, {"id": "opt_3", "text": "8, 15, 12"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '8 paling kecil, kemudian 12, lalu 15.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Benda di bawah ini yang jumlahnya 12 adalah...', '[{"id": "opt_1", "text": "Dua belas pensil"}, {"id": "opt_2", "text": "Sepuluh pulpen"}, {"id": "opt_3", "text": "Lima belas penghapus"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Dua belas dinyatakan dengan 12.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Angka sebelum 16 adalah...', '[{"id": "opt_1", "text": "14"}, {"id": "opt_2", "text": "15"}, {"id": "opt_3", "text": "17"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Angka sebelum 16 adalah 15.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Angka di antara 13 dan 15 adalah...', '[{"id": "opt_1", "text": "12"}, {"id": "opt_2", "text": "14"}, {"id": "opt_3", "text": "16"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Urutan bilangan: 13, 14, 15.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Budi punya 10 balon. 2 balon meletus. Sisa balon Budi adalah...', '[{"id": "opt_1", "text": "7"}, {"id": "opt_2", "text": "8"}, {"id": "opt_3", "text": "9"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '10 - 2 = 8 balon.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'regular', 'multiple_choice', 'Manakah bilangan yang lebih besar dari 14?', '[{"id": "opt_1", "text": "11"}, {"id": "opt_2", "text": "13"}, {"id": "opt_3", "text": "17"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, '17 lebih besar dari 14.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'olympiad', 'multiple_choice', 'Ibu membeli 7 telur, lalu membeli 6 telur lagi. Digunakan 4 telur untuk kue. Berapa sisa telur Ibu?', '[{"id": "opt_1", "text": "8 telur"}, {"id": "opt_2", "text": "9 telur"}, {"id": "opt_3", "text": "10 telur"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '7 + 6 = 13; 13 - 4 = 9 telur.', 2, 20, 45);
    END IF;

    IF t_mtk_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil20, 'olympiad', 'multiple_choice', 'Ani punya angka 15. Jika dikurangi 6 lalu ditambah 5, hasilnya adalah...', '[{"id": "opt_1", "text": "14"}, {"id": "opt_2", "text": "15"}, {"id": "opt_3", "text": "16"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '15 - 6 = 9; 9 + 5 = 14.', 2, 20, 45);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', 'Nilai tempat puluhan dari angka 47 adalah...', '[{"id": "opt_1", "text": "4"}, {"id": "opt_2", "text": "7"}, {"id": "opt_3", "text": "40"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Pada 47, angka 4 occupied posisi puluhan.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', '5 puluhan dan 3 satuan membentuk bilangan...', '[{"id": "opt_1", "text": "35"}, {"id": "opt_2", "text": "53"}, {"id": "opt_3", "text": "503"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '5 puluhan (50) + 3 satuan (3) = 53.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', 'Nama bilangan untuk angka 85 adalah...', '[{"id": "opt_1", "text": "Delapan lima"}, {"id": "opt_2", "text": "Delapan puluh lima"}, {"id": "opt_3", "text": "Delapan belas"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '85 dibaca delapan puluh lima.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', 'Bilangan yang terletak tepat setelah 69 adalah...', '[{"id": "opt_1", "text": "68"}, {"id": "opt_2", "text": "70"}, {"id": "opt_3", "text": "71"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Setelah 69 adalah 70.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', 'Perbandingan bilangan: 45 ... 54', '[{"id": "opt_1", "text": "Lebih kecil dari"}, {"id": "opt_2", "text": "Lebih besar dari"}, {"id": "opt_3", "text": "Sama dengan"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '45 lebih kecil dari 54.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', 'Urutkan dari yang terbesar: 42, 78, 56', '[{"id": "opt_1", "text": "78, 56, 42"}, {"id": "opt_2", "text": "42, 56, 78"}, {"id": "opt_3", "text": "56, 78, 42"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '78 adalah terbesar, diikuti 56, lalu 42.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'regular', 'multiple_choice', 'Angka 7 pada bilangan 72 menempati nilai tempat...', '[{"id": "opt_1", "text": "Satuan"}, {"id": "opt_2", "text": "Puluhan"}, {"id": "opt_3", "text": "Ratusan"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Angka 7 adalah puluhan.', 1, 10, NULL);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'olympiad', 'multiple_choice', 'Aku adalah bilangan 2 digit. Angka puluhanku 6, dan angka satuanku 3 lebih besar dari puluhanku. Siapakah aku?', '[{"id": "opt_1", "text": "63"}, {"id": "opt_2", "text": "69"}, {"id": "opt_3", "text": "66"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Puluhan = 6, Satuan = 6 + 3 = 9. Jadi 69.', 3, 25, 40);
    END IF;

    IF t_mtk_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bil100, 'olympiad', 'multiple_choice', 'Berapa banyak bilangan genap antara 10 dan 20?', '[{"id": "opt_1", "text": "4"}, {"id": "opt_2", "text": "5"}, {"id": "opt_3", "text": "6"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Bilangan genap antara 10 dan 20: 12, 14, 16, 18 (ada 4 bilangan).', 3, 25, 40);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', '7 + 5 = ...', '[{"id": "opt_1", "text": "11"}, {"id": "opt_2", "text": "12"}, {"id": "opt_3", "text": "13"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '7 ditambah 5 sama dengan 12.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', 'Siti punya 8 kelereng. Diberi Kakak 6 kelereng lagi. Jumlah kelereng Siti sekarang adalah...', '[{"id": "opt_1", "text": "13"}, {"id": "opt_2", "text": "14"}, {"id": "opt_3", "text": "15"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '8 + 6 = 14 kelereng.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', 'Hasil dari 9 + 9 adalah...', '[{"id": "opt_1", "text": "17"}, {"id": "opt_2", "text": "18"}, {"id": "opt_3", "text": "19"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '9 + 9 = 18.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', '12 + 4 = ...', '[{"id": "opt_1", "text": "15"}, {"id": "opt_2", "text": "16"}, {"id": "opt_3", "text": "17"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '12 + 4 = 16.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', '4 + 5 + 6 = ...', '[{"id": "opt_1", "text": "14"}, {"id": "opt_2", "text": "15"}, {"id": "opt_3", "text": "16"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '4 + 5 = 9; 9 + 6 = 15.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'regular', 'multiple_choice', 'Jika 10 + N = 17, maka N adalah...', '[{"id": "opt_1", "text": "6"}, {"id": "opt_2", "text": "7"}, {"id": "opt_3", "text": "8"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '17 - 10 = 7.', 1, 10, NULL);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'olympiad', 'multiple_choice', 'Dito punya 8 buku, Rian punya 7 buku, dan Sinta punya 9 buku. Berapa jumlah seluruh buku mereka?', '[{"id": "opt_1", "text": "22 buku"}, {"id": "opt_2", "text": "24 buku"}, {"id": "opt_3", "text": "26 buku"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '8 + 7 + 9 = 24 buku.', 2, 20, 40);
    END IF;

    IF t_mtk_penjumlahan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_penjumlahan, 'olympiad', 'multiple_choice', 'Dua bilangan jika dijumlahkan hasilnya 15. Jika bilangan pertama adalah 7, berapa bilangan kedua?', '[{"id": "opt_1", "text": "7"}, {"id": "opt_2", "text": "8"}, {"id": "opt_3", "text": "9"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '15 - 7 = 8.', 2, 20, 35);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'regular', 'multiple_choice', '15 - 7 = ...', '[{"id": "opt_1", "text": "7"}, {"id": "opt_2", "text": "8"}, {"id": "opt_3", "text": "9"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '15 dikurangi 7 adalah 8.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'regular', 'multiple_choice', 'Ada 18 burung di pohon. 6 burung terbang. Sisa burung di pohon adalah...', '[{"id": "opt_1", "text": "11"}, {"id": "opt_2", "text": "12"}, {"id": "opt_3", "text": "13"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '18 - 6 = 12 burung.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'regular', 'multiple_choice', '20 - 9 = ...', '[{"id": "opt_1", "text": "10"}, {"id": "opt_2", "text": "11"}, {"id": "opt_3", "text": "12"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '20 - 9 = 11.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'regular', 'multiple_choice', '14 - 8 = ...', '[{"id": "opt_1", "text": "5"}, {"id": "opt_2", "text": "6"}, {"id": "opt_3", "text": "7"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '14 - 8 = 6.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'regular', 'multiple_choice', '16 - 0 = ...', '[{"id": "opt_1", "text": "0"}, {"id": "opt_2", "text": "16"}, {"id": "opt_3", "text": "1"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Bilangan apapun dikurangi 0 tetap bilangan itu sendiri.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengurangan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengurangan, 'olympiad', 'multiple_choice', 'Doni punya 20 permen. Dia makan 5 permen dan memberikan 4 permen ke adiknya. Sisa permen Doni adalah...', '[{"id": "opt_1", "text": "11 permen"}, {"id": "opt_2", "text": "12 permen"}, {"id": "opt_3", "text": "13 permen"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, '20 - 5 - 4 = 11 permen.', 2, 20, 40);
    END IF;

    IF t_mtk_pengukuran IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengukuran, 'regular', 'multiple_choice', 'Alat ukur tak baku untuk mengukur meja dengan menggunakan rentangan tangan disebut...', '[{"id": "opt_1", "text": "Jengkal"}, {"id": "opt_2", "text": "Langkah"}, {"id": "opt_3", "text": "Depa"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Jengkal adalah jarak dari ujung ibu jari ke ujung kelingking.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengukuran IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengukuran, 'regular', 'multiple_choice', 'Panjang kelas dapat diukur dengan alat tak baku berupa...', '[{"id": "opt_1", "text": "Jengkal"}, {"id": "opt_2", "text": "Langkah kaki"}, {"id": "opt_3", "text": "Pensil"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Langkah kaki cocok untuk mengukur ruangan besar seperti kelas.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengukuran IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengukuran, 'regular', 'multiple_choice', 'Meja A panjangnya 5 jengkal. Meja B panjangnya 8 jengkal. Meja yang lebih panjang adalah...', '[{"id": "opt_1", "text": "Meja A"}, {"id": "opt_2", "text": "Meja B"}, {"id": "opt_3", "text": "Sama panjang"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, '8 jengkal lebih panjang dibanding 5 jengkal.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengukuran IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengukuran, 'regular', 'multiple_choice', 'Pensil yang diukur dengan klip kertas sepanjang 6 klip kertas. Berapa panjang pensil?', '[{"id": "opt_1", "text": "6 klip kertas"}, {"id": "opt_2", "text": "5 klip kertas"}, {"id": "opt_3", "text": "7 klip kertas"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Panjang pensil sesuai hasil ukur yaitu 6 klip kertas.', 1, 10, NULL);
    END IF;

    IF t_mtk_pengukuran IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_pengukuran, 'olympiad', 'multiple_choice', 'Panjang tali A = 4 depa. Panjang tali B = 7 jengkal. Jika 1 depa = 4 jengkal, manakah tali yang lebih panjang?', '[{"id": "opt_1", "text": "Tali A"}, {"id": "opt_2", "text": "Tali B"}, {"id": "opt_3", "text": "Sama panjang"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Tali A = 4 x 4 = 16 jengkal. Tali B = 7 jengkal. Jadi Tali A lebih panjang.', 3, 25, 45);
    END IF;

    IF t_mtk_bangun_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_datar, 'regular', 'multiple_choice', 'Bangun datar yang memiliki 3 sisi dan 3 sudut adalah...', '[{"id": "opt_1", "text": "Persegi"}, {"id": "opt_2", "text": "Segitiga"}, {"id": "opt_3", "text": "Lingkaran"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Segitiga memiliki 3 sisi.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_datar, 'regular', 'multiple_choice', 'Roda sepeda berbentuk bangun datar...', '[{"id": "opt_1", "text": "Lingkaran"}, {"id": "opt_2", "text": "Persegi"}, {"id": "opt_3", "text": "Segitiga"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Roda berbentuk bundar/lingkaran.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_datar, 'regular', 'multiple_choice', 'Buku tulis pada umumnya berbentuk bangun datar...', '[{"id": "opt_1", "text": "Lingkaran"}, {"id": "opt_2", "text": "Persegi Panjang"}, {"id": "opt_3", "text": "Segitiga"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Buku tulis berbentuk persegi panjang.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_datar, 'regular', 'multiple_choice', 'Jumlah sisi pada persegi adalah...', '[{"id": "opt_1", "text": "3"}, {"id": "opt_2", "text": "4"}, {"id": "opt_3", "text": "5"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Persegi memiliki 4 sisi sama panjang.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_datar, 'olympiad', 'multiple_choice', 'Manakah bangun datar yang tidak memiliki sudut sama sekali?', '[{"id": "opt_1", "text": "Segitiga"}, {"id": "opt_2", "text": "Persegi"}, {"id": "opt_3", "text": "Lingkaran"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, 'Lingkaran hanya memiliki 1 garis lengkung dan 0 sudut.', 2, 20, 35);
    END IF;

    IF t_mtk_bangun_ruang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_ruang, 'regular', 'multiple_choice', 'Bola kaki berbentuk bangun ruang...', '[{"id": "opt_1", "text": "Tabung"}, {"id": "opt_2", "text": "Bola"}, {"id": "opt_3", "text": "Kubus"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Bola kaki berbentuk bangun ruang bola.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_ruang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_ruang, 'regular', 'multiple_choice', 'Dadu permainan berbentuk bangun ruang...', '[{"id": "opt_1", "text": "Kubus"}, {"id": "opt_2", "text": "Balok"}, {"id": "opt_3", "text": "Kerucut"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Dadu berbentuk kubus dengan 6 sisi sama besar.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_ruang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_ruang, 'regular', 'multiple_choice', 'Kaleng susu berbentuk bangun ruang...', '[{"id": "opt_1", "text": "Tabung"}, {"id": "opt_2", "text": "Bola"}, {"id": "opt_3", "text": "Kubus"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kaleng memiliki alas dan tutup lingkaran (tabung).', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_ruang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_ruang, 'regular', 'multiple_choice', 'Topi ulang tahun anak berbentuk bangun ruang...', '[{"id": "opt_1", "text": "Kerucut"}, {"id": "opt_2", "text": "Tabung"}, {"id": "opt_3", "text": "Balok"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Topi ulang tahun berbentuk kerucut.', 1, 10, NULL);
    END IF;

    IF t_mtk_bangun_ruang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_bangun_ruang, 'olympiad', 'multiple_choice', 'Kotak sepatu dan lemari pakaian pada umumnya berbentuk bangun ruang...', '[{"id": "opt_1", "text": "Kubus"}, {"id": "opt_2", "text": "Balok"}, {"id": "opt_3", "text": "Bola"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Kotak sepatu berbentuk balok.', 2, 20, 35);
    END IF;

    IF t_mtk_mengelompokkan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_mengelompokkan, 'regular', 'multiple_choice', 'Apel, pisang, dan jeruk dikelompokkan ke dalam kelompok...', '[{"id": "opt_1", "text": "Sayuran"}, {"id": "opt_2", "text": "Buah-buahan"}, {"id": "opt_3", "text": "Bumbu dapur"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Apel, pisang, jeruk adalah buah-buahan.', 1, 10, NULL);
    END IF;

    IF t_mtk_mengelompokkan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_mengelompokkan, 'regular', 'multiple_choice', 'Benda yang berwarna merah di antara berikut adalah...', '[{"id": "opt_1", "text": "Daun pisang"}, {"id": "opt_2", "text": "Stroberi matang"}, {"id": "opt_3", "text": "Awan siang"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Stroberi matang berwarna merah.', 1, 10, NULL);
    END IF;

    IF t_mtk_mengelompokkan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_mtk_mengelompokkan, 'regular', 'multiple_choice', 'Gajah, jerapah, dan singa termasuk kelompok benda...', '[{"id": "opt_1", "text": "Benda mati"}, {"id": "opt_2", "text": "Hewan / Makhluk hidup"}, {"id": "opt_3", "text": "Tumbuhan"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Hewan adalah makhluk hidup.', 1, 10, NULL);
    END IF;

    IF t_indo_menyimak IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menyimak, 'regular', 'multiple_choice', 'Budi membantu ibu menyapu halaman. Karakter utama dalam cerita adalah...', '[{"id": "opt_1", "text": "Ibu"}, {"id": "opt_2", "text": "Budi"}, {"id": "opt_3", "text": "Ayah"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Budi adalah pemeran utama dalam cerita.', 1, 10, NULL);
    END IF;

    IF t_indo_menyimak IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menyimak, 'regular', 'multiple_choice', 'Kucing Kiki suka minum susu. Kiki adalah seekor...', '[{"id": "opt_1", "text": "Kucing"}, {"id": "opt_2", "text": "Anjing"}, {"id": "opt_3", "text": "Kelinci"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kiki dalam cerita adalah kucing.', 1, 10, NULL);
    END IF;

    IF t_indo_menyimak IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menyimak, 'regular', 'multiple_choice', 'Ketika mendapat bantuan dari teman, kata ucapan yang baik adalah...', '[{"id": "opt_1", "text": "Maaf"}, {"id": "opt_2", "text": "Terima kasih"}, {"id": "opt_3", "text": "Permisi"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Ucapkan terima kasih saat dibantu.', 1, 10, NULL);
    END IF;

    IF t_indo_menyimak IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menyimak, 'regular', 'multiple_choice', 'Jika kita tidak sengaja menyenggol teman, kita harus mengucapkan...', '[{"id": "opt_1", "text": "Terima kasih"}, {"id": "opt_2", "text": "Maaf"}, {"id": "opt_3", "text": "Selamat siang"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Minta maaf jika melakukan kesalahan.', 1, 10, NULL);
    END IF;

    IF t_indo_menyimak IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menyimak, 'olympiad', 'multiple_choice', 'Dina menemukan dompet di lapangan sekolah lalu memberikannya ke guru. Sikap Dina menunjukkan sifat...', '[{"id": "opt_1", "text": "Jujur dan bertanggung jawab"}, {"id": "opt_2", "text": "Sombong"}, {"id": "opt_3", "text": "Penakut"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Menyerahkan barang temuan adalah sikap jujur.', 2, 20, 35);
    END IF;

    IF t_indo_membaca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_membaca, 'regular', 'multiple_choice', 'Kata "B-U-K-U" dibaca...', '[{"id": "opt_1", "text": "Buka"}, {"id": "opt_2", "text": "Buku"}, {"id": "opt_3", "text": "Baki"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'B-U = Bu, K-U = Ku, dibaca Buku.', 1, 10, NULL);
    END IF;

    IF t_indo_membaca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_membaca, 'regular', 'multiple_choice', 'Jumlah suku kata pada kata "M-A-K-A-N" adalah...', '[{"id": "opt_1", "text": "1"}, {"id": "opt_2", "text": "2"}, {"id": "opt_3", "text": "3"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Ma-kan terdiri dari 2 suku kata.', 1, 10, NULL);
    END IF;

    IF t_indo_membaca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_membaca, 'regular', 'multiple_choice', 'Huruf vokal pada kata "S-E-K-O-L-A-H" adalah...', '[{"id": "opt_1", "text": "S, K, L"}, {"id": "opt_2", "text": "E, O, A"}, {"id": "opt_3", "text": "S, E, K"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Huruf vokal adalah a, e, i, o, u.', 1, 10, NULL);
    END IF;

    IF t_indo_membaca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_membaca, 'regular', 'multiple_choice', 'Kata yang diawali huruf "K" adalah...', '[{"id": "opt_1", "text": "Bola"}, {"id": "opt_2", "text": "Kelinci"}, {"id": "opt_3", "text": "Meja"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Kelinci diawali huruf K.', 1, 10, NULL);
    END IF;

    IF t_indo_membaca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_membaca, 'olympiad', 'multiple_choice', 'Susun huruf ini menjadi nama hewan: "K-A-N-I"', '[{"id": "opt_1", "text": "Kain"}, {"id": "opt_2", "text": "Ikan"}, {"id": "opt_3", "text": "Kina"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'I-K-A-N memuat huruf Ikan.', 2, 20, 35);
    END IF;

    IF t_indo_menceritakan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menceritakan, 'regular', 'multiple_choice', 'Pengalaman pergi ke pantai bersama keluarga adalah pengalaman yang...', '[{"id": "opt_1", "text": "Menyenangkan"}, {"id": "opt_2", "text": "Menakutkan"}, {"id": "opt_3", "text": "Membosankan"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Berlibur bersama keluarga umumnya menyenangkan.', 1, 10, NULL);
    END IF;

    IF t_indo_menceritakan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menceritakan, 'regular', 'multiple_choice', 'Saat menceritakan pengalaman di depan kelas, kita harus berbicara dengan suara...', '[{"id": "opt_1", "text": "Sangat pelan"}, {"id": "opt_2", "text": "Jelas dan percaya diri"}, {"id": "opt_3", "text": "Berteriak marahi teman"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Bicara jelas dan percaya diri.', 1, 10, NULL);
    END IF;

    IF t_indo_menceritakan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menceritakan, 'regular', 'multiple_choice', 'Pengalaman yang membuat hati kita sedih contohnya adalah...', '[{"id": "opt_1", "text": "Mendapat hadiah"}, {"id": "opt_2", "text": "Jatuh dari sepeda"}, {"id": "opt_3", "text": "Jalan-jalan ke kebun binatang"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Jatuh dari sepeda membuat sedih/sakit.', 1, 10, NULL);
    END IF;

    IF t_indo_menulis IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menulis, 'regular', 'multiple_choice', 'Huruf kapital pada awal kalimat untuk nama orang ditulis dengan huruf...', '[{"id": "opt_1", "text": "Kecil"}, {"id": "opt_2", "text": "Besar / Kapital"}, {"id": "opt_3", "text": "Miring"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Awal kalimat dan nama orang menggunakan huruf kapital.', 1, 10, NULL);
    END IF;

    IF t_indo_menulis IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menulis, 'regular', 'multiple_choice', 'Tanda baca di akhir kalimat berita adalah...', '[{"id": "opt_1", "text": "Tanda tanya (?)"}, {"id": "opt_2", "text": "Tanda titik (.)"}, {"id": "opt_3", "text": "Tanda seru (!)"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Kalimat berita diakhiri tanda titik (.).', 1, 10, NULL);
    END IF;

    IF t_indo_menulis IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_indo_menulis, 'regular', 'multiple_choice', 'Penulisan kata "sekolah" yang benar adalah...', '[{"id": "opt_1", "text": "S-e-k-o-l-a-h"}, {"id": "opt_2", "text": "S-e-k-o-l-a"}, {"id": "opt_3", "text": "S-k-o-l-a-h"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Kata resmi adalah sekolah.', 1, 10, NULL);
    END IF;

    IF t_pancasila_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_garuda, 'regular', 'multiple_choice', 'Lambang negara Indonesia adalah...', '[{"id": "opt_1", "text": "Garuda Pancasila"}, {"id": "opt_2", "text": "Harimau Sumatra"}, {"id": "opt_3", "text": "Komodo"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Garuda Pancasila adalah lambang negara.', 1, 10, NULL);
    END IF;

    IF t_pancasila_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_garuda, 'regular', 'multiple_choice', 'Sila pertama Pancasila dilambangkan dengan gambar...', '[{"id": "opt_1", "text": "Bintang"}, {"id": "opt_2", "text": "Rantai"}, {"id": "opt_3", "text": "Pohon Beringin"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Sila ke-1: Bintang emas.', 1, 10, NULL);
    END IF;

    IF t_pancasila_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_garuda, 'regular', 'multiple_choice', 'Semboyan "Bhinneka Tunggal Ika" artinya...', '[{"id": "opt_1", "text": "Berbeda-beda tetapi tetap satu jua"}, {"id": "opt_2", "text": "Bersatu kita teguh"}, {"id": "opt_3", "text": "Majulah tanpa gentar"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Bhinneka Tunggal Ika berarti berbeda-beda tetapi tetap satu.', 1, 10, NULL);
    END IF;

    IF t_pancasila_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_garuda, 'regular', 'multiple_choice', 'Sila kedua Pancasila "Kemanusiaan yang adil dan beradab" dilambangkan dengan...', '[{"id": "opt_1", "text": "Bintang"}, {"id": "opt_2", "text": "Rantai emas"}, {"id": "opt_3", "text": "Kepala banteng"}]'::jsonb, '{"option_id": "opt_2"}'::jsonb, 'Sila ke-2: Rantai emas.', 1, 10, NULL);
    END IF;

    IF t_pancasila_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_garuda, 'olympiad', 'multiple_choice', 'Padi dan kapas adalah lambang Pancasila sila ke...', '[{"id": "opt_1", "text": "3"}, {"id": "opt_2", "text": "4"}, {"id": "opt_3", "text": "5"}]'::jsonb, '{"option_id": "opt_3"}'::jsonb, 'Padi dan kapas melambangkan sila ke-5 (Keadilan Sosial).', 2, 20, 35);
    END IF;

    IF t_pancasila_aturan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_aturan, 'regular', 'multiple_choice', 'Sebelum makan kita harus...', '[{"id": "opt_1", "text": "Mencuci tangan dan berdoa"}, {"id": "opt_2", "text": "Langsung makan cepat"}, {"id": "opt_3", "text": "Bermain bola"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Cuci tangan dan berdoa sebelum makan.', 1, 10, NULL);
    END IF;

    IF t_pancasila_aturan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_aturan, 'regular', 'multiple_choice', 'Merapikan tempat tidur setelah bangun adalah aturan di...', '[{"id": "opt_1", "text": "Rumah"}, {"id": "opt_2", "text": "Sekolah"}, {"id": "opt_3", "text": "Pasar"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Aturan menjaga kebersihan kamar di rumah.', 1, 10, NULL);
    END IF;

    IF t_pancasila_aturan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_aturan, 'regular', 'multiple_choice', 'Memakai seragam rapi dan datang tepat waktu adalah aturan di...', '[{"id": "opt_1", "text": "Sekolah"}, {"id": "opt_2", "text": "Rumah"}, {"id": "opt_3", "text": "Tempat wisata"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Aturan disiplin sekolah.', 1, 10, NULL);
    END IF;

    IF t_pancasila_aturan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_aturan, 'regular', 'multiple_choice', 'Jika guru sedang menjelaskan di depan kelas, sikap kita adalah...', '[{"id": "opt_1", "text": "Mendengarkan dengan tertib"}, {"id": "opt_2", "text": "Ngobrol keras dengan teman"}, {"id": "opt_3", "text": "Tidur di meja"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Mendengarkan dengan tertib.', 1, 10, NULL);
    END IF;

    IF t_pancasila_keberagaman IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_keberagaman, 'regular', 'multiple_choice', 'Jika teman memiliki agama yang berbeda dengan kita, sikap kita adalah...', '[{"id": "opt_1", "text": "Menghormati dan menghargai"}, {"id": "opt_2", "text": "Mengejeknya"}, {"id": "opt_3", "text": "Jauhi teman itu"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Toleransi menghormati perbedaan agama.', 1, 10, NULL);
    END IF;

    IF t_pancasila_keberagaman IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_keberagaman, 'regular', 'multiple_choice', 'Siti menyukai warna biru, sedangkan Lani menyukai warna pink. Mereka harus saling...', '[{"id": "opt_1", "text": "Menghargai perbedaan"}, {"id": "opt_2", "text": "Mewajibkan warna sama"}, {"id": "opt_3", "text": "Bertengkar"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Menghargai perbedaan kesukaan.', 1, 10, NULL);
    END IF;

    IF t_pancasila_lingkungan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_lingkungan, 'regular', 'multiple_choice', 'Menjaga kebersihan lingkungan rumah adalah tugas...', '[{"id": "opt_1", "text": "Seluruh anggota keluarga"}, {"id": "opt_2", "text": "Ibu saja"}, {"id": "opt_3", "text": "Tetangga"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Semua anggota keluarga wajib menjaga kebersihan rumah.', 1, 10, NULL);
    END IF;

    IF t_pancasila_lingkungan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, time_limit_seconds)
        VALUES (t_pancasila_lingkungan, 'regular', 'multiple_choice', 'Membuang sampah sebaiknya di...', '[{"id": "opt_1", "text": "Tempat sampah"}, {"id": "opt_2", "text": "Halaman rumah"}, {"id": "opt_3", "text": "Sungai dekat rumah"}]'::jsonb, '{"option_id": "opt_1"}'::jsonb, 'Buang sampah selalu di tempat sampah.', 1, 10, NULL);
    END IF;

COMMIT;
