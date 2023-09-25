# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.5.0] - 2023-09-24
### Added
- New player biped (customizable vía insurrection)
- Multiplayer announcer sounds
- New dynamic crosshairs
- New weapon Skewer  
`BLEED IT OUT MAP`
- New scenerys
- New vehicle (mounted machinegun)

### Fixed
- Hill controlled
- Increased projectile maximum distance for stalker rifle 40 to 800 wu
- Spawn time for weapons on all maps  
`IMPASSE MAP`
- Player clip colision projectiles 

### Changed
- Texture size optimizations
- Enhanced model and shaders on warthog
- Adjusted some weapon icons on HUD 
- Not all vehicles will spawn on maps by default  
`PLASMA CASTER WEAPON`
- Implemented new primary projectile system (it doesn't counted your kill)
- Increased maximum range projectile 40 to 350  
`LAST VOYAGE MAP`
- Adjusted 4 fusion coil spawns (2 for each side)
- Enhanced environment and scenery textures/shaders  
`IMPASSE MAP`
- Enhanced silo and satelite textures/shaders  
`WASP`
- Enhanced textures/shaders 
- Increased weapon autoaim angle 5 to 6
- Increased weapon magnetism angle 10 to 12
- Increased weapon rocket damage on 10%
- Rocket enemy tracking 0 to 25

## [4.4.0] - 2023-08-04
### Added
- New map Impasse
- New vehicle Wasp
- Disruptor / can electrocute metal material on vehicles with half damage against bipeds
- Plasma Caster / reload fx
- Storm Rifle / ready var sounds
- Plasma Pistol / posing sound
- Flag stand on all maps
- Banshee / flight and visual improvements
- Warthog / new HUD
- Bleed It Out / normal maps on terrain
- Bleed It Out / vegetation and scenerys
- Bleed It Out / water cave collision
- Vehicle pads on maps

### Fixed
- Integrity of some tags (invader warnings)
- Biped idle unarmed variation legs position
- Biped stand unarmed set
- Unarmed crosshair HUD
- Plasma Caster / reduced camera pushback
- Deleted dyamic light and extra lights/flares on weapon pads
- Treason / traspasable collision on "indus_stuff_a" scenery (green container)
- Bleed It Out / adjusted player clip for camper spots
- Last Voyage / erased flashlight flag on dynamic lights
- Reduced damage acceleration on vehicles
- Crouch missile set animations

### Changed
- Disruptor / reduced supercombine damage 5 to 15
- Disruptor / reduced maximum ROF 4.286 to 3.75
- Bleed It Out / Optimization shaders for lightmaps
- Bleed It Out / reduced darken shadows
- Bleed It Out / removed back covers on bases
- Bleed It Out / wasp spawns on slayer, banshee spawns on CTF
- Bleed It Out / lightmaps
- Bleed It Out / skybox
- Plasma Caster / new primary projectile bounce implementation
- Plasma Caster / adjusted primary projectile friction on materials 
- Plasma Caster / reduced autoaim angle 6 to 3
- Plasma Caster / reduced magnetism angle 12 to 6
- Plasma Caster / increased charging time 0.3 to 0.5
- Plasma Caster / reduced heat recovery threshold 0.1 to 0.05
- Plasma Caster / reduced primary projectile aceleration scale 2 to 0.05
- Plasma Caster / reduced charged single grenade projectile aceleration scale 2 to 0.05
- Plasma Caster / reduced primary projectile air gravity 3.5 to 2
- Plasma Caster / increased primary projectile final velocity 22.5 to 25.5
- Plasma Caster / reduced primary projectile final velocity 3 to 2.55
- Plasma Caster / increased primary projectile guied angular velocity 0 to 5
- Plasma Caster / reduced secondary projectile initial velocity 45 to 28.5
- Plasma Caster / reduced secondary projectile final velocity 30 to 16.5
- Plasma Caster / reduced secondary projectile air gravity 0.35 to 0.3
- Plasma Rifle / increased ROF from 6 to 7.5
- Plasma Rifle / increased heat loss from 0.35 to 0.5
- Plasma Rifle / increased heat recovery from 0.05 to 0.5
- Plasma Rifle / increased heat per shot from 0.1 to 0.11
- Plasma Rifle / increased autoaim angle & magnetism angle from 4 & 6 to 6 & 12 degrees
- Plasma Rifle / increased tracking from 0 to 30
- Plasma Rifle / decreased bolt speed from 50-25 to 25-15
- Plasma Pistol / increased heat loss from 0.4 to 0.75
- Plasma Pistol / increased heat per shot from 0.1 to 0.12
- Plasma Pistol / increased tracking from 0 to 30
- Plasma Pistol / decreased bolt speed from 50-25 to 25-15
- Storm Rifle / reduced heat generated per round 0.13 to 0.12
- Storm Rifle / increased velocity projectile 60%
- Storm Rifle / reduced age generated per round 0.01 to 0.005
- Storm Rifle / reduced error angle 25%
- increased rider damage fraction on banshee 0.12 to 0.18
- increased rider damage fraction ghost and warthog 0.12 to 0.15
- Adjusted some covenant weapon shaders
- Carnage report background (placeholder)
- Dynamic light radius on powerups
- Banshee / weapon functionality
- Standard grass tonality
- Material effect collision on player clip with vehicles

## [4.3.0] - 2023-07-13
### Added
- Plasma Rifle / melee and ready sounds
- HUD for m247 heavy machine gun
- Plasma rifle tracking variant available on fiesta
- Flag animations on warthog passenger

### Fixed
- Treason / traspasable collision on trash dump
- Plasma rifle fire sound glitch
- biped unarmed idle animation
- M247-HMG turret / fire sounds glitch
- Last Voyage / phantom bsp on centerplatform_xl scenery collision

### Changed
- Disruptor / reduced supercombine damage 25 to 5
- Disruptor / increased maximum ROF 3.75 to 4.286
- Plasma Caster / reduced air gravity projectile 5 to 3
- Plasma Rifle / increased initial velocity projectile 50 to 100
- Plasma Rifle / increased final velocity projectile 35 to 75
- Battle Rifle BR65H / increased initial-final velocity projectile 450 to 550
- Reduced driver damage fraction on banshee, warthog and ghost
- Lightmaps on treason, bleed it out and last voyage
- Last Voyage / bsp structure big windows

## [4.2.1] - 2023-07-06
### Added
- Bleed it out / hill spawns
- Bleed it out / weapon spawns on KOTH
- Bleed it out / scenerys

### Fixed
- Increased driver damage fraction on banshee (you were invincible before)
- Removed skewer prototype until it's done
- Reduced hill shader size it caused hindler the field of view

### Changed
- Disruptor / reduced impact damage 
- Needler / increased autoaim angle and magnetism angle
- Last voyage / increased ambient sound effect
- Renamed map and resources files to "last_voyage" (named "bridge" before)

## [4.2.0] - 2023-07-04
### Added
- New map Last Voyage
- Melee sound variation on storm rifle

### Fixed
- Flashlight biped always turn on (it's that you dark souls?)
- Treason, Bleed it Out / wind on all clusters

### Changed
- Bleed It Out / new lightmaps
- Bleed it Out / normalized lightmaps
- Treason / normalized lightmaps 
- ROF, aceleration, damage, error, heat generated and heat recovery for stationary turret
- ROF, aceleration, damage, error, heat generated and heat recovery for warthog chaingun

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
- Plasma Caster / After the charged shot you must wait 2 seconds to shoot again
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