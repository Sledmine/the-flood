# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.1.2] - 2023-04-30
### Added
- webotes de oro
### Fixed


### Changed
- ROF, aceleration and heat generated per round for warthog chaingun
  


## [4.1.1] - 2023-04-29
### Added
- Treason / new sound_environment on interiors

### Fixed
- Particles for frag grenade explosion
- Adjusted weapon projectiles multiplier for metal materials.

## [4.1.0] - 2023-04-26
### Fixed
- Phantom BSP on collision from rock spire scenery
- Transparent shader on plasma caster that glitches teleporter 
- Treason - bugs on some object collisions (traspasable objects and weird biped movement by walking on that)

### Changed
- Bleed It Out / added mip maps on all bsp textures
- All fw rock set collisions 
- All crate collisions

## [4.0.1] - 2023-04-25
### Added
- Temporary player clip
- HUD for Ghost

### Fixed
- Wrong sprite sheet for particle in frag grenade
- Bleed It Out / UV's on some greometry
- Bleed It Out / Phantom BSP

### Changed
- Bleed It Out / Cubemap on water puddle in cave area
- Bleed It Out / Shader and textures for cliffs on BSP and sky
- Bleed It Out / Reworked all blend maps
- Bleed It Out / Lightmaps
- M6S / Increased error on CQC mod (hold primary trigger)
- HUD for Banshee
- Quick balance on banshee and ghost weapons

## [4.0.0] - 2023-04-24
### Added
- New map Bleed It Out
- Third person flame effects, light and sounds added to the skull for oddball
- LODs for SAW, Plasma Coil and Storm Rifle
- Passenger animations for the Warthog
- Melee animatins for the flag
- Treason / pistol spawns on king of the hill and oddball
- Treason / random spawn between rifle stalker and sniper in slayer and CTF (spawn reserved for skewer)
- Treason / plasma coil spawns for oddball

### Changed
- Rotate weapons and target point scripts disabled
- New Plasma Rifle 
- Disruptor / Buff projectile speed, aim assist and damaged
- Magnum M6S / CQC mode (semi-automatic shooting with greater dispersion by keeping the fire button pressed)
- Treason / General optimizations to the map, relocation of entries to the last section of the bases.

### Fixed 
- Treason / Bug when shooting with certain weapons and were near to walls, it made the map disappear
- Treason / Collision on wooden bases
- Treason / Bugs in some collisions of objects that could be pierced
- Shader in weapon screens (Z-fighting)

## [3.1.1] - 2023-03-29
### Changed
- Adjustments and additions to some crosshairs (assault rifle, plasma coil, storm rifle, shotgun, sniper)
- Treason / Relocated player spawn on plasma coil

### Fixed
- All scopes now support ultrawide screen 21:9 

## [3.1.0] - 2023-03-29
### Added
- Treason / New BSP materials
- Treason / LOD's on some objects

### Changed 
- Treason / portals
- Plasma Coil / You must hold down the fire button to throw it, the weapon no longer fires by pressing once
- Disruptor / Increased projectile speed and magnetism
- Plasma Rifle / Increased heat generated per shot and reduced magnetism
- Needler / Increased projectile speed

### Fixed
- Plasma Coil bug (previously it would explode non-stop if you killed a player who was about to cast it)

## [3.0.0] - 2023-03-26
### Added
- New animations and sounds for VK78 Commando
- New sounds for the Stalker Rifle
- New weapon added (Disruptor)
- Plasma coil re-implemented
- New animations and sounds for Magnum M6S
- Treason / New lighting in corridors and bases
- Treason / New materials and geometry of BSP
- Treason / New decorative objects
- Treason / LOD's in some scenerys
- Treason / Spawns for disruptor
- Treason / Spawns for plasma coils

### Changed 
- New particle effects on grenade explosions
- Updated camera shake when firing multiple weapons
- Updated storm rifle animations
- Treason / Location for pistols and plasma rifles
- Plasma Caster / You cannot shoot until after 1 second of reloading
- Plasma Caster / After the reloaded shot you must wait 2 seconds to shoot again
- Plasma Caster / Single shot explosion radius reduced from 2.8 to 1.8 WU (world units)
- Plasma Caster / Shield damage multiplier reduced from 2 to 1.5 on single shot
- Plasma Caster / Minimum damage area adjustment from 0.9 to 0.5 WU
- SPNKR / Explosion radius reduced from 2.8 to 2.5 WU (world units)
- SPNKR / Minimum damage area adjustment from 0.5 to 0.75WU
- SPNKR / Increased minimum damage at greater distance from 25 to 50
- SPNKR / Increased maximum damage in minimum area from 180 to 200
- Needler / Projectile speed increased from 7.5 to 9.5 WU/s
- Stalker Rifle / Reduced no-scope spread
- Plasma Coil / Just one click to launch it, if you quickly and repeatedly press the fire button hoping to take advantage, the coil will not be launched until you stop doing it
- Plasma Coil / Minimum damage area adjustment to 0.5 WU
- Plasma Coil / Increased the maximum explosion radius from 1.5 to 2 WU (world units)
- Grenades / Decreased the explosion radius from 2.5 to 2 WU (world units)
- Grenades / Minimum damage area adjustment to 0.5 WU
- The plasma grenade deals instant death in the minimum damage area

### Fixed
- Treason / UV's.
- Treason / General optimizations

## [2.1.1] - 2023-02-12
### Added
- Treason / New Textures
- Treason / New bsp geometry
- Treason / New objects on the map (obstacles, trucks, etc)
- Treason / New lights in the rooms
- Treason / New spawns
- Treason / New portals
- Treason / New hills

### Changed
-New balanced weapons

### Fixed
-Minor uv's
-Some lua issues

## [1.2.0] - 2022-12-08
### Added
- Treason / New objects on the map (unsc default boxes replaced)
- Treason / New lights in the rooms
- Treason / New environment sound depending on whether you are outside or inside
- Treason / New textures added in the bsp (room 2)

### Changed
- Player speed slightly decreased

### Fixed
- Old sandbox restored with small adjustments (except sniper, SPNKR, stalker), thanks Lennox for being the killer sandbox