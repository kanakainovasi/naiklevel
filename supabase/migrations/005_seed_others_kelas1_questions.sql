-- ==============================================================================
-- Migration: 005_seed_others_kelas1_questions.sql
-- Description: Seeds 60 questions for Pendidikan Pancasila and 60 questions for
--              Bahasa Indonesia (SD Kelas 1) to meet MVP content requirements.
-- ==============================================================================

DO $$
DECLARE
    -- Pancasila Topics
    t_garuda UUID;
    t_aturan UUID;
    t_ragam UUID;
    t_rumah UUID;

    -- Bahasa Indonesia Topics
    t_simak UUID;
    t_baca UUID;
    t_cerita UUID;
    t_tulis UUID;
BEGIN
    -- Get Pancasila Topic IDs
    SELECT id INTO t_garuda FROM public.topics WHERE slug = 'simbol-garuda-pancasila' LIMIT 1;
    SELECT id INTO t_aturan FROM public.topics WHERE slug = 'aturan-di-rumah-dan-sekolah' LIMIT 1;
    SELECT id INTO t_ragam FROM public.topics WHERE slug = 'keberagaman-karakteristik-individu' LIMIT 1;
    SELECT id INTO t_rumah FROM public.topics WHERE slug = 'mengenal-lingkungan-rumah' LIMIT 1;

    -- Get Bahasa Indonesia Topic IDs
    SELECT id INTO t_simak FROM public.topics WHERE slug = 'menyimak-cerita-sederhana' LIMIT 1;
    SELECT id INTO t_baca FROM public.topics WHERE slug = 'membaca-suku-kata' LIMIT 1;
    SELECT id INTO t_cerita FROM public.topics WHERE slug = 'menceritakan-pengalaman' LIMIT 1;
    SELECT id INTO t_tulis FROM public.topics WHERE slug = 'menulis-huruf-dan-kata' LIMIT 1;

    -- ==============================================================================
    -- PENDIDIKAN PANCASILA — SIMBOL GARUDA PANCASILA (13 Questions)
    -- ==============================================================================
    IF t_garuda IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_garuda, 'regular', 'multiple_choice', 'Lambang negara bangsa Indonesia adalah...', 
            '[{"id":"a","text":"Bendera Merah Putih"},{"id":"b","text":"Garuda Pancasila"},{"id":"c","text":"Lagu Indonesia Raya"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Garuda Pancasila adalah lambang negara Indonesia.', 1, 10, false, 3),
        (t_garuda, 'regular', 'multiple_choice', 'Simbol kepala banteng melambangkan sila Pancasila yang ke-...', 
            '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sila ke-4 dilambangkan dengan Kepala Banteng.', 1, 10, false, 4),
        (t_garuda, 'regular', 'multiple_choice', 'Rantai emas melambangkan sila Pancasila yang ke-...', 
            '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sila ke-2 dilambangkan dengan rantai emas berbentuk lingkaran dan persegi.', 1, 10, false, 5),
        (t_garuda, 'regular', 'multiple_choice', 'Simbol padi dan kapas melambangkan keadilan sosial bagi seluruh rakyat Indonesia pada sila ke-...', 
            '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"}]'::jsonb, 
            '{"option_id":"c"}'::jsonb, 'Sila ke-5 dilambangkan dengan padi dan kapas.', 1, 10, false, 6),
        (t_garuda, 'regular', 'multiple_choice', 'Warna latar belakang simbol Bintang Emas pada dada perisai Garuda adalah...', 
            '[{"id":"a","text":"Merah"},{"id":"b","text":"Hitam"},{"id":"c","text":"Hijau"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Latar belakang Bintang Emas berwarna hitam melambangkan keilahian.', 1, 10, false, 7),
        (t_garuda, 'regular', 'multiple_choice', 'Tulisan semboyan pada pita yang dicengkeram kaki burung Garuda berbunyi...', 
            '[{"id":"a","text":"Tut Wuri Handayani"},{"id":"b","text":"Bhinneka Tunggal Ika"},{"id":"c","text":"Ing Ngarso Sung Tulodo"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Mencengkeram pita bertuliskan Bhinneka Tunggal Ika.', 1, 10, false, 8),
        (t_garuda, 'regular', 'multiple_choice', 'Jumlah bulu pada leher burung Garuda Pancasila melambangkan angka...', 
            '[{"id":"a","text":"17"},{"id":"b","text":"45"},{"id":"c","text":"19"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bulu leher berjumlah 45 buah, melambangkan tahun kemerdekaan 1945.', 1, 10, false, 9),
        (t_garuda, 'regular', 'multiple_choice', 'Masing-masing sayap burung Garuda Pancasila memiliki bulu berjumlah...', 
            '[{"id":"a","text":"17 helai"},{"id":"b","text":"8 helai"},{"id":"c","text":"45 helai"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Jumlah bulu sayap adalah 17 helai melambangkan tanggal 17 Agustus.', 1, 10, false, 10),
        (t_garuda, 'regular', 'multiple_choice', 'Bunyi sila ke-2 Pancasila adalah...', 
            '[{"id":"a","text":"Persatuan Indonesia"},{"id":"b","text":"Kemanusiaan yang adil dan beradab"},{"id":"c","text":"Ketuhanan Yang Maha Esa"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sila ke-2 berbunyi Kemanusiaan yang adil dan beradab.', 1, 10, false, 11),
        (t_garuda, 'regular', 'multiple_choice', 'Warna kuning keemasan pada tubuh burung Garuda melambangkan...', 
            '[{"id":"a","text":"Keberanian"},{"id":"b","text":"Keagungan dan kejayaan"},{"id":"c","text":"Kesucian"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kuning emas melambangkan keagungan bangsa.', 1, 10, false, 12),
        (t_garuda, 'regular', 'multiple_choice', 'Burung Garuda menolehkan kepalanya ke arah...', 
            '[{"id":"a","text":"Kiri"},{"id":"b","text":"Kanan"},{"id":"c","text":"Depan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kepala menoleh ke sebelah kanan melambangkan kebenaran.', 1, 10, false, 13),
        (t_garuda, 'olympiad', 'multiple_choice', 'Mengapa lambang sila ke-4 berupa Kepala Banteng?', 
            '[{"id":"a","text":"Karena banteng adalah hewan yang kuat dan berani"},{"id":"b","text":"Karena banteng suka berkumpul dan bermusyawarah"},{"id":"c","text":"Karena banteng mudah dipelihara"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Banteng merupakan hewan sosial yang suka berkumpul, melambangkan musyawarah.', 2, 25, false, 14),
        (t_garuda, 'olympiad', 'multiple_choice', 'Total helai bulu pada ekor burung Garuda melambangkan angka bulan kemerdekaan Indonesia yaitu...', 
            '[{"id":"a","text":"8 helai (Agustus)"},{"id":"b","text":"17 helai (Agustus)"},{"id":"c","text":"45 helai (Agustus)"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Bulu ekor berjumlah 8 helai melambangkan bulan ke-8 (Agustus).', 2, 25, false, 15);
    END IF;

    -- ==============================================================================
    -- PENDIDIKAN PANCASILA — ATURAN DI RUMAH DAN SEKOLAH (13 Questions)
    -- ==============================================================================
    IF t_aturan IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_aturan, 'regular', 'multiple_choice', 'Manakah di bawah ini yang merupakan tujuan dibuatnya aturan?', 
            '[{"id":"a","text":"Membuat hidup jadi susah"},{"id":"b","text":"Membuat lingkungan tertib"},{"id":"c","text":"Menghukum anak nakal"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Aturan dibuat untuk mewujudkan ketertiban.', 1, 10, false, 3),
        (t_aturan, 'regular', 'multiple_choice', 'Contoh mematuhi aturan di rumah setelah bangun tidur adalah...', 
            '[{"id":"a","text":"Langsung bermain HP"},{"id":"b","text":"Merapikan tempat tidur"},{"id":"c","text":"Meninggalkan kamar berantakan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Merapikan tempat tidur adalah aturan menjaga kerapihan rumah.', 1, 10, false, 4),
        (t_aturan, 'regular', 'multiple_choice', 'Sebelum melangkahkan kaki pergi ke sekolah, kita wajib...', 
            '[{"id":"a","text":"Jajan es krim"},{"id":"b","text":"Berpamitan dan cium tangan orang tua"},{"id":"c","text":"Berteriak pamit dari jauh"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Berpamitan adalah bentuk sopan santun di rumah.', 1, 10, false, 5),
        (t_aturan, 'regular', 'multiple_choice', 'Aturan mengenakan seragam sekolah yang bersih dan lengkap wajib dipatuhi di...', 
            '[{"id":"a","text":"Rumah"},{"id":"b","text":"Sekolah"},{"id":"c","text":"Taman bermain"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Seragam adalah aturan resmi sekolah.', 1, 10, false, 6),
        (t_aturan, 'regular', 'multiple_choice', 'Saat guru sedang menjelaskan materi pelajaran di kelas, sikap kita yang benar adalah...', 
            '[{"id":"a","text":"Mengobrol dengan teman"},{"id":"b","text":"Mendengarkan dengan tenang"},{"id":"c","text":"Menggambar di meja"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Menyimak guru adalah tanda menghargai guru di kelas.', 1, 10, false, 7),
        (t_aturan, 'regular', 'multiple_choice', 'Siapakah yang berkewajiban mematuhi aturan di rumah?', 
            '[{"id":"a","text":"Hanya anak"},{"id":"b","text":"Hanya ibu"},{"id":"c","text":"Semua anggota keluarga"}]'::jsonb, 
            '{"option_id":"c"}'::jsonb, 'Aturan rumah berlaku untuk seluruh anggota keluarga.', 1, 10, false, 8),
        (t_aturan, 'regular', 'multiple_choice', 'Menjaga kebersihan ruang kelas dengan cara menyapu saat jadwal piket adalah aturan di...', 
            '[{"id":"a","text":"Rumah"},{"id":"b","text":"Sekolah"},{"id":"c","text":"Toko mainan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Piket kelas merupakan tanggung jawab siswa di sekolah.', 1, 10, false, 9),
        (t_aturan, 'regular', 'multiple_choice', 'Membuang sampah bekas jajanan sekolah harus di...', 
            '[{"id":"a","text":"Kolong meja"},{"id":"b","text":"Tempat sampah"},{"id":"c","text":"Halaman sekolah"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sampah wajib dibuang ke tempat sampah agar lingkungan sehat.', 1, 10, false, 10),
        (t_aturan, 'regular', 'multiple_choice', 'Sebelum makan bersama keluarga di meja makan, aturan pertamanya adalah...', 
            '[{"id":"a","text":"Langsung makan"},{"id":"b","text":"Mencuci tangan dan berdoa"},{"id":"c","text":"Berbicara keras-keras"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Mencuci tangan menjaga kesehatan, dan berdoa tanda syukur.', 1, 10, false, 11),
        (t_aturan, 'regular', 'multiple_choice', 'Datang tepat waktu sebelum bel masuk berbunyi merupakan wujud aturan...', 
            '[{"id":"a","text":"Disiplin sekolah"},{"id":"b","text":"Kebersihan rumah"},{"id":"c","text":"Sopan santun tetangga"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Datang tepat waktu melatih kedisiplinan di sekolah.', 1, 10, false, 12),
        (t_aturan, 'regular', 'multiple_choice', 'Membantu menyapu halaman rumah adalah bentuk bantuan anak kepada...', 
            '[{"id":"a","text":"Guru"},{"id":"b","text":"Orang tua"},{"id":"c","text":"Teman sekelas"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Membantu menyapu meringankan beban orang tua.', 1, 10, false, 13),
        (t_aturan, 'olympiad', 'multiple_choice', 'Doni terlambat bangun karena tidur terlalu malam. Akibatnya ia terlambat masuk sekolah. Apa yang harus Doni lakukan agar tidak terulang?', 
            '[{"id":"a","text":"Tidur lebih cepat dan memasang alarm"},{"id":"b","text":"Meminta orang tua menulis surat izin sakit palsu"},{"id":"c","text":"Berhenti sekolah"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Tidur tepat waktu adalah kunci kedisiplinan pagi hari.', 2, 25, false, 14),
        (t_aturan, 'olympiad', 'multiple_choice', 'Mengapa aturan membuang sampah di got sekitar rumah sangat penting?', 
            '[{"id":"a","text":"Agar air got bisa diminum"},{"id":"b","text":"Mencegah banjir dan sarang penyakit nyamuk"},{"id":"c","text":"Agar got terlihat indah"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sampah di got menyumbat air (banjir) dan menggenang menjadi sarang nyamuk.', 2, 25, false, 15);
    END IF;

    -- ==============================================================================
    -- PENDIDIKAN PANCASILA — KEBERAGAMAN KARAKTERISTIK INDIVIDU (15 Questions)
    -- ==============================================================================
    IF t_ragam IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_ragam, 'regular', 'multiple_choice', 'Tuhan menciptakan manusia dalam bentuk yang...', 
            '[{"id":"a","text":"Sama semua"},{"id":"b","text":"Berbeda-beda dan unik"},{"id":"c","text":"Mirip robot"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Manusia diciptakan berbeda-beda agar saling mengenal.', 1, 10, false, 1),
        (t_ragam, 'regular', 'multiple_choice', 'Rambut keriting, rambut lurus, dan kulit sawo matang adalah bentuk keberagaman...', 
            '[{"id":"a","text":"Fisik"},{"id":"b","text":"Hobi"},{"id":"c","text":"Sifat"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Ciri fisik terlihat langsung pada anggota tubuh.', 1, 10, false, 2),
        (t_ragam, 'regular', 'multiple_choice', 'Budi gemar bermain sepak bola, sedangkan Andi suka menggambar. Sikap mereka sebaiknya...', 
            '[{"id":"a","text":"Saling menghina hobi teman"},{"id":"b","text":"Saling menghormati kegemaran masing-masing"},{"id":"c","text":"Memaksa Andi ikut bermain bola"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Menghormati kegemaran mewujudkan perdamaian.', 1, 10, false, 3),
        (t_ragam, 'regular', 'multiple_choice', 'Walaupun berbeda kegemaran bermain, saat waktu istirahat sekolah kita harus...', 
            '[{"id":"a","text":"Bermain sendiri-sendiri"},{"id":"b","text":"Tetap rukun dan berteman"},{"id":"c","text":"Musuhan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kerukunan harus dijaga dalam perbedaan.', 1, 10, false, 4),
        (t_ragam, 'regular', 'multiple_choice', 'Sikap toleransi beragama artinya kita harus...', 
            '[{"id":"a","text":"Melarang agama lain beribadah"},{"id":"b","text":"Menghargai cara ibadah agama lain"},{"id":"c","text":"Mengikuti ibadah agama lain"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Toleransi adalah menghargai ibadah orang lain tanpa mengganggu.', 1, 10, false, 5),
        (t_ragam, 'regular', 'multiple_choice', 'Menghargai keberagaman teman merupakan pengamalan Pancasila sila ke-...', 
            '[{"id":"a","text":"1"},{"id":"b","text":"3"},{"id":"c","text":"5"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Sila ke-3 (Persatuan Indonesia) menjunjung persatuan dalam keberagaman.', 1, 10, false, 6),
        (t_ragam, 'regular', 'multiple_choice', 'Lani memakai kacamata, sedangkan Siti tidak. Sikap Siti kepada Lani adalah...', 
            '[{"id":"a","text":"Mengejek Lani"},{"id":"b","text":"Bermain bersama dengan senang"},{"id":"c","text":"Menjauhi Lani"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Perbedaan fisik kacamata tidak membatasi pertemanan.', 1, 10, false, 7),
        (t_ragam, 'regular', 'multiple_choice', 'Suku bangsa di Indonesia sangat banyak. Sikap yang benar adalah...', 
            '[{"id":"a","text":"Hanya berteman dengan suku yang sama"},{"id":"b","text":"Bangga dengan keberagaman suku Indonesia"},{"id":"c","text":"Menganggap suku lain jelek"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bangga atas keberagaman adalah perwujudan cinta tanah air.', 1, 10, false, 8),
        (t_ragam, 'regular', 'multiple_choice', 'Makanan khas daerah yang beraneka ragam harus kita...', 
            '[{"id":"a","text":"Buang"},{"id":"b","text":"Syukuri dan lestarikan"},{"id":"c","text":"Takuti"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kekayaan kuliner daerah wajib disyukuri.', 1, 10, false, 9),
        (t_ragam, 'regular', 'multiple_choice', 'Membantu teman yang jatuh tanpa melihat asal daerahnya adalah wujud nilai...', 
            '[{"id":"a","text":"Kemanusiaan"},{"id":"b","text":"Kekerasan"},{"id":"c","text":"Kemalasan"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Saling tolong menolong wujud rasa kemanusiaan.', 1, 10, false, 10),
        (t_ragam, 'regular', 'multiple_choice', 'Indonesia memiliki keberagaman karena daerahnya berbentuk...', 
            '[{"id":"a","text":"Kepulauan"},{"id":"b","text":"Satu benua besar"},{"id":"c","text":"Gurun pasir"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Negara kepulauan melahirkan banyak keragaman adat dan budaya.', 1, 10, false, 11),
        (t_ragam, 'regular', 'multiple_choice', 'Contoh sikap rukun di kelas adalah...', 
            '[{"id":"a","text":"Berbagi makanan saat istirahat"},{"id":"b","text":"Menyontek saat ujian"},{"id":"c","text":"Berebut mainan"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Berbagi makanan mempererat tali pertemanan yang rukun.', 1, 10, false, 12),
        (t_ragam, 'regular', 'multiple_choice', 'Manakah benda yang merupakan pakaian adat daerah?', 
            '[{"id":"a","text":"Kebaya dan Beskap"},{"id":"b","text":"Kaos oblong"},{"id":"c","text":"Jas hujan"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Kebaya dan beskap adalah contoh pakaian adat Jawa.', 1, 10, false, 13),
        (t_ragam, 'olympiad', 'multiple_choice', 'Bhinneka Tunggal Ika tertulis pada pita burung Garuda. Arti kalimat tersebut adalah...', 
            '[{"id":"a","text":"Bersatu kita teguh bercerai kita runtuh"},{"id":"b","text":"Berbeda-beda tetapi tetap satu jua"},{"id":"c","text":"Maju tak gentar membela yang benar"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Artinya berbeda suku, agama, ras tetapi tetap bersatu sebagai bangsa Indonesia.', 2, 25, false, 14),
        (t_ragam, 'olympiad', 'multiple_choice', 'Di kelas ada anak pindahan baru dari daerah lain yang logat bicaranya lucu. Sikap kita yang paling sopan adalah...', 
            '[{"id":"a","text":"Menertawakan dan menirukannya untuk bercanda"},{"id":"b","text":"Menyambutnya dengan ramah dan menemaninya belajar"},{"id":"c","text":"Mengabaikan anak tersebut"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Menyambut anak baru dengan ramah melambangkan sikap toleran dan bersahabat.', 2, 25, false, 15);
    END IF;

    -- ==============================================================================
    -- PENDIDIKAN PANCASILA — MENGENAL LINGKUNGAN RUMAH (15 Questions)
    -- ==============================================================================
    IF t_rumah IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_rumah, 'regular', 'multiple_choice', 'Tempat berlindung dari panas matahari dan hujan dinamakan...', 
            '[{"id":"a","text":"Sekolah"},{"id":"b","text":"Rumah"},{"id":"c","text":"Kantor"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Rumah berfungsi sebagai tempat tinggal dan berlindung.', 1, 10, false, 1),
        (t_rumah, 'regular', 'multiple_choice', 'Ruangan di dalam rumah yang digunakan untuk beristirahat dan tidur adalah...', 
            '[{"id":"a","text":"Kamar tidur"},{"id":"b","text":"Dapur"},{"id":"c","text":"Kamar mandi"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Kamar tidur untuk melepas lelah.', 1, 10, false, 2),
        (t_rumah, 'regular', 'multiple_choice', 'Ibu sedang menggoreng tempe dan membuat sayur sup. Ibu melakukan aktivitas ini di...', 
            '[{"id":"a","text":"Dapur"},{"id":"b","text":"Ruang tamu"},{"id":"c","text":"Garasi"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Memasak dilakukan di dapur.', 1, 10, false, 3),
        (t_rumah, 'regular', 'multiple_choice', 'Bagian luar rumah yang biasa ditanami bunga dan tanaman obat disebut...', 
            '[{"id":"a","text":"Kamar mandi"},{"id":"b","text":"Halaman / pekarangan rumah"},{"id":"c","text":"Dapur"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Halaman rumah untuk pekarangan hijau.', 1, 10, false, 4),
        (t_rumah, 'regular', 'multiple_choice', 'Bagian paling atas rumah yang berfungsi menahan air hujan masuk disebut...', 
            '[{"id":"a","text":"Dinding"},{"id":"b","text":"Atap"},{"id":"c","text":"Pintu"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Atap melindung ruangan bagian dalam.', 1, 10, false, 5),
        (t_rumah, 'regular', 'multiple_choice', 'Kita membersihkan badan dari debu dengan cara mandi di...', 
            '[{"id":"a","text":"Kamar mandi"},{"id":"b","text":"Ruang keluarga"},{"id":"c","text":"Kamar tidur"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Mandi dilakukan di kamar mandi.', 1, 10, false, 6),
        (t_rumah, 'regular', 'multiple_choice', 'Membersihkan rumah bersama-sama dengan ayah, ibu, dan adik disebut...', 
            '[{"id":"a","text":"Kerja bakti keluarga"},{"id":"b","text":"Tugas sekolah"},{"id":"c","text":"Bermain bersama"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Kerja bakti keluarga meringankan pekerjaan membersihkan rumah.', 1, 10, false, 7),
        (t_rumah, 'regular', 'multiple_choice', 'Bagaimanakah ciri-ciri rumah yang sehat?', 
            '[{"id":"a","text":"Banyak sampah menumpuk"},{"id":"b","text":"Bersih, rapi, dan mendapat cukup sinar matahari"},{"id":"c","text":"Jendelanya selalu ditutup rapat"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bersih dan cukup sinar matahari mencegah lembab dan kuman.', 1, 10, false, 8),
        (t_rumah, 'regular', 'multiple_choice', 'Udara kotor di dalam rumah bisa ditukar udara bersih luar melalui...', 
            '[{"id":"a","text":"Jendela atau ventilasi udara"},{"id":"b","text":"Atap genteng yang bocor"},{"id":"c","text":"Lubang tikus"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Jendela dan ventilasi menjaga kelancaran sirkulasi udara.', 1, 10, false, 9),
        (t_rumah, 'regular', 'multiple_choice', 'Siapakah yang paling bertanggung jawab membersihkan lingkungan rumah?', 
            '[{"id":"a","text":"Hanya ibu"},{"id":"b","text":"Seluruh anggota keluarga yang tinggal"},{"id":"c","text":"Petugas kebersihan kompleks"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kebersihan rumah adalah tugas semua penghuninya.', 1, 10, false, 10),
        (t_rumah, 'regular', 'multiple_choice', 'Menanam banyak pohon hijau di sekitar rumah akan membuat udara menjadi...', 
            '[{"id":"a","text":"Panas"},{"id":"b","text":"Segar dan sejuk"},{"id":"c","text":"Berdebu"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Tumbuhan menghasilkan oksigen yang menyejukkan udara.', 1, 10, false, 11),
        (t_rumah, 'regular', 'multiple_choice', 'Tindakan yang benar sebelum memasuki rumah orang lain adalah...', 
            '[{"id":"a","text":"Langsung membuka pintu dan masuk"},{"id":"b","text":"Mengetuk pintu dan mengucapkan salam"},{"id":"c","text":"Mengintip dari jendela"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Mengetuk pintu dan mengucap salam adalah tata krama bertamu.', 1, 10, false, 12),
        (t_rumah, 'regular', 'multiple_choice', 'Benda di rumah untuk membuang air kotor cucian dapur adalah...', 
            '[{"id":"a","text":"Wastafel / Bak cuci piring"},{"id":"b","text":"Kulkas"},{"id":"c","text":"Kompor"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Wastafel menyalurkan air bekas cucian ke saluran pembuangan.', 1, 10, false, 13),
        (t_rumah, 'olympiad', 'multiple_choice', 'Mengapa jendela kamar tidur sebaiknya dibuka pada pagi hari?', 
            '[{"id":"a","text":"Supaya nyamuk bisa masuk"},{"id":"b","text":"Agar udara segar masuk dan terjadi pertukaran udara"},{"id":"c","text":"Supaya tetangga bisa melihat kamar kita"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Udara pagi hari sangat bersih dan baik untuk menggantikan udara pengap semalam.', 2, 25, false, 14),
        (t_rumah, 'olympiad', 'multiple_choice', 'Got di depan rumah Budi penuh dengan sampah plastik. Masalah buruk apa yang bisa timbul?', 
            '[{"id":"a","text":"Air mengalir sangat deras"},{"id":"b","text":"Got tersumbat menyebabkan banjir saat hujan dan sarang nyamuk"},{"id":"c","text":"Got menjadi bersih"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Plastik tidak hancur dan menyumbat saluran air, memicu banjir dan nyamuk berkembang biak.', 2, 25, false, 15);
    END IF;

    -- ==============================================================================
    -- BAHASA INDONESIA — MENYIMAK CERITA SEDERHANA (15 Questions)
    -- ==============================================================================
    IF t_simak IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_simak, 'regular', 'multiple_choice', 'Sikap tubuh saat menyimak guru membacakan cerita dongeng adalah...', 
            '[{"id":"a","text":"Tidur terlentang"},{"id":"b","text":"Duduk dengan tenang dan mendengarkan"},{"id":"c","text":"Berlari-lari di kelas"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Menyimak butuh konsentrasi dengan duduk tenang.', 1, 10, false, 1),
        (t_simak, 'regular', 'multiple_choice', 'Dongeng fabel adalah cerita dongeng yang tokoh utamanya berupa...', 
            '[{"id":"a","text":"Manusia"},{"id":"b","text":"Hewan yang bisa berbicara"},{"id":"c","text":"Tumbuhan kantong semar"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Fabel menceritakan kehidupan binatang yang bertingkah seperti manusia.', 1, 10, false, 2),
        (t_simak, 'regular', 'multiple_choice', 'Dari cerita "Kancil dan Buaya", sifat Kancil dikenal sangat...', 
            '[{"id":"a","text":"Pemalas"},{"id":"b","text":"Cerdik / pintar"},{"id":"c","text":"Sombong"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kancil menggunakan kecerdikannya untuk menyeberangi sungai.', 1, 10, false, 3),
        (t_simak, 'regular', 'multiple_choice', 'Mengapa buaya marah kepada kancil di akhir cerita?', 
            '[{"id":"a","text":"Karena kancil memberi buah"},{"id":"b","text":"Karena kancil membohongi mereka untuk menyeberang"},{"id":"c","text":"Karena kancil mencuri buah mentimun"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kancil membohongi buaya untuk berbaris sebagai jembatan penyeberangan.', 1, 10, false, 4),
        (t_simak, 'regular', 'multiple_choice', 'Dalam dongeng "Semut dan Belalang", Semut rajin mengumpulkan makanan untuk menghadapi musim...', 
            '[{"id":"a","text":"Kemarau"},{"id":"b","text":"Hujan / Dingin"},{"id":"c","text":"Gugur"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Semut mengumpulkan bekal makanan agar tidak kelaparan saat musim dingin tiba.', 1, 10, false, 5),
        (t_simak, 'regular', 'multiple_choice', 'Tokoh utama yang malas menabung makanan dalam cerita tersebut adalah...', 
            '[{"id":"a","text":"Kupu-kupu"},{"id":"b","text":"Belalang"},{"id":"c","text":"Semut hitam"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Belalang malas bekerja dan hanya bernyanyi seharian.', 1, 10, false, 6),
        (t_simak, 'regular', 'multiple_choice', 'Pesan kebaikan yang didapat dari dongeng Semut dan Belalang adalah...', 
            '[{"id":"a","text":"Kita harus rajin bekerja untuk masa depan"},{"id":"b","text":"Sebaiknya bermalas-malasan saja"},{"id":"c","text":"Boleh mencuri makanan teman"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Kerja keras di awal membuahkan keselamatan kelak.', 1, 10, false, 7),
        (t_simak, 'regular', 'multiple_choice', 'Cerita dongeng Malin Kundang mengajari kita agar tidak durhaka kepada...', 
            '[{"id":"a","text":"Guru"},{"id":"b","text":"Ibu / Orang tua"},{"id":"c","text":"Teman sepermainan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Malin Kundang dikutuk batu karena membangkang ibunya.', 1, 10, false, 8),
        (t_simak, 'regular', 'multiple_choice', 'Malin Kundang dikutuk ibunya berubah menjadi...', 
            '[{"id":"a","text":"Emas murni"},{"id":"b","text":"Batu"},{"id":"c","text":"Pohon kelapa"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Berubah menjadi batu di pantai.', 1, 10, false, 9),
        (t_simak, 'regular', 'multiple_choice', 'Siapakah yang membacakan cerita di sekolah pada umumnya?', 
            '[{"id":"a","text":"Dokter"},{"id":"b","text":"Guru"},{"id":"c","text":"Satpam"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Guru membimbing kegiatan membaca cerita di kelas.', 1, 10, false, 10),
        (t_simak, 'regular', 'multiple_choice', 'Untuk mengetahui isi cerita dengan baik, indra yang paling fokus bekerja adalah...', 
            '[{"id":"a","text":"Hidung"},{"id":"b","text":"Telinga (mendengar) dan mata (melihat)"},{"id":"c","text":"Mulut"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Telinga mendengar narasi cerita, mata mengamati ilustrasi.', 1, 10, false, 11),
        (t_simak, 'regular', 'multiple_choice', 'Bagian cerita yang menunjukkan waktu dan lokasi tempat terjadinya kisah disebut...', 
            '[{"id":"a","text":"Tokoh"},{"id":"b","text":"Latar cerita"},{"id":"c","text":"Judul cerita"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Latar menjelaskan tempat dan waktu kejadian dongeng.', 1, 10, false, 12),
        (t_simak, 'regular', 'multiple_choice', 'Nama atau kepala karangan cerita diletakkan di paling atas disebut...', 
            '[{"id":"a","text":"Penulis"},{"id":"b","text":"Judul"},{"id":"c","text":"Daftar isi"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Judul memberikan gambaran umum isi cerita.', 1, 10, false, 13),
        (t_simak, 'olympiad', 'multiple_choice', 'Dalam cerita "Kura-kura dan Kelinci", mengapa kelinci yang berlari sangat cepat bisa kalah balapan?', 
            '[{"id":"a","text":"Kelinci tersesat jalan"},{"id":"b","text":"Kelinci sombong dan tidur siang di tengah jalan"},{"id":"c","text":"Kura-kura mengendarai sepeda"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kelinci meremehkan kura-kura, tidur siang, dan akhirnya dilewati kura-kura yang konsisten.', 2, 25, false, 14),
        (t_simak, 'olympiad', 'multiple_choice', 'Apa pesan moral dari kisah Kura-kura dan Kelinci?', 
            '[{"id":"a","text":"Jangan sombong dan harus tekun pantang menyerah"},{"id":"b","text":"Berlari cepat itu tidak berguna"},{"id":"c","text":"Lebih baik tidur daripada berjalan lambat"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Ketekunan mengalahkan kesombongan yang lalai.', 2, 25, false, 15);
    END IF;

    -- ==============================================================================
    -- BAHASA INDONESIA — MEMBACA SUKU KATA (15 Questions)
    -- ==============================================================================
    IF t_baca IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_baca, 'regular', 'multiple_choice', 'Huruf vokal dalam alfabet terdiri dari...', 
            '[{"id":"a","text":"b, c, d, f"},{"id":"b","text":"a, e, i, o, u"},{"id":"c","text":"x, y, z"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Huruf vokal adalah huruf hidup: a, e, i, o, u.', 1, 10, false, 3),
        (t_baca, 'regular', 'multiple_choice', 'Ada berapa huruf konsonan pada kata "BOLA"?', 
            '[{"id":"a","text":"2 huruf (B dan L)"},{"id":"b","text":"2 huruf (O dan A)"},{"id":"c","text":"4 huruf"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'B dan L adalah konsonan, O dan A adalah vokal.', 1, 10, false, 4),
        (t_baca, 'regular', 'multiple_choice', 'Ejaan suku kata yang benar untuk kata "LEMARI" adalah...', 
            '[{"id":"a","text":"lem-ar-i"},{"id":"b","text":"le-ma-ri"},{"id":"c","text":"lema-ri"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Ejaan suku katanya adalah le-ma-ri.', 1, 10, false, 5),
        (t_baca, 'regular', 'multiple_choice', 'Suku kata "bu" jika digabungkan dengan "mi" membentuk kata...', 
            '[{"id":"a","text":"Buku"},{"id":"b","text":"Bumi"},{"id":"c","text":"Bulan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'bu-mi dibaca bumi.', 1, 10, false, 6),
        (t_baca, 'regular', 'multiple_choice', 'Kata di bawah ini yang memiliki 3 suku kata adalah...', 
            '[{"id":"a","text":"Meja"},{"id":"b","text":"Sepatu (se - pa - tu)"},{"id":"c","text":"Tas"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'se-pa-tu terdiri atas 3 ketukan suku kata.', 1, 10, false, 7),
        (t_baca, 'regular', 'multiple_choice', 'Kata "TOPI" diawali dengan suku kata...', 
            '[{"id":"a","text":"ta"},{"id":"b","text":"to"},{"id":"c","text":"ti"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kata topi diawali oleh suku kata "to".', 1, 10, false, 8),
        (t_baca, 'regular', 'multiple_choice', 'Suku kata pertama dari kata "PENSIL" adalah...', 
            '[{"id":"a","text":"pe"},{"id":"b","text":"pen"},{"id":"c","text":"sil"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'pen-sil dieja dari suku kata "pen" dan "sil".', 1, 10, false, 9),
        (t_baca, 'regular', 'multiple_choice', 'Huruf kapital dari huruf "d" ditulis...', 
            '[{"id":"a","text":"B"},{"id":"b","text":"D"},{"id":"c","text":"P"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'D adalah huruf besar (kapital) dari d.', 1, 10, false, 10),
        (t_baca, 'regular', 'multiple_choice', 'Kata yang berakhiran suku kata "ji" di bawah ini adalah...', 
            '[{"id":"a","text":"Padi"},{"id":"b","text":"Baji"},{"id":"c","text":"Baju"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'ba-ji berakhiran suku kata "ji".', 1, 10, false, 11),
        (t_baca, 'regular', 'multiple_choice', 'Manakah kata yang berima (bunyi mirip) dengan kata "TOPI"?', 
            '[{"id":"a","text":"Kopi"},{"id":"b","text":"Tas"},{"id":"c","text":"Buku"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Topi dan kopi memiliki vokal akhir akhiran yang mirip (-pi).', 1, 10, false, 12),
        (t_baca, 'regular', 'multiple_choice', 'Gabungan suku kata "ce - ri - ta" dibaca...', 
            '[{"id":"a","text":"Cermin"},{"id":"b","text":"Cerita"},{"id":"c","text":"Ceria"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Dibaca cerita.', 1, 10, false, 13),
        (t_baca, 'regular', 'multiple_choice', 'Kata "MATAHARI" terdiri dari berapa suku kata?', 
            '[{"id":"a","text":"3 suku kata"},{"id":"b","text":"4 suku kata (ma - ta - ha - ri)"},{"id":"c","text":"5 suku kata"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'ma-ta-ha-ri memiliki 4 suku kata.', 1, 10, false, 14),
        (t_baca, 'olympiad', 'multiple_choice', 'Berapakah jumlah huruf vokal pada kalimat "SAYA BELAJAR"?', 
            '[{"id":"a","text":"4 vokal"},{"id":"b","text":"5 vokal (a, a, e, a, a)"},{"id":"c","text":"6 vokal"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Vokalnya adalah S[A]y[A] b[E]l[A]j[A]r = total 5 huruf vokal.', 2, 25, false, 15),
        (t_baca, 'olympiad', 'multiple_choice', 'Kata manakah yang memiliki susunan huruf konsonan-vokal-konsonan-vokal (K-V-K-V)?', 
            '[{"id":"a","text":"APEL"},{"id":"b","text":"BUKU"},{"id":"c","text":"EMAS"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'B(K)-u(V)-k(K)-u(V) adalah pola K-V-K-V.', 2, 25, false, 16);
    END IF;

    -- ==============================================================================
    -- BAHASA INDONESIA — MENCERITAKAN PENGALAMAN (15 Questions)
    -- ==============================================================================
    IF t_cerita IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_cerita, 'regular', 'multiple_choice', 'Pengalaman adalah hal atau peristiwa yang pernah kita...', 
            '[{"id":"a","text":"Impikan"},{"id":"b","text":"Alami / Rasakan"},{"id":"c","text":"Lupakan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Peristiwa yang benar-benar terjadi pada kita disebut pengalaman.', 1, 10, false, 1),
        (t_cerita, 'regular', 'multiple_choice', 'Mendapat hadiah ulang tahun dari orang tua adalah contoh pengalaman yang...', 
            '[{"id":"a","text":"Menyedihkan"},{"id":"b","text":"Menyenangkan"},{"id":"c","text":"Menakutkan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Ulang tahun dan hadiah mendatangkan kegembiraan.', 1, 10, false, 2),
        (t_cerita, 'regular', 'multiple_choice', 'Terjatuh dari sepeda hingga lutut terluka adalah contoh pengalaman yang...', 
            '[{"id":"a","text":"Menyenangkan"},{"id":"b","text":"Sedih / menyakitkan"},{"id":"c","text":"Lucu"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Terluka membuat anak sedih dan menahan sakit.', 1, 10, false, 3),
        (t_cerita, 'regular', 'multiple_choice', 'Saat menceritakan pengalaman menyenangkan di depan kelas, ekspresi wajah kita sebaiknya...', 
            '[{"id":"a","text":"Menangis sedih"},{"id":"b","text":"Tersenyum ceria"},{"id":"c","text":"Cemberut marah"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Tersenyum ceria mengekspresikan rasa senang.', 1, 10, false, 4),
        (t_cerita, 'regular', 'multiple_choice', 'Budi menceritakan pengalamannya pergi ke kebun binatang. Hewan apa yang biasanya dilihat di sana?', 
            '[{"id":"a","text":"Dinosaurus"},{"id":"b","text":"Gajah dan Jerapah"},{"id":"c","text":"Ikan hiu laut dalam"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Gajah dan jerapah adalah satwa umum di kebun binatang darat.', 1, 10, false, 5),
        (t_cerita, 'regular', 'multiple_choice', 'Sebelum berbicara bercerita di depan banyak orang kelas, kita sebaiknya mengucapkan...', 
            '[{"id":"a","text":"Terima kasih"},{"id":"b","text":"Salam pembuka"},{"id":"c","text":"Selamat tinggal"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Salam pembuka menyapa guru dan teman-teman kelas.', 1, 10, false, 6),
        (t_cerita, 'regular', 'multiple_choice', 'Sikap pendengar yang baik saat teman kita menceritakan pengalamannya adalah...', 
            '[{"id":"a","text":"Mengajaknya mengobrol"},{"id":"b","text":"Mendengarkan dengan tertib"},{"id":"c","text":"Meninggalkan ruangan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Menghargai teman bicara dengan tertib menyimak.', 1, 10, false, 7),
        (t_cerita, 'regular', 'multiple_choice', 'Pengalaman berlibur bersama keluarga biasanya dilakukan pada saat...', 
            '[{"id":"a","text":"Hari masuk ujian sekolah"},{"id":"b","text":"Hari libur sekolah"},{"id":"c","text":"Hari piket malam"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Liburan dilakukan saat jeda sekolah.', 1, 10, false, 8),
        (t_cerita, 'regular', 'multiple_choice', 'Ketika ditanya tentang kapan kejadian pengalaman berlangsung, kita menjawab tentang...', 
            '[{"id":"a","text":"Nama orang"},{"id":"b","text":"Waktu kejadian (misal: kemarin, minggu lalu)"},{"id":"c","text":"Nama kota"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kapan merujuk pada keterangan waktu.', 1, 10, false, 9),
        (t_cerita, 'regular', 'multiple_choice', 'Kata tanya yang digunakan untuk menanyakan lokasi terjadinya pengalaman adalah...', 
            '[{"id":"a","text":"Siapa"},{"id":"b","text":"Di mana"},{"id":"c","text":"Mengapa"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Di mana merujuk pada nama tempat/lokasi.', 1, 10, false, 10),
        (t_cerita, 'regular', 'multiple_choice', 'Pengalaman belajar memasak kue dilakukan bersama...', 
            '[{"id":"a","text":"Pak Satpam"},{"id":"b","text":"Ibu di dapur"},{"id":"c","text":"Teman bermain bola"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Ibu biasanya membimbing anak membuat kue di dapur.', 1, 10, false, 11),
        (t_cerita, 'regular', 'multiple_choice', 'Kata tanya untuk mengetahui tokoh atau orang terlibat dalam pengalaman adalah...', 
            '[{"id":"a","text":"Kapan"},{"id":"b","text":"Siapa"},{"id":"c","text":"Berapa"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Siapa menanyakan subjek pelaku/orang.', 1, 10, false, 12),
        (t_cerita, 'regular', 'multiple_choice', 'Tujuan menceritakan pengalaman di depan kelas adalah untuk...', 
            '[{"id":"a","text":"Pamer kekayaan"},{"id":"b","text":"Saling berbagi cerita dan melatih keberanian bicara"},{"id":"c","text":"Membuat teman iri"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bercerita melatih rasa percaya diri anak di depan umum.', 1, 10, false, 13),
        (t_cerita, 'olympiad', 'multiple_choice', 'Doni menuliskan catatan kejadian penting harian dalam buku catatan pribadinya. Buku itu biasa disebut...', 
            '[{"id":"a","text":"Buku paket pelajaran"},{"id":"b","text":"Buku harian (diary)"},{"id":"c","text":"Kamus besar bahasa"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Buku harian mencatat pengalaman pribadi sehari-hari.', 2, 25, false, 14),
        (t_cerita, 'olympiad', 'multiple_choice', 'Manakah kalimat pembuka yang paling tepat untuk mengawali cerita liburan?', 
            '[{"id":"a","text":"Demikian cerita saya, terima kasih."},{"id":"b","text":"Teman-teman, hari ini saya ingin menceritakan pengalaman liburan saya minggu lalu."},{"id":"c","text":"Aduh, saya lupa mau cerita apa."}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Merupakan kalimat sapaan dan penyampaian topik cerita yang santun.', 2, 25, false, 15);
    END IF;

    -- ==============================================================================
    -- BAHASA INDONESIA — MENULIS HURUF DAN KATA (15 Questions)
    -- ==============================================================================
    IF t_tulis IS NOT NULL THEN
        INSERT INTO public.questions (topic_id, question_type, content_type, question_text, options, correct_answer, explanation, difficulty, xp_reward, needs_curriculum_validation, order_index) VALUES
        (t_tulis, 'regular', 'multiple_choice', 'Menulis diawali dari arah sebelah...', 
            '[{"id":"a","text":"Kanan ke kiri"},{"id":"b","text":"Kiri ke kanan"},{"id":"c","text":"Bawah ke atas"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Bahasa Indonesia ditulis dari kiri ke kanan.', 1, 10, false, 1),
        (t_tulis, 'regular', 'multiple_choice', 'Huruf pertama untuk menulis kata "KUCING" adalah huruf...', 
            '[{"id":"a","text":"c"},{"id":"b","text":"k"},{"id":"c","text":"g"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'K-u-c-i-n-g diawali dengan huruf K.', 1, 10, false, 2),
        (t_tulis, 'regular', 'multiple_choice', 'Huruf kapital digunakan untuk menulis huruf awal pada...', 
            '[{"id":"a","text":"Nama orang dan awal kalimat"},{"id":"b","text":"Nama buah di tengah kalimat"},{"id":"c","text":"Semua huruf kata"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Kapital dipakai untuk huruf pertama awal kalimat dan nama diri.', 1, 10, false, 3),
        (t_tulis, 'regular', 'multiple_choice', 'Penulisan nama orang di bawah ini yang benar adalah...', 
            '[{"id":"a","text":"budi"},{"id":"b","text":"Budi"},{"id":"c","text":"BuDi"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Huruf B pada Budi harus kapital karena nama orang.', 1, 10, false, 4),
        (t_tulis, 'regular', 'multiple_choice', 'Bila menulis kata, antar-kata harus diberi jarak berupa...', 
            '[{"id":"a","text":"Garis bawah"},{"id":"b","text":"Spasi / Jeda kosong"},{"id":"c","text":"Tanda koma"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Spasi memisahkan kata agar mudah dibaca.', 1, 10, false, 5),
        (t_tulis, 'regular', 'multiple_choice', 'Tanda baca yang diletakkan di akhir kalimat berita/pernyataan adalah...', 
            '[{"id":"a","text":"Tanda tanya (?)"},{"id":"b","text":"Tanda titik (.)"},{"id":"c","text":"Tanda seru (!)"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Titik menandakan kalimat telah selesai/berakhir.', 1, 10, false, 6),
        (t_tulis, 'regular', 'multiple_choice', 'Tanda tanya (?) digunakan untuk mengakhiri kalimat...', 
            '[{"id":"a","text":"Perintah"},{"id":"b","text":"Pertanyaan"},{"id":"c","text":"Seruan"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Kalimat tanya membutuhkan tanda tanya di akhir.', 1, 10, false, 7),
        (t_tulis, 'regular', 'multiple_choice', 'Lengkapi kata rumpang berikut agar membentuk kata alat tulis: "P _ N S I L"', 
            '[{"id":"a","text":"a"},{"id":"b","text":"e"},{"id":"c","text":"o"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Huruf rumpang adalah "e" membentuk kata PENSIL.', 1, 10, false, 8),
        (t_tulis, 'regular', 'multiple_choice', 'Susunan huruf yang benar untuk membentuk kata "BUKU" adalah...', 
            '[{"id":"a","text":"u - b - k - u"},{"id":"b","text":"b - u - k - u"},{"id":"c","text":"k - u - b - u"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'B-U-K-U dieja buku.', 1, 10, false, 9),
        (t_tulis, 'regular', 'multiple_choice', 'Sikap duduk yang benar saat menulis di meja belajar adalah...', 
            '[{"id":"a","text":"Membungkuk sangat dekat dengan kertas"},{"id":"b","text":"Duduk tegak dengan jarak mata yang aman"},{"id":"c","text":"Tidur telungkup"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Duduk tegak menjaga kesehatan tulang belakang dan mata.', 1, 10, false, 10),
        (t_tulis, 'regular', 'multiple_choice', 'Alat yang digunakan untuk menulis di buku tulis sekolah adalah...', 
            '[{"id":"a","text":"Kuas cat"},{"id":"b","text":"Pensil atau pulpen"},{"id":"c","text":"Kapur tulis"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Pensil/pulpen digunakan untuk buku kertas.', 1, 10, false, 11),
        (t_tulis, 'regular', 'multiple_choice', 'Untuk menghapus tulisan pensil yang salah di kertas, kita memakai...', 
            '[{"id":"a","text":"Rautan"},{"id":"b","text":"Penghapus karet"},{"id":"c","text":"Penggaris"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Penghapus karet membersihkan goresan grafit pensil.', 1, 10, false, 12),
        (t_tulis, 'regular', 'multiple_choice', 'Huruf konsonan terakhir pada kata "SEKOLAH" adalah...', 
            '[{"id":"a","text":"a"},{"id":"b","text":"h"},{"id":"c","text":"s"}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Huruf h terletak di ujung kata dan merupakan huruf konsonan.', 1, 10, false, 13),
        (t_tulis, 'olympiad', 'multiple_choice', 'Manakah kalimat di bawah ini yang penulisan huruf kapitalnya tepat?', 
            '[{"id":"a","text":"dika pergi ke kebun binatang bersama Ayah."},{"id":"b","text":"Dika pergi ke kebun binatang bersama ayah."},{"id":"c","text":"Dika Pergi Ke Kebun Binatang Bersama Ayah."}]'::jsonb, 
            '{"option_id":"b"}'::jsonb, 'Dika diawali kapital karena nama orang dan awal kalimat. Kata lainnya ditulis huruf kecil.', 2, 25, false, 14),
        (t_tulis, 'olympiad', 'multiple_choice', 'Susun huruf acak berikut menjadi kata nama hari: "S - A - E - L - A"', 
            '[{"id":"a","text":"Selasa"},{"id":"b","text":"Kamis"},{"id":"c","text":"Senin"}]'::jsonb, 
            '{"option_id":"a"}'::jsonb, 'Huruf S-a-e-l-a jika disusun membentuk kata Selasa.', 2, 25, false, 15);
    END IF;
END $$;
