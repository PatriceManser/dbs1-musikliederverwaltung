-- Autoren: Rusch, Stadler, Manser

INSERT INTO artist (name, country) VALUES
    ('Queen', 'GB'),
    ('David Bowie', 'GB'),
    ('Daft Punk', 'FR'),
    ('Pharrell Williams', 'US'),
    ('Nile Rodgers', 'US'),
    ('Taylor Swift', 'US'),
    ('Ed Sheeran', 'GB'),
    ('Gotthard', 'CH'),
    ('Patent Ochsner', 'CH'),
    ('Joe Rogan', 'US'),
    ('Lex Fridman', 'US'),
    ('Jan Böhmermann', 'DE'),
    ('Olli Schulz', 'DE'),
    ('Bastian Baker', NULL);

INSERT INTO audio (title, duration, audio_url) VALUES
    ('Bohemian Rhapsody', '00:05:55', 'https://audio.example.com/1.mp3'),
    ('Don''t Stop Me Now', '00:03:29', 'https://audio.example.com/2.mp3'),
    ('Under Pressure', '00:04:08', 'https://audio.example.com/3.mp3'),
    ('Heroes', '00:06:07', 'https://audio.example.com/4.mp3'),
    ('Space Oddity', '00:05:15', 'https://audio.example.com/5.mp3'),
    ('Get Lucky', '00:06:09', 'https://audio.example.com/6.mp3'),
    ('Lose Yourself to Dance', '00:05:53', 'https://audio.example.com/7.mp3'),
    ('One More Time', '00:05:20', 'https://audio.example.com/8.mp3'),
    ('Happy', '00:03:53', 'https://audio.example.com/9.mp3'),
    ('Shake It Off', '00:03:39', 'https://audio.example.com/10.mp3'),
    ('Blank Space', '00:03:51', 'https://audio.example.com/11.mp3'),
    ('Everything Has Changed', '00:04:05', 'https://audio.example.com/12.mp3'),
    ('Shape of You', '00:03:53', 'https://audio.example.com/13.mp3'),
    ('Perfect', '00:04:23', 'https://audio.example.com/14.mp3'),
    ('Heaven', '00:04:56', 'https://audio.example.com/15.mp3'),
    ('Hush', '00:03:32', 'https://audio.example.com/16.mp3'),
    ('Bälpmoos', '00:04:19', 'https://audio.example.com/17.mp3'),
    ('Scharlachrot', '00:05:03', 'https://audio.example.com/18.mp3'),
    ('Thinking Out Loud', '00:04:41', 'https://audio.example.com/19.mp3'),
    ('We Will Rock You', '00:02:02', 'https://audio.example.com/20.mp3'),
    ('JRE - Elon Musk', '02:37:00', 'https://audio.example.com/21.mp3'),
    ('JRE - Naval Ravikant', '01:56:00', 'https://audio.example.com/22.mp3'),
    ('JRE - Lex Fridman', '02:51:00', 'https://audio.example.com/23.mp3'),
    ('JRE - Andrew Huberman', '02:45:00', 'https://audio.example.com/24.mp3'),
    ('Lex Fridman Podcast - John Carmack', '05:15:00', 'https://audio.example.com/25.mp3'),
    ('Lex Fridman Podcast - Sam Altman', '02:23:00', 'https://audio.example.com/26.mp3'),
    ('Lex Fridman Podcast - Max Tegmark', '01:22:00', 'https://audio.example.com/27.mp3'),
    ('Fest & Flauschig - Folge 1', '01:05:00', 'https://audio.example.com/28.mp3'),
    ('Fest & Flauschig - Folge 2', '01:12:00', 'https://audio.example.com/29.mp3'),
    ('Fest & Flauschig - Folge 3', '00:58:00', 'https://audio.example.com/30.mp3');

INSERT INTO song (audio, genre) VALUES
    (1, 'Rock'),
    (2, 'Rock'),
    (3, 'Rock'),
    (4, 'Rock'),
    (5, 'Rock'),
    (6, 'Disco'),
    (7, 'Disco'),
    (8, 'House'),
    (9, 'Pop'),
    (10, 'Pop'),
    (11, 'Pop'),
    (12, 'Pop'),
    (13, 'Pop'),
    (14, 'Pop'),
    (15, 'Hard Rock'),
    (16, 'Hard Rock'),
    (17, 'Mundart'),
    (18, 'Mundart'),
    (19, NULL),
    (20, 'Rock');

