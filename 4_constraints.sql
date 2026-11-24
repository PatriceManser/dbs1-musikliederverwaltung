-- Autoren: Manser, Rusch, Stadler

ALTER TABLE audio
    ADD CONSTRAINT audio_duration_positive CHECK (duration > INTERVAL '0');

ALTER TABLE audio
    ADD CONSTRAINT audio_audio_url_unique UNIQUE (audio_url);

ALTER TABLE playlist
    ADD CONSTRAINT playlist_title_per_user_unique UNIQUE (app_user, title);

CREATE FUNCTION check_album_song_artist() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM audio_artist aa
        JOIN album_artist al ON al.artist = aa.artist
        WHERE aa.audio = NEW.song
          AND al.album = NEW.album
    ) THEN
        RAISE EXCEPTION 'Song % hat keinen gemeinsamen Artist mit Album %', NEW.song, NEW.album;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER album_song_artist_check
    BEFORE INSERT OR UPDATE ON album_song
    FOR EACH ROW EXECUTE FUNCTION check_album_song_artist();

ALTER TABLE app_user
    ADD CONSTRAINT app_user_username_unique UNIQUE (username);

-- =====================================================================
-- Testat 4, Aufgabe 5: Tests
-- =====================================================================
-- Die folgenden INSERTs schlagen erwartungsgemäss fehl. Sie sind deshalb
-- auskommentiert, damit 0_runAllScripts.sql fehlerfrei durchläuft. Unter
-- jedem Test steht die Fehlermeldung, die Postgres beim Versuch geliefert hat.

-- Test 1 (ENUM): 'Jazz' ist kein Wert des Aufzähltyps genre_type. Das Audio
-- wird zuerst gültig eingefügt, damit der Test nur am Genre scheitert; ROLLBACK
-- entfernt es wieder. Mit 'Rock' würde der zweite INSERT funktionieren.
-- BEGIN;
-- INSERT INTO audio (title, duration, audio_url)
--     VALUES ('Take Five', '00:05:24', 'https://audio.example.com/31.mp3');
-- INSERT INTO song (audio, genre) VALUES (lastval(), 'Jazz');
-- ROLLBACK;
-- ERROR:  invalid input value for enum genre_type: "Jazz"

-- Test 2 (BOOLEAN): 'ja' ist kein gültiger BOOLEAN-Wert (gültig wären z.B.
-- TRUE/FALSE, 'yes'/'no', 't'/'f' oder '1'/'0').
-- INSERT INTO playlist (title, app_user, is_public) VALUES ('Test', 1, 'ja');
-- ERROR:  invalid input syntax for type boolean: "ja"

-- Test 3 (UNIQUE-Constraint): Der Benutzername 'lisa_s' existiert bereits (K5).
-- Die Sequence app_user_id_seq wird dabei trotzdem hochgezählt (Lücke in den IDs).
-- INSERT INTO app_user (username) VALUES ('lisa_s');
-- ERROR:  duplicate key value violates unique constraint "app_user_username_unique"
-- DETAIL:  Key (username)=(lisa_s) already exists.

-- Test 4 (durch den PK implizierter UNIQUE-Constraint): Bei SERIAL darf die ID
-- explizit angegeben werden, der Primärschlüssel verhindert aber Duplikate.
-- INSERT INTO app_user (id, username) VALUES (1, 'neuer_user');
-- ERROR:  duplicate key value violates unique constraint "app_user_pkey"
-- DETAIL:  Key (id)=(1) already exists.
