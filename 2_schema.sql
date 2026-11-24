-- Autoren: Manser, Rusch, Stadler

CREATE TABLE audio (
    id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    duration    INTERVAL     NOT NULL,
    audio_url   VARCHAR(500) NOT NULL
);

CREATE TABLE song (
    audio   INTEGER PRIMARY KEY REFERENCES audio,
    genre   VARCHAR(50)
);

CREATE TABLE podcast (
    audio       INTEGER PRIMARY KEY REFERENCES audio,
    description VARCHAR(2000)
);

CREATE TABLE artist (
    id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

CREATE TABLE album (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title        VARCHAR(200) NOT NULL,
    release_date DATE         NOT NULL
);

-- Testat 4, Aufgabe 2: id ist vom Typ SERIAL (Sequence app_user_id_seq).
-- app_user.id wird nur von playlist referenziert (1:n) und ist damit nicht
-- Teil einer many-to-many Assoziation.
CREATE TABLE app_user (
    id                  SERIAL PRIMARY KEY,
    username            VARCHAR(50) NOT NULL,
    profile_picture_url VARCHAR(500)
);

CREATE TABLE playlist (
    id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title    VARCHAR(100) NOT NULL,
    app_user INTEGER      NOT NULL REFERENCES app_user
);

CREATE TABLE audio_artist (
    audio  INTEGER REFERENCES audio,
    artist INTEGER REFERENCES artist,
    PRIMARY KEY (audio, artist)
);

CREATE TABLE album_artist (
    album  INTEGER REFERENCES album,
    artist INTEGER REFERENCES artist,
    PRIMARY KEY (album, artist)
);

CREATE TABLE album_song (
    album INTEGER REFERENCES album,
    song  INTEGER REFERENCES song,
    PRIMARY KEY (album, song)
);

CREATE TABLE playlist_song (
    playlist INTEGER REFERENCES playlist,
    song     INTEGER REFERENCES song,
    PRIMARY KEY (playlist, song)
);

-- =====================================================================
-- Testat 4, Aufgabe 3: Schema-Evolution mit ALTER TABLE
-- =====================================================================

-- Aufzähltyp für das Genre eines Songs mit den bisher verwendeten Genres.
CREATE TYPE genre_type AS ENUM ('Disco', 'Hard Rock', 'House', 'Mundart', 'Pop', 'Rock');

-- song.genre von VARCHAR auf den Aufzähltyp umstellen. USING ist nötig, da
-- Postgres einen VARCHAR nicht automatisch in einen ENUM umwandelt.
ALTER TABLE song
    ALTER COLUMN genre TYPE genre_type USING genre::genre_type;

-- Neues Feld vom Typ BOOLEAN: Eine Playlist ist öffentlich (TRUE) oder
-- privat (FALSE). Ohne Angabe ist eine neue Playlist privat.
ALTER TABLE playlist
    ADD COLUMN is_public BOOLEAN NOT NULL DEFAULT FALSE;

-- =====================================================================
-- Testat 4, Aufgabe 4: Funktionaler Index
-- =====================================================================

-- Index auf den Ausdruck lower(name) für die Suche nach Artists unabhängig
-- von Gross-/Kleinschreibung (Anwendung siehe 5_queries.sql).
CREATE INDEX artist_name_lower_idx ON artist (lower(name));
