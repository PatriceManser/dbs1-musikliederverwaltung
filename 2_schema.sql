-- Autoren: Rusch, Stadler, Manser

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

CREATE TABLE app_user (
    id                  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
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
