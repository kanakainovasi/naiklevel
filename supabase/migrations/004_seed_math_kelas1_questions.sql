-- ==============================================================================
-- Migration: 004_seed_math_kelas1_questions.sql
-- Description: Seeds a comprehensive question bank of over 60 high-quality questions
--              for SD Kelas 1 Matematika across all 8 topics.
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

    -- ==============================================================================
    -- 1. BILANGAN CACAH SAMPAI 20 (8 Questions)
    -- ==============================================================================
    IF t_bil20 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_bil20, 'regular', 'multiple_choice', 'Berapakah lambang bilangan dari "sembilan belas"?', 
            '[{"id":"a","text":"16"},{"id":"b","text":"19"},{"id":"c","text":"91"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sembilan belas ditulis 19.', 1, 10, false, 11),
        (t_bil20, 'regular', 'multiple_choice', 'Bila dihitung mundur dari 10: 10, 9, 8, ... Bilangan selanjutnya adalah...', 
            '[{"id":"a","text":"7"},{"id":"b","text":"6"},{"id":"c","text":"9"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Hitung mundur setelah 8 adalah 7.', 1, 10, false, 12),
        (t_bil20, 'regular', 'multiple_choice', 'Manakah kelompok buah yang berjumlah tepat 15?', 
            '[{"id":"a","text":"10 Apel dan 5 Pisang"},{"id":"b","text":"8 Jeruk dan 6 Salak"},{"id":"c","text":"9 Mangga dan 4 Rambutan"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, '10 + 5 = 15 buah.', 1, 10, false, 13),
        (t_bil20, 'regular', 'multiple_choice', 'Angka satuan pada bilangan 18 adalah...', 
            '[{"id":"a","text":"1"},{"id":"b","text":"8"},{"id":"c","text":"18"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '1 adalah puluhan dan 8 adalah satuan.', 1, 10, false, 14),
        (t_bil20, 'regular', 'multiple_choice', 'Bilangan yang berada tepat setelah 11 dan sebelum 13 adalah...', 
            '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"14"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bilangan di antara 11 dan 13 adalah 12.', 1, 10, false, 15),
        (t_bil20, 'regular', 'multiple_choice', 'Lengkapi deret bilangan berikut: 12, 14, 16, ...', 
            '[{"id":"a","text":"17"},{"id":"b","text":"18"},{"id":"c","text":"20"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Pola bertambah 2: setelah 16 adalah 18.', 1, 10, false, 16),
        (t_bil20, 'olympiad', 'multiple_choice', 'Budi berdiri di antrean nomor 8 dari depan, sedangkan Ani berdiri di antrean nomor 17. Ada berapa anak di antara Budi dan Ani?', 
            '[{"id":"a","text":"7 anak"},{"id":"b","text":"8 anak"},{"id":"c","text":"9 anak"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Anak di antara nomor 8 dan 17 adalah nomor 9, 10, 11, 12, 13, 14, 15, 16 (8 anak).', 2, 25, false, 17),
        (t_bil20, 'olympiad', 'multiple_choice', 'Ada 20 kelereng. Kakak mengambil 6 kelereng, lalu adik mengambil 7 kelereng. Berapa sisa kelereng sekarang?', 
            '[{"id":"a","text":"6 kelereng"},{"id":"b","text":"7 kelereng"},{"id":"c","text":"8 kelereng"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '20 - 6 - 7 = 7 kelereng.', 2, 25, false, 18);
    END IF;

    -- ==============================================================================
    -- 2. BILANGAN CACAH SAMPAI 100 (8 Questions)
    -- ==============================================================================
    IF t_bil100 IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_bil100, 'regular', 'multiple_choice', 'Lambang bilangan dari "tujuh puluh empat" adalah...', 
            '[{"id":"a","text":"47"},{"id":"b","text":"74"},{"id":"c","text":"704"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Tujuh puluh empat ditulis 74.', 1, 10, false, 1),
        (t_bil100, 'regular', 'multiple_choice', 'Angka 8 pada bilangan 85 menempati nilai tempat...', 
            '[{"id":"a","text":"Satuan"},{"id":"b","text":"Puluhan"},{"id":"c","text":"Ratusan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '8 menempati puluhan (80) dan 5 menempati satuan.', 1, 10, false, 2),
        (t_bil100, 'regular', 'multiple_choice', 'Bilangan yang lebih besar dari 68 adalah...', 
            '[{"id":"a","text":"65"},{"id":"b","text":"70"},{"id":"c","text":"59"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '70 lebih besar dari 68.', 1, 10, false, 3),
        (t_bil100, 'regular', 'multiple_choice', 'Urutan bilangan 42, 24, 38 dari yang paling kecil adalah...', 
            '[{"id":"a","text":"24, 38, 42"},{"id":"b","text":"42, 38, 24"},{"id":"c","text":"38, 24, 42"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Urutan terkecil: 24, 38, 42.', 1, 10, false, 4),
        (t_bil100, 'regular', 'multiple_choice', 'Bilangan sebelum 50 adalah...', 
            '[{"id":"a","text":"48"},{"id":"b","text":"49"},{"id":"c","text":"51"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sebelum 50 adalah 49.', 1, 10, false, 5),
        (t_bil100, 'regular', 'multiple_choice', 'Berapa jumlah puluhan dari bilangan 90?', 
            '[{"id":"a","text":"9 puluhan"},{"id":"b","text":"0 puluhan"},{"id":"c","text":"90 puluhan"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, '90 = 9 puluhan.', 1, 10, false, 6),
        (t_bil100, 'olympiad', 'multiple_choice', 'Aku adalah bilangan di antara 80 dan 90. Jika angka satuanku ditambah angka puluhanku hasilnya 13, bilangan berapakah aku?', 
            '[{"id":"a","text":"84"},{"id":"b","text":"85"},{"id":"c","text":"86"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Angka puluhanku adalah 8 (karena di antara 80-90). Maka satuanku: 13 - 8 = 5. Jadi bilangannya 85.', 2, 25, false, 7),
        (t_bil100, 'olympiad', 'multiple_choice', 'Halaman buku Dika bernomor dari 1 sampai 50. Berapa kali angka 5 ditulis pada nomor halaman buku tersebut?', 
            '[{"id":"a","text":"5 kali"},{"id":"b","text":"6 kali"},{"id":"c","text":"7 kali"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Angka 5 muncul pada halaman: 5, 15, 25, 35, 45, dan 50 (Total 6 kali).', 2, 25, false, 8);
    END IF;

    -- ==============================================================================
    -- 3. PENJUMLAHAN DASAR (8 Questions)
    -- ==============================================================================
    IF t_tambah IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_tambah, 'regular', 'multiple_choice', 'Hasil dari 9 + 7 adalah...', 
            '[{"id":"a","text":"15"},{"id":"b","text":"16"},{"id":"c","text":"17"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '9 + 7 = 16.', 1, 10, false, 4),
        (t_tambah, 'regular', 'multiple_choice', 'Rini punya 6 boneka. Rara punya 5 boneka. Jumlah boneka mereka berdua adalah...', 
            '[{"id":"a","text":"10"},{"id":"b","text":"11"},{"id":"c","text":"12"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '6 + 5 = 11 boneka.', 1, 10, false, 5),
        (t_tambah, 'regular', 'multiple_choice', 'Penjumlahan yang menghasilkan angka 15 adalah...', 
            '[{"id":"a","text":"8 + 7"},{"id":"b","text":"9 + 5"},{"id":"c","text":"7 + 7"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, '8 + 7 = 15.', 1, 10, false, 6),
        (t_tambah, 'regular', 'multiple_choice', 'Lengkapi penjumlahan berikut: 8 + ... = 14', 
            '[{"id":"a","text":"5"},{"id":"b","text":"6"},{"id":"c","text":"7"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '14 - 8 = 6.', 1, 10, false, 7),
        (t_tambah, 'regular', 'multiple_choice', 'Kakak membeli 5 jeruk, ibu membeli 8 jeruk. Total jeruk seluruhnya adalah...', 
            '[{"id":"a","text":"12"},{"id":"b","text":"13"},{"id":"c","text":"14"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '5 + 8 = 13.', 1, 10, false, 8),
        (t_tambah, 'regular', 'multiple_choice', 'Hasil dari 4 + 3 + 5 adalah...', 
            '[{"id":"a","text":"11"},{"id":"b","text":"12"},{"id":"c","text":"13"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '4 + 3 + 5 = 12.', 1, 10, false, 9),
        (t_tambah, 'olympiad', 'multiple_choice', 'Setiap kali Budi menjawab kuis benar, ia mendapat 3 bintang. Budi sudah menjawab 4 kuis dengan benar. Kakak memberikan bonus 5 bintang lagi. Berapa total bintang Budi sekarang?', 
            '[{"id":"a","text":"15 bintang"},{"id":"b","text":"17 bintang"},{"id":"c","text":"18 bintang"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '(4 kuis x 3 bintang) + 5 = 12 + 5 = 17 bintang.', 2, 25, false, 10),
        (t_tambah, 'olympiad', 'multiple_choice', 'Sebuah kue dipotong menjadi beberapa bagian. Ayah makan 3 bagian, Ibu makan 2 bagian, dan masih sisa 4 bagian. Menjadi berapa bagian kue tersebut dipotong semula?', 
            '[{"id":"a","text":"8 bagian"},{"id":"b","text":"9 bagian"},{"id":"c","text":"10 bagian"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Jumlah awal kue = dimakan ayah + dimakan ibu + sisa = 3 + 2 + 4 = 9 bagian.', 2, 25, false, 11);
    END IF;

    -- ==============================================================================
    -- 4. PENGURANGAN DASAR (8 Questions)
    -- ==============================================================================
    IF t_kurang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_kurang, 'regular', 'multiple_choice', 'Hasil pengurangan dari 18 - 6 adalah...', 
            '[{"id":"a","text":"11"},{"id":"b","text":"12"},{"id":"c","text":"13"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '18 - 6 = 12.', 1, 10, false, 3),
        (t_kurang, 'regular', 'multiple_choice', 'Tomi punya 14 krayon. Dia meminjamkan 5 krayon ke Doni. Sisa krayon Tomi yang masih dipegang adalah...', 
            '[{"id":"a","text":"8 krayon"},{"id":"b","text":"9 krayon"},{"id":"c","text":"10 krayon"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '14 - 5 = 9 krayon.', 1, 10, false, 4),
        (t_kurang, 'regular', 'multiple_choice', 'Pengurangan yang hasilnya adalah 7 adalah...', 
            '[{"id":"a","text":"12 - 5"},{"id":"b","text":"15 - 9"},{"id":"c","text":"11 - 5"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, '12 - 5 = 7.', 1, 10, false, 5),
        (t_kurang, 'regular', 'multiple_choice', 'Lengkapi pengurangan berikut: 20 - ... = 11', 
            '[{"id":"a","text":"8"},{"id":"b","text":"9"},{"id":"c","text":"10"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '20 - 11 = 9.', 1, 10, false, 6),
        (t_kurang, 'regular', 'multiple_choice', 'Ibu membeli 12 piring gelas. Sayangnya pecah di jalan sebanyak 3 gelas. Berapa gelas yang tidak pecah?', 
            '[{"id":"a","text":"8 gelas"},{"id":"b","text":"9 gelas"},{"id":"c","text":"10 gelas"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '12 - 3 = 9 gelas.', 1, 10, false, 7),
        (t_kurang, 'regular', 'multiple_choice', 'Berapa hasil dari 15 - 4 - 3?', 
            '[{"id":"a","text":"7"},{"id":"b","text":"8"},{"id":"c","text":"9"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '15 - 4 = 11, kemudian 11 - 3 = 8.', 1, 10, false, 8),
        (t_kurang, 'olympiad', 'multiple_choice', 'Andi memiliki beberapa kelereng. Setelah memberikan 6 kelereng ke adik dan kalah bermain 4 kelereng, kelereng Andi sisa 8. Berapa jumlah kelereng Andi semula?', 
            '[{"id":"a","text":"16 kelereng"},{"id":"b","text":"18 kelereng"},{"id":"c","text":"20 kelereng"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Jumlah awal = sisa + diberikan + kalah = 8 + 6 + 4 = 18 kelereng.', 2, 25, false, 9),
        (t_kurang, 'olympiad', 'multiple_choice', 'Di dalam bus sekolah ada 15 anak. Di halte A turun 4 anak, lalu naik 6 anak baru. Berapa jumlah anak di bus sekarang?', 
            '[{"id":"a","text":"16 anak"},{"id":"b","text":"17 anak"},{"id":"c","text":"18 anak"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '15 - 4 (turun) + 6 (naik) = 17 anak.', 2, 25, false, 10);
    END IF;

    -- ==============================================================================
    -- 5. MENGUKUR PANJANG DENGAN SATUAN TAK BAKU (8 Questions)
    -- ==============================================================================
    IF t_ukur IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_ukur, 'regular', 'multiple_choice', 'Alat ukur panjang tak baku yang diukur dengan jari tangan dari jempol ke kelingking dinamakan...', 
            '[{"id":"a","text":"Jengkal"},{"id":"b","text":"Depa"},{"id":"c","text":"Langkah"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Pengukuran tersebut dinamakan jengkal.', 1, 10, false, 1),
        (t_ukur, 'regular', 'multiple_choice', 'Mengukur lebar ruang kelas paling mudah dengan menggunakan satuan tak baku...', 
            '[{"id":"a","text":"Jengkal"},{"id":"b","text":"Langkah kaki"},{"id":"c","text":"Klip kertas"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Langkah kaki lebih praktis untuk mengukur area lantai yang luas seperti kelas.', 1, 10, false, 2),
        (t_ukur, 'regular', 'multiple_choice', 'Panjang meja adalah 5 jengkal ayah atau 7 jengkal anak. Mengapa angkanya berbeda?', 
            '[{"id":"a","text":"Jengkal ayah lebih panjang"},{"id":"b","text":"Jengkal anak lebih panjang"},{"id":"c","text":"Meja bertambah panjang"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Jengkal ayah lebih panjang, sehingga butuh lebih sedikit jengkal dibanding anak.', 1, 10, false, 3),
        (t_ukur, 'regular', 'multiple_choice', 'Depa adalah pengukuran panjang tak baku menggunakan...', 
            '[{"id":"a","text":"Langkah kaki"},{"id":"b","text":"Rentangan kedua tangan"},{"id":"c","text":"Panjang lengan ke telapak"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Depa diukur dari ujung tangan kanan ke ujung tangan kiri yang direntangkan.', 1, 10, false, 4),
        (t_ukur, 'regular', 'multiple_choice', 'Jika panjang buku tulis adalah 4 klip kertas dan panjang kotak pensil adalah 6 klip kertas. Manakah yang lebih panjang?', 
            '[{"id":"a","text":"Buku tulis"},{"id":"b","text":"Kotak pensil"},{"id":"c","text":"Sama panjang"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '6 klip kertas > 4 klip kertas, maka kotak pensil lebih panjang.', 1, 10, false, 5),
        (t_ukur, 'regular', 'multiple_choice', 'Manakah di bawah ini yang merupakan satuan pengukuran panjang tidak baku?', 
            '[{"id":"a","text":"Meter"},{"id":"b","text":"Centimeter"},{"id":"c","text":"Jengkal"}]'::jsonb, 
            '{"option_id":"c"}'::jsonb, 'Jengkal nilainya bervariasi bergantung ukuran tangan orang, maka disebut tidak baku.', 1, 10, false, 6),
        (t_ukur, 'olympiad', 'multiple_choice', 'Sebuah papan tulis memiliki panjang 3 depa Budi. Jika 1 depa Budi sama dengan 4 jengkal tangannya, berapa jengkal panjang papan tulis tersebut?', 
            '[{"id":"a","text":"10 jengkal"},{"id":"b","text":"12 jengkal"},{"id":"c","text":"14 jengkal"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '3 depa x 4 jengkal = 12 jengkal.', 2, 25, false, 7),
        (t_ukur, 'olympiad', 'multiple_choice', 'Sebuah tali jemuran panjangnya 10 langkah kaki. Tali itu dipotong sepanjang 3 depa tangan. Jika 1 depa sama dengan 2 langkah kaki, berapa langkah kaki sisa tali sekarang?', 
            '[{"id":"a","text":"4 langkah"},{"id":"b","text":"5 langkah"},{"id":"c","text":"6 langkah"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Potongan tali = 3 depa x 2 langkah = 6 langkah. Sisa tali = 10 - 6 = 4 langkah kaki.', 2, 25, false, 8);
    END IF;

    -- ==============================================================================
    -- 6. MENGENAL BANGUN DATAR (8 Questions)
    -- ==============================================================================
    IF t_datar IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_datar, 'regular', 'multiple_choice', 'Bangun datar yang memiliki 4 sisi sama panjang dan 4 sudut siku-siku adalah...', 
            '[{"id":"a","text":"Persegi"},{"id":"b","text":"Segitiga"},{"id":"c","text":"Lingkaran"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Persegi memiliki keempat sisi yang persis sama panjang.', 1, 10, false, 3),
        (t_datar, 'regular', 'multiple_choice', 'Permukaan meja sekolah dan lembar kertas buku tulis berbentuk...', 
            '[{"id":"a","text":"Segitiga"},{"id":"b","text":"Segi empat"},{"id":"c","text":"Lingkaran"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Berbentuk segi empat (persegi panjang).', 1, 10, false, 4),
        (t_datar, 'regular', 'multiple_choice', 'Uang koin logam dan jam dinding bulat merupakan contoh bentuk...', 
            '[{"id":"a","text":"Lingkaran"},{"id":"b","text":"Persegi"},{"id":"c","text":"Segitiga"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Berbentuk melingkar (lingkaran).', 1, 10, false, 5),
        (t_datar, 'regular', 'multiple_choice', 'Segitiga adalah bangun datar yang memiliki titik sudut sebanyak...', 
            '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Segitiga memiliki 3 titik sudut dan 3 sisi.', 1, 10, false, 6),
        (t_datar, 'regular', 'multiple_choice', 'Manakah di bawah ini benda yang permukaannya berbentuk segitiga?', 
            '[{"id":"a","text":"Papan tulis"},{"id":"b","text":"Penggaris segitiga"},{"id":"c","text":"Piring makan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Penggaris segitiga berbentuk segitiga.', 1, 10, false, 7),
        (t_datar, 'regular', 'multiple_choice', 'Perbedaan persegi dengan persegi panjang terletak pada...', 
            '[{"id":"a","text":"Jumlah sudutnya"},{"id":"b","text":"Panjang sisi-sisinya"},{"id":"c","text":"Bentuk lengkungannya"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Persegi semua sisinya sama panjang, persegi panjang hanya sisi berhadapan yang sama panjang.', 1, 10, false, 8),
        (t_datar, 'olympiad', 'multiple_choice', 'Sebuah potongan kertas berbentuk persegi dilipat tepat di tengah secara diagonal (pojok ke pojok). Bangun datar baru apa yang terbentuk?', 
            '[{"id":"a","text":"Segitiga"},{"id":"b","text":"Lingkaran"},{"id":"c","text":"Persegi panjang"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Melipat persegi secara diagonal membelahnya menjadi dua segitiga sama kaki.', 2, 25, false, 9),
        (t_datar, 'olympiad', 'multiple_choice', 'Dika memotong sebuah kertas persegi panjang menjadi dua bagian yang sama besar secara mendatar. Bangun apa yang ia dapatkan?', 
            '[{"id":"a","text":"Dua Segitiga"},{"id":"b","text":"Dua Lingkaran"},{"id":"c","text":"Dua Persegi panjang"}]'::jsonb, 
            '{"option_id":"c"}'::jsonb, 'Kertas persegi panjang dipotong lurus mendatar menghasilkan dua persegi panjang kecil.', 2, 25, false, 10);
    END IF;

    -- ==============================================================================
    -- 7. MENGENAL BANGUN RUANG (8 Questions)
    -- ==============================================================================
    IF t_ruang IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_ruang, 'regular', 'multiple_choice', 'Benda yang menyerupai bangun ruang bola di bawah ini adalah...', 
            '[{"id":"a","text":"Kelereng"},{"id":"b","text":"Kotak pensil"},{"id":"c","text":"Kaleng susu"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Kelereng berbentuk bulat seperti bola.', 1, 10, false, 1),
        (t_ruang, 'regular', 'multiple_choice', 'Dadu permainan monopoli berbentuk bangun ruang...', 
            '[{"id":"a","text":"Kubus"},{"id":"b","text":"Balok"},{"id":"c","text":"Tabung"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Dadu memiliki 6 sisi persegi yang sama besar, maka berbentuk kubus.', 1, 10, false, 2),
        (t_ruang, 'regular', 'multiple_choice', 'Lemari es dan dus sepatu berbentuk bangun ruang...', 
            '[{"id":"a","text":"Balok"},{"id":"b","text":"Kubus"},{"id":"c","text":"Bola"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Berbentuk memanjang dengan sisi persegi panjang, yaitu balok.', 1, 10, false, 3),
        (t_ruang, 'regular', 'multiple_choice', 'Kaleng biskuit dan celengan berbentuk bangun ruang...', 
            '[{"id":"a","text":"Kerucut"},{"id":"b","text":"Tabung"},{"id":"c","text":"Kubus"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Memiliki alas dan tutup lingkaran serta dinding melengkung, yaitu tabung.', 1, 10, false, 4),
        (t_ruang, 'regular', 'multiple_choice', 'Bentuk topi ulang tahun dan tumpeng nasi adalah...', 
            '[{"id":"a","text":"Tabung"},{"id":"b","text":"Kerucut"},{"id":"c","text":"Balok"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Berbentuk mengerucut ke satu titik puncak (kerucut).', 1, 10, false, 5),
        (t_ruang, 'regular', 'multiple_choice', 'Bangun ruang kubus memiliki total sisi sebanyak...', 
            '[{"id":"a","text":"4 sisi"},{"id":"b","text":"6 sisi"},{"id":"c","text":"8 sisi"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kubus memiliki 6 sisi berbentuk persegi.', 1, 10, false, 6),
        (t_ruang, 'olympiad', 'multiple_choice', 'Sebuah tabung dipotong melintang secara mendatar. Berbentuk bangun datar apakah permukaan hasil potongan tersebut?', 
            '[{"id":"a","text":"Lingkaran"},{"id":"b","text":"Segitiga"},{"id":"c","text":"Persegi"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Tabung memiliki penampang lingkaran di sepanjang tingginya.', 2, 25, false, 7),
        (t_ruang, 'olympiad', 'multiple_choice', 'Sebuah ruangan berbentuk balok. Berapa jumlah pojok ruangan (titik sudut) yang ada pada ruangan tersebut?', 
            '[{"id":"a","text":"6 titik"},{"id":"b","text":"8 titik"},{"id":"c","text":"12 titik"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Balok memiliki 8 titik sudut/pojok.', 2, 25, false, 8);
    END IF;

    -- ==============================================================================
    -- 8. MENGELOMPOKKAN BENDA (8 Questions)
    -- ==============================================================================
    IF t_kelompok IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_kelompok, 'regular', 'multiple_choice', 'Bayam, wortel, dan kol dimasukkan ke dalam kelompok...', 
            '[{"id":"a","text":"Sayur-sayuran"},{"id":"b","text":"Buah-buahan"},{"id":"c","text":"Lauk-pauk"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Benda-benda tersebut adalah jenis sayur.', 1, 10, false, 1),
        (t_kelompok, 'regular', 'multiple_choice', 'Manakah di bawah ini benda yang tidak cocok berada dalam satu kelompok alat tulis sekolah?', 
            '[{"id":"a","text":"Buku tulis"},{"id":"b","text":"Sendok makan"},{"id":"c","text":"Pensil kayu"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sendok makan adalah alat makan, bukan alat tulis.', 1, 10, false, 2),
        (t_kelompok, 'regular', 'multiple_choice', 'Siti mengelompokkan apel, cabai merah, dan stroberi bersama-sama. Pengelompokan ini berdasarkan kesamaan...', 
            '[{"id":"a","text":"Rasa"},{"id":"b","text":"Warna"},{"id":"c","text":"Ukuran"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Semua benda tersebut berwarna merah.', 1, 10, false, 3),
        (t_kelompok, 'regular', 'multiple_choice', 'Kucing, kelinci, dan kambing masuk dalam satu kelompok karena semuanya...', 
            '[{"id":"a","text":"Berkaki empat"},{"id":"b","text":"Suka wortel"},{"id":"c","text":"Bisa terbang"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Ketiga hewan tersebut memiliki 4 kaki.', 1, 10, false, 4),
        (t_kelompok, 'regular', 'multiple_choice', 'Piring, mangkok, dan gelas dikelompokkan ke dalam kategori...', 
            '[{"id":"a","text":"Alat makan"},{"id":"b","text":"Alat tulis"},{"id":"c","text":"Mainan anak"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Merupakan peralatan makan.', 1, 10, false, 5),
        (t_kelompok, 'regular', 'multiple_choice', 'Benda yang permukaannya berbentuk lingkaran seperti ban sepeda dan cincin dikelompokkan berdasarkan...', 
            '[{"id":"a","text":"Bentuk"},{"id":"b","text":"Bahan"},{"id":"c","text":"Berat"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Dikelompokkan berdasarkan kesamaan bentuk geometri lingkaran.', 1, 10, false, 6),
        (t_kelompok, 'olympiad', 'multiple_choice', 'Ada 5 benda: Penghapus, Sabun mandi, Sikat gigi, Odol, Handuk. Benda mana yang TIDAK masuk ke dalam kelompok perlengkapan mandi?', 
            '[{"id":"a","text":"Handuk"},{"id":"b","text":"Penghapus"},{"id":"c","text":"Sikat gigi"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Penghapus adalah alat tulis, bukan perlengkapan mandi.', 2, 25, false, 7),
        (t_kelompok, 'olympiad', 'multiple_choice', 'Kakak menyusun mainan berdasarkan ukuran: Kecil, Sedang, dan Besar. Di manakah boneka beruang berukuran 40 cm harus diletakkan jika ukuran kecil adalah <15 cm dan besar adalah >50 cm?', 
            '[{"id":"a","text":"Kelompok kecil"},{"id":"b","text":"Kelompok sedang"},{"id":"c","text":"Kelompok besar"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, '40 cm berada di antara 15 cm dan 50 cm, sehingga termasuk kelompok sedang.', 2, 25, false, 8);
    END IF;
END $$;