INSERT INTO podcast (audio, description) VALUES
    (21, 'Gespräch über Tesla, SpaceX und künstliche Intelligenz.'),
    (22, 'Gespräch über Reichtum, Glück und Philosophie.'),
    (23, 'Gespräch über Robotik und Kampfsport.'),
    (24, 'Gespräch über Schlaf, Fitness und Neurowissenschaft.'),
    (25, 'Gespräch über Programmierung, Spiele-Engines und AGI.'),
    (26, 'Gespräch über OpenAI und die Zukunft von KI.'),
    (27, 'Gespräch über Physik und das Leben mit KI.'),
    (28, 'Die erste Folge des Podcasts.'),
    (29, NULL),
    (30, 'Plaudereien über Musik und Alltag.');

INSERT INTO audio_artist (audio, artist) VALUES
    (1, 1), (2, 1), (3, 1), (3, 2), (4, 2), (5, 2),
    (6, 3), (6, 4), (6, 5), (7, 3), (7, 4), (8, 3), (9, 4),
    (10, 6), (11, 6), (12, 6), (12, 7), (13, 7), (14, 7), (19, 7),
    (15, 8), (16, 8), (17, 9), (18, 9), (20, 1),
    (21, 10), (22, 10), (23, 10), (23, 11), (24, 10),
    (25, 11), (26, 11), (27, 11),
    (28, 12), (28, 13), (29, 12), (29, 13), (30, 12), (30, 13);

INSERT INTO album (title, release_date) VALUES
    ('A Night at the Opera', '1975-11-21'),
    ('Jazz', '1978-11-10'),
    ('News of the World', '1977-10-28'),
    ('Greatest Hits', '1981-10-26'),
    ('Heroes', '1977-10-14'),
    ('Space Oddity', '1969-11-14'),
    ('Random Access Memories', '2013-05-17'),
    ('Discovery', '2001-03-12'),
    ('1989', '2014-10-27'),
    ('Divide', '2017-03-03'),
    ('X', '2014-06-20'),
    ('G.', '1996-03-18'),
    ('Open', '1999-04-12'),
    ('Gmües', '1997-03-01'),
    ('Best of Swiss Rock', '2027-03-05');

INSERT INTO album_artist (album, artist) VALUES
    (1, 1), (2, 1), (3, 1), (4, 1),
    (5, 2), (6, 2),
    (7, 3), (8, 3),
    (9, 6),
    (10, 7), (11, 7),
    (12, 8), (13, 8),
    (14, 9),
    (15, 8), (15, 9);

INSERT INTO album_song (album, song) VALUES
    (1, 1), (2, 2), (3, 20),
    (4, 1), (4, 2), (4, 3), (4, 20),
    (5, 4), (6, 5),
    (7, 6), (7, 7), (8, 8),
    (9, 10), (9, 11),
    (10, 13), (10, 14), (11, 19),
    (12, 16), (13, 15),
    (14, 17), (14, 18),
    (15, 15), (15, 17);

INSERT INTO app_user (username, profile_picture_url) VALUES
    ('lisa_s', 'https://img.example.com/lisa_s.png'),
    ('tom_m', 'https://img.example.com/tom_m.png'),
    ('anna.k', NULL),
    ('jonas99', 'https://img.example.com/jonas99.png'),
    ('sara_music', 'https://img.example.com/sara.png'),
    ('lukas_b', NULL),
    ('nina_p', 'https://img.example.com/nina_p.png'),
    ('david_h', 'https://img.example.com/david_h.png'),
    ('julia_w', NULL),
    ('felix_z', 'https://img.example.com/felix_z.png'),
    ('mia_l', 'https://img.example.com/mia_l.png'),
    ('noah_g', NULL);

INSERT INTO playlist (title, app_user) VALUES
    ('Favoriten', 1),
    ('Workout', 1),
    ('Roadtrip', 2),
    ('Favoriten', 2),
    ('Chill', 3),
    ('Swiss Rock', 4),
    ('Party', 5),
    ('Klassiker', 6),
    ('Lernen', 7),
    ('Neue Playlist', 8),
    ('Sommer 2014', 9),
    ('Duette', 10),
    ('Morgenroutine', 11);

INSERT INTO playlist_song (playlist, song) VALUES
    (1, 1), (1, 6), (1, 13), (1, 17),
    (2, 2), (2, 6), (2, 9), (2, 20),
    (3, 1), (3, 2), (3, 10), (3, 15), (3, 16),
    (4, 11),
    (5, 7), (5, 8), (5, 14), (5, 19),
    (6, 15), (6, 16), (6, 17),
    (7, 2), (7, 6), (7, 9), (7, 10), (7, 13),
    (8, 1), (8, 3), (8, 4), (8, 20),
    (9, 7), (9, 8),
    (11, 9), (11, 10), (11, 11), (11, 19),
    (12, 3), (12, 12),
    (13, 9);
