# Underground League

Underground League is a modular Roblox R15 MMORPG prototype with a New York City-inspired surface world and a large PvP-enabled sewer world below it.

## Implemented Systems

- Server bootstrap with `StreamingEnabled`, lighting/post effects, DataStore autosave, and service wiring.
- Shared configuration for levels, leagues, currencies, world size, PvP rules, and starter ability tuning.
- Server-authoritative combat with RemoteEvent validation, cooldowns, mana costs, hit validation, critical hits, invulnerability frames, healing, dash, stun/knockback metadata, and damage-number replication.
- Procedural surface city generator for a 3200×3200-stud map containing roads, downtown/residential/industrial/park/dock districts, stores, restaurants, police station, hospital, warehouses, subway-style landmarks, traffic lights, rooftops/buildings, and sewer manholes.
- Procedural underground sewer generator with main/cross tunnels, PvP lobby, ranked/casual/training arenas, boss/generator/maintenance/secret loot rooms, and atmospheric light markers.
- Pathfinding enemy class for patrol/chase/attack PvE AI using `PathfindingService` and `CollectionService` damageable tags.
- Player data, progression, reset-ready league model, inventory/equipment, quests, achievements, matchmaking, and profile synchronization services.
- Client input controller for Z/X/C/V abilities and a generated AAA-style HUD foundation for health/mana/XP/league/money/quests/inventory/matchmaking.

## Roblox Layout

```text
ReplicatedStorage/UndergroundLeague
  Configs
  Shared
  Remotes
ServerScriptService
  Main.server.lua
  UndergroundLeague
    AI
    Controllers
    Services
    World
StarterPlayer/StarterPlayerScripts/UndergroundLeague
StarterGui/UndergroundLeagueUI
```

## Notes

This repository uses plain Roblox filesystem conventions. Import these folders into the matching Roblox services or connect them to a Rojo project if desired. Replace placeholder `rbxassetid://0` animation and sound IDs with production assets before release.
