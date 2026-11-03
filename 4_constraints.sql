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
