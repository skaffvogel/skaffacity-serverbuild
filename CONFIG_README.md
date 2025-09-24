# SkaffaCity Unity Server Configuration

## server-config.json

Dit bestand bevat alle instellingen voor de SkaffaCity Unity dedicated server. Hieronder een gedetailleerde uitleg van elke sectie:

### 🌐 Master Server Settings (`masterServer`)

```json
{
  "masterServer": {
    "defaultUrl": "https://207.180.235.41:3000",  // URL van de master server
    "apiKey": "",                                  // API sleutel (optioneel)
    "enabled": true,                              // Master server registratie aan/uit
    "heartbeatInterval": 30,                      // Heartbeat interval in seconden
    "registrationTimeout": 10,                    // Timeout voor registratie in seconden
    "maxRetries": 3                              // Max aantal retry pogingen
  }
}
```

**Belangrijke notes:**
- De `defaultUrl` moet wijzen naar jouw master server
- Als `enabled` false is, draait de server standalone zonder master server
- `heartbeatInterval` bepaalt hoe vaak de server een heartbeat stuurt

### 🌐 Network Settings (`network`)

```json
{
  "network": {
    "tickRate": 30,                    // Server tick rate (Hz) - hogere waarden = meer CPU gebruik
    "maxConnections": 100,             // Maximum aantal gelijktijdige verbindingen
    "timeout": 30,                     // Verbinding timeout in seconden
    "allowInsecureConnections": true,  // Sta HTTP verbindingen toe (voor development)
    "bufferSize": 4096,               // Network buffer grootte in bytes
    "compressionEnabled": true         // Network compressie aan/uit
  }
}
```

**Performance tips:**
- `tickRate` van 30Hz is goed voor de meeste games
- Verhoog `maxConnections` alleen als je server het aankan
- `compressionEnabled` vermindert bandbreedte maar verhoogt CPU gebruik

### 🎮 Game Settings (`game`)

```json
{
  "game": {
    "maxPlayers": 50,                 // Maximum aantal spelers
    "gameMode": "survival",           // Game modus (survival, creative, pvp, etc.)
    "difficulty": "normal",           // Moeilijkheidsgraad
    "mapName": "SkaffaCity_Default", // Naam van de map
    "worldSize": {                   // Wereld afmetingen
      "x": 2000,
      "y": 2000,
      "z": 2000
    },
    "respawnTime": 10,               // Respawn tijd in seconden
    "friendlyFire": false            // Friendly fire aan/uit
  }
}
```

### 🖥️ Server Settings (`server`)

```json
{
  "server": {
    "name": "SkaffaCity Server",      // Server naam (zichtbaar in browser)
    "description": "Official Server", // Server beschrijving
    "region": "EU-West",              // Server regio
    "password": "",                   // Server wachtwoord (leeg = geen wachtwoord)
    "isPublic": true,                // Zichtbaar in server browser
    "autoStart": true,               // Automatisch starten
    "autoRestart": true,             // Automatisch herstarten bij crash
    "saveInterval": 300              // Automatisch opslaan interval (seconden)
  }
}
```

### ⚡ Performance Settings (`performance`)

```json
{
  "performance": {
    "targetFrameRate": 30,    // Doel framerate voor server
    "vSyncEnabled": false,    // VSync (altijd uit voor servers)
    "qualityLevel": 0,        // Unity quality level (0 = laagste)
    "shadowQuality": 0,       // Shadow kwaliteit (0 = uit)
    "textureQuality": 0,      // Texture kwaliteit (0 = laagste)
    "antiAliasing": 0         // Anti-aliasing (0 = uit)
  }
}
```

**Server optimization:**
- Zet alle grafische instellingen op de laagste waarden voor servers
- `targetFrameRate` van 30 is meestal voldoende
- Deze instellingen verminderen CPU/GPU gebruik

### 📝 Logging Settings (`logging`)

