# belegscanner_mvp

Manuell angelegtes Flutter-Projektgerüst mit iOS- und Android-Verzeichnissen sowie vorbereiteter Feature-Struktur.

## Projektstruktur
- `lib/app/`: Bootstrap und Routing
- `lib/features/jobs/`: Job-Übersicht und Detailansichten
- `lib/features/capture/`: Kamera- und Vorschaulogik
- `lib/services/`: API, Uploads, Connectivity
- `lib/storage/`: Datenbank und Repositories
- `lib/models/`: zentrale Modelle (z. B. `ScanJob`, API-Responses)
- `lib/utils/`: Hilfsfunktionen (UUID, Zeit, Logging)

Die Plattformverzeichnisse wurden als Platzhalter angelegt, damit iOS- und Android-Support vorbereitet ist. Sobald das Flutter SDK verfügbar ist, kann das Projekt mit `flutter create .` bzw. den jeweiligen Toolchains vervollständigt werden.
