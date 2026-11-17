-- Autoren: Manser, Rusch, Stadler

-- =====================================================================
-- Aufgabe 1: Einfache Queries
-- =====================================================================

-- 1a) Länder aller Artists, die ein Album veröffentlicht haben.
-- DISTINCT nötig: Der JOIN liefert eine Zeile pro Album, Länder würden
-- sonst mehrfach erscheinen (z.B. Queen mit 4 Alben, zwei CH-Artists).
SELECT DISTINCT ar.country
FROM artist ar
JOIN album_artist aa ON aa.artist = ar.id
ORDER BY ar.country;

-- 1b) Alle Songs pro Playlist mit Benutzername und Dauer (JOIN über 4 Tabellen).
SELECT u.username, p.title AS playlist, a.title AS song, a.duration
FROM app_user u
JOIN playlist p       ON p.app_user = u.id
JOIN playlist_song ps ON ps.playlist = p.id
JOIN audio a          ON a.id = ps.song
ORDER BY u.username, p.title, a.title;

-- 1c) Songs, die länger als der Durchschnitt aller Songs sind.
-- Unkorrelierte Subquery: wird nur einmal ausgewertet.
SELECT a.title, a.duration
FROM audio a
JOIN song s ON s.audio = a.id
WHERE a.duration > (
    SELECT AVG(a2.duration)
    FROM audio a2
    JOIN song s2 ON s2.audio = a2.id
)
ORDER BY a.duration DESC;

-- 1d) Songs, die in keiner Playlist enthalten sind (NOT EXISTS).
SELECT a.title, s.genre
FROM song s
JOIN audio a ON a.id = s.audio
WHERE NOT EXISTS (
    SELECT 1
    FROM playlist_song ps
    WHERE ps.song = s.audio
)
ORDER BY a.title;

-- 1e) Anzahl Playlists pro User. LEFT OUTER JOIN nötig, damit auch
-- User ohne Playlist (Anzahl 0) erscheinen.
SELECT u.username, COUNT(p.id) AS anzahl_playlists
FROM app_user u
LEFT OUTER JOIN playlist p ON p.app_user = u.id
GROUP BY u.id, u.username
ORDER BY anzahl_playlists DESC, u.username;

-- 1f) Alben, die in den 1970er-Jahren veröffentlicht wurden.
SELECT title, release_date
FROM album
WHERE release_date BETWEEN DATE '1970-01-01' AND DATE '1979-12-31'
ORDER BY release_date;

-- =====================================================================
-- Aufgabe 2: Common Table Expressions und Window-Funktionen
-- =====================================================================

-- 2a) Artists, deren Audios zusammen länger als 5 Stunden dauern.
-- Unkorrelierte Subquery im FROM berechnet Anzahl und Dauer pro Artist.
SELECT ar.name, t.anzahl_audios, t.gesamtdauer
FROM (
    SELECT aa.artist, COUNT(*) AS anzahl_audios, SUM(a.duration) AS gesamtdauer
    FROM audio_artist aa
    JOIN audio a ON a.id = aa.audio
    GROUP BY aa.artist
) t
JOIN artist ar ON ar.id = t.artist
WHERE t.gesamtdauer > INTERVAL '5 hours'
ORDER BY t.gesamtdauer DESC;

-- 2b) Wie 2a, aber mit CTE (WITH) statt Subquery.
WITH artist_dauer AS (
    SELECT aa.artist, COUNT(*) AS anzahl_audios, SUM(a.duration) AS gesamtdauer
    FROM audio_artist aa
    JOIN audio a ON a.id = aa.audio
    GROUP BY aa.artist
)
SELECT ar.name, t.anzahl_audios, t.gesamtdauer
FROM artist_dauer t
JOIN artist ar ON ar.id = t.artist
WHERE t.gesamtdauer > INTERVAL '5 hours'
ORDER BY t.gesamtdauer DESC;

-- 2c) Anzahl Songs, Gesamt- und Durchschnittsdauer pro Genre.
SELECT COALESCE(s.genre, 'unbekannt') AS genre,
       COUNT(*)                       AS anzahl_songs,
       SUM(a.duration)                AS gesamtdauer,
       AVG(a.duration)                AS durchschnittsdauer
FROM song s
JOIN audio a ON a.id = s.audio
GROUP BY s.genre
ORDER BY anzahl_songs DESC, genre;

-- 2d) Rang jedes Songs nach Dauer innerhalb seines Genres (Window-Funktion).
SELECT COALESCE(s.genre, 'unbekannt') AS genre,
       a.title,
       a.duration,
       RANK()   OVER (PARTITION BY s.genre ORDER BY a.duration DESC) AS rang_im_genre,
       COUNT(*) OVER (PARTITION BY s.genre)                          AS songs_im_genre
FROM song s
JOIN audio a ON a.id = s.audio
ORDER BY genre, rang_im_genre;

-- =====================================================================
-- Aufgabe 3: Views
-- =====================================================================

-- 3a) View mit dem Inhalt aller Playlists (über 5 Tabellen).
CREATE VIEW playlist_inhalt AS
SELECT u.username,
       p.id    AS playlist_id,
       p.title AS playlist,
       a.title AS song,
       s.genre,
       a.duration
FROM app_user u
JOIN playlist p       ON p.app_user = u.id
JOIN playlist_song ps ON ps.playlist = p.id
JOIN song s           ON s.audio = ps.song
JOIN audio a          ON a.id = s.audio;

-- 3b) Anzahl Songs und Gesamtdauer pro Playlist über die View.
SELECT username, playlist, COUNT(*) AS anzahl_songs, SUM(duration) AS gesamtdauer
FROM playlist_inhalt
GROUP BY playlist_id, username, playlist
ORDER BY gesamtdauer DESC;

-- 3c) Updatebare View aller Schweizer Artists (eine Tabelle, kein JOIN).
-- WITH CHECK OPTION verhindert, dass Datensätze aus der View fallen.
CREATE VIEW schweizer_artist AS
SELECT id, name, country
FROM artist
WHERE country = 'CH'
WITH CHECK OPTION;

-- Inhalt der View vor dem UPDATE.
SELECT * FROM schweizer_artist ORDER BY id;

-- 3d) Artist-Namen über die View ändern.
UPDATE schweizer_artist
SET name = 'Patent Ochsner & Büne Huber'
WHERE name = 'Patent Ochsner';

-- Kontrolle: Änderung ist in der Basistabelle artist sichtbar.
SELECT id, name, country FROM artist WHERE country = 'CH' ORDER BY id;