```json
{
  "logging": {
    "level": "INFO",                  // Log level (DEBUG, INFO, WARN, ERROR)
    "enableConsoleOutput": true,      // Console logging aan/uit
    "enableFileOutput": true,         // Bestand logging aan/uit
    "maxLogFileSize": 10485760,      // Max log bestand grootte (bytes)
    "maxLogFiles": 5,                // Max aantal log bestanden
    "logToMasterServer": true        // Logs naar master server sturen
  }
}
```

**Log levels:**
- `DEBUG`: Alle debug informatie
- `INFO`: Algemene informatie
- `WARN`: Waarschuwingen
- `ERROR`: Alleen errors

### 🔒 Security Settings (`security`)

```json
{
  "security": {
    "enableAntiCheat": true,          // Anti-cheat systeem aan/uit
    "maxPingThreshold": 300,          // Max ping in milliseconden
    "kickHighPingPlayers": false,     // Spelers met hoge ping kicken
    "rateLimitEnabled": true,         // Rate limiting aan/uit
    "maxRequestsPerSecond": 10       // Max requests per seconde per client
  }
}
```

### 🎯 Feature Settings (`features`)

```json
{
  "features": {
    "voiceChatEnabled": false,        // Voice chat ondersteuning
    "chatFilterEnabled": true,        // Chat filter voor ongepaste taal
    "statisticsEnabled": true,        // Statistieken verzamelen
    "backupEnabled": true,            // Automatische backups
    "modSupportEnabled": false        // Mod ondersteuning
  }
}
```

## Environment Variables

De server kan ook worden geconfigureerd via environment variables (hebben prioriteit over config bestand):

- `MASTER_SERVER_URL`: Master server URL
- `SERVER_PORT`: Server poort
- `MAX_PLAYERS`: Maximum aantal spelers
- `SERVER_NAME`: Server naam
- `TICK_RATE`: Server tick rate
- `REGION`: Server regio
- `GAME_MODE`: Game modus

## Pterodactyl Integration

Voor Pterodactyl Panel servers worden de volgende variables automatisch ingesteld:

- `{{SERVER_PORT}}`: Toegewezen poort
- `{{MASTER_SERVER_URL}}`: Master server URL
- `{{SERVER_NAME}}`: Server naam
- `{{MAX_PLAYERS}}`: Max spelers
- `{{TICK_RATE}}`: Tick rate
- `{{REGION}}`: Regio
- `{{GAME_MODE}}`: Game modus

## Troubleshooting

### Master Server Connection Issues

Als je problemen hebt met master server verbinding:

1. Controleer of `masterServer.defaultUrl` correct is
2. Zet `allowInsecureConnections` op `true` voor HTTP URLs
3. Controleer firewall instellingen
4. Test verbinding handmatig met curl/wget

### Performance Issues

Voor betere performance:

1. Verlaag `network.tickRate` naar 20Hz
2. Beperk `game.maxPlayers`
3. Zet alle `performance` instellingen op minimum
4. Schakel `network.compressionEnabled` uit bij CPU problemen

### Logging Issues

Voor debug informatie:

1. Zet `logging.level` op `DEBUG`
2. Controleer log bestanden in `/logs/` directory
3. Zet `logging.logToMasterServer` aan voor centrale logging

## Example Configurations

### Development Server
```json
{
  "masterServer": {
    "defaultUrl": "http://localhost:3000",
    "enabled": true
  },
  "network": {
    "allowInsecureConnections": true
  },
  "logging": {
    "level": "DEBUG"
  }
}
```

### Production Server
```json
{
  "masterServer": {
    "defaultUrl": "https://207.180.235.41:3000",
    "enabled": true
  },
  "network": {
    "allowInsecureConnections": false
  },
  "logging": {
    "level": "INFO"
  },
  "security": {
    "enableAntiCheat": true,
    "rateLimitEnabled": true
  }
}
```