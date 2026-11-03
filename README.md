# Audioverwaltung

## Beschreibung

Die Audioverwaltung verwaltet Audioinhalte wie Songs und Podcasts. Jedes Audio hat einen Titel, eine Dauer und eine Audio-URL und ist entweder ein Song oder ein Podcast. Ein Song hat zusätzlich ein Genre, ein Podcast eine Beschreibung. Audios werden von einem oder mehreren Artists veröffentlicht, ein Artist veröffentlicht beliebig viele Audios. Songs können auf Alben erscheinen, ein Album hat ein Veröffentlichungsdatum, wird von einem oder mehreren Artists veröffentlicht und enthält mindestens einen Song. Ein Song kann auf mehreren Alben vorkommen oder auf keinem (Single). User haben einen Benutzernamen und ein Profilbild und erstellen eine oder mehrere Playlists, die Songs enthalten. Ein Song kann in beliebig vielen Playlists enthalten sein.

## Konsistenzbedingungen

1. Die Dauer eines Audios ist grösser als 0.
2. Die Audio-URL eines Audios ist eindeutig.
3. Der Titel einer Playlist ist pro User eindeutig.
4. Ein Album enthält nur Songs, die von mindestens einem Artist des Albums veröffentlicht wurden.
5. Der Benutzername eines Users ist eindeutig.

## Einsatz von KI

Beschreibung, Konsistenzbedingungen und Klassendiagramm wurde von den Autoren erstellt mit Unterstützung von Claude Code verbessert.

## Klassendiagramm

```mermaid
classDiagram
    class Audio {
        +title : VARCHAR
        +duration : INTERVAL
        +audioUrl : VARCHAR
    }
    class Song {
        +genre : VARCHAR
    }
    class Podcast {
        +description : VARCHAR
    }
    class Artist {
        +name : VARCHAR
        +country : VARCHAR
    }
    class Album {
        +title : VARCHAR
        +releaseDate : DATE
    }
    class Playlist {
        +title : VARCHAR
    }
    class User {
        +username : VARCHAR
        +profilePictureUrl : VARCHAR
    }

    Audio <|-- Song
    Audio <|-- Podcast
    Audio "0..*" -- "1..*" Artist : veröffentlicht
    Artist "1..*" -- "0..*" Album : veröffentlicht
    Song "1..*" -- "0..*" Album : gehört zu
    User "1" -- "0..*" Playlist : erstellt
    Playlist "0..*" -- "0..*" Song : enthält

    note for Audio "{disjoint, complete} <br>(Song oder Podcast)<br>K1: duration > 0<br>K2: audioUrl eindeutig"
    note for Playlist "K3: title pro User eindeutig"
    note for Album "K4: enthält nur Songs der eigenen Artists"
    note for User "K5: username eindeutig"
```


## Logisches DB-Modell

Primärschlüssel ist jeweils das erste Attribut, bei den Beziehungstabellen die Kombination der beiden Fremdschlüssel. Die Vererbung von `Audio` ist mit einer Tabelle pro Klasse umgesetzt: `Song` und `Podcast` verwenden den Schlüssel von `Audio` als Primär- und Fremdschlüssel. User wurde zu AppUser umbenannt, da User ein reserviertes Wort ist.

```
Audio (
  ID INTEGER,
  Title VARCHAR(200) NOT NULL,
  Duration INTERVAL NOT NULL,
  AudioUrl VARCHAR(500) NOT NULL UNIQUE
)
Song (
  Audio REFERENCES Audio,
  Genre VARCHAR(50)
)
Podcast (
  Audio REFERENCES Audio,
  Description VARCHAR(2000)
)
Artist (
  ID INTEGER,
  Name VARCHAR(100) NOT NULL,
  Country VARCHAR(50)
)
Album (
  ID INTEGER,
  Title VARCHAR(200) NOT NULL,
  ReleaseDate DATE NOT NULL
)
AppUser (
  ID INTEGER,
  Username VARCHAR(50) NOT NULL UNIQUE,
  ProfilePictureUrl VARCHAR(500)
)
Playlist (
  ID INTEGER,
  Title VARCHAR(100) NOT NULL,
  AppUser NOT NULL REFERENCES AppUser
)
AudioArtist (
  Audio REFERENCES Audio,
  Artist REFERENCES Artist
)
AlbumArtist (
  Album REFERENCES Album,
  Artist REFERENCES Artist
)
AlbumSong (
  Album REFERENCES Album,
  Song REFERENCES Song
)
PlaylistSong (
  Playlist REFERENCES Playlist,
  Song REFERENCES Song
)
```

## Testdaten

Alle Tabellen enthalten mindestens 10 Tupel, auch die abgeleiteten Klassen `song` (20) und `podcast` (10). Es gibt daher keine Ausnahmen.

Bei den many-to-many Assoziationen sind alle Fälle abgedeckt:

- **Audio – Artist:** Audios mit einem und mit mehreren Artists (z. B. *Get Lucky*), Artists mit keinem, einem und vielen Audios.
- **Album – Artist:** Alben mit einem und mit mehreren Artists (*Best of Swiss Rock*), Artists mit keinem, einem und vielen Alben.
- **Album – Song:** Alben mit einem und mit vielen Songs, Songs auf keinem (Singles), einem und mehreren Alben (z. B. auf *Greatest Hits*).
- **Playlist – Song:** Playlists mit keinem, einem und vielen Songs, Songs in keiner, einer und vielen Playlists.

Zusätzlich gibt es einen User ohne Playlist, zwei User mit gleichem Playlist-Titel (erlaubt nach K3) und ein angekündigtes, noch nicht erschienenes Album.
