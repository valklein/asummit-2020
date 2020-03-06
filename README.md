# Architecture Summit 2020

Wer den Workshop auf dem eigenen Rechner nachvollziehen möchte,
braucht:

- Docker
- Visual Studio Code mit den Extensions Haskell Synax, ghcide und
  Remote Containers
  
## Vorbereitung

Im Verzeichnis `docker-ghcide` folgenden Befehl absetzen:

```
docker build -t ghcide .
```

Dann in Visual Studio Code View -> Command Palette und dort

`Remote-Containers: Open Folder in Container`

Dann das Verzeichnis `haskell-code` auswählen und ein bißchen warten,
bis sich Docker beruhigt hat.

