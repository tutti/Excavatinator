local _, private = ...

private.data = {}

private.data.artifacts = {
    --{ spell = ., item = ., rarity = "common", patch = 70000, pristine = { item = ., quest =  . }, achieve = 20, crate = true }, -- 
    dwarf = {
        { spell =  88910, item =  63113, rarity = "common", patch = 40000 }, -- Belt Buckle with Anvilmar Crest
        { spell =  90411, item =  64339, rarity = "common", patch = 40000 }, -- Bodacious Door Knocker
        { spell =  86866, item =  63112, rarity = "common", patch = 40000 }, -- Bone Gaming Dice
        { spell =  90412, item =  64340, rarity = "common", patch = 40000 }, -- Boot Heel with Scrollwork
        { spell =  86864, item =  63409, rarity = "common", patch = 40000 }, -- Ceramic Funeral Urn
        { spell =  90553, item =  64373, rarity =   "rare", patch = 40000 }, -- Chalice of the Mountain Kings
        { spell =  90521, item =  64372, rarity =   "rare", patch = 40000 }, -- Clockwork Gnome
        { spell =  90504, item =  64362, rarity = "common", patch = 40000 }, -- Dented Shield of Horuz Killcrow
        { spell =  93440, item =  66054, rarity = "common", patch = 40000 }, -- Dwarven Baby Socks
        { spell =  90413, item =  64342, rarity = "common", patch = 40000 }, -- Golden Chamber Pot
        { spell =  90419, item =  64344, rarity = "common", patch = 40000 }, -- Ironstar's Petrified Shield
        { spell =  90518, item =  64368, rarity = "common", patch = 40000 }, -- Mithril Chain of Angerforge
        { spell =  89717, item =  63414, rarity = "common", patch = 40000 }, -- Moltenfist's Jeweled Goblet
        { spell =  90410, item =  64337, rarity = "common", patch = 40000 }, -- Notched Sword of Tunadil the Redeemer
        { spell =  86857, item =  63408, rarity = "common", patch = 40000 }, -- Pewter Drinking Cup
        { spell =  91793, item =  64659, rarity = "common", patch = 40000 }, -- Pipe of Franclorn Forgewright
        { spell =  91225, item =  64487, rarity = "common", patch = 40000 }, -- Scepter of Bronzebeard
        { spell =  90509, item =  64367, rarity = "common", patch = 40000 }, -- Scepter of Charlga Razorflank
        { spell =  90506, item =  64366, rarity = "common", patch = 40000 }, -- Scorched Staff of Shadow Priest Anund
        { spell =  91219, item =  64483, rarity = "common", patch = 40000 }, -- Silver Kris of Korl
        { spell =  88181, item =  63411, rarity = "common", patch = 40000 }, -- Silver Neck Torc
        { spell =  90519, item =  64371, rarity = "common", patch = 40000 }, -- Skull Staff of Shadowforge
        { spell =  91223, item =  64485, rarity = "common", patch = 40000 }, -- Spiked Gauntlets of Anvilrage
        { spell =  91227, item =  64489, rarity =   "rare", patch = 40000 }, -- Staff of Sorcerer-Thane Thaurissan
        { spell =  88180, item =  63410, rarity = "common", patch = 40000 }, -- Stone Gryphon
        { spell =  91226, item =  64488, rarity =   "rare", patch = 40000 }, -- The Innkeeper's Daughter
        { spell =  91221, item =  64484, rarity = "common", patch = 40000 }, -- Warmaul of Burningeye
        { spell =  90415, item =  64343, rarity = "common", patch = 40000 }, -- Winged Helm of Corehammer
        { spell =  88909, item =  63111, rarity = "common", patch = 40000 }, -- Wooden Whistle
        { spell =  91224, item =  64486, rarity = "common", patch = 40000 }, -- Word of Empress Zoe
        { spell =  86865, item =  63110, rarity = "common", patch = 40000 }, -- Worn Hunting Knife
    },
    draenei = {
        { spell =  90853, item =  64440, rarity = "common", patch = 40000 }, -- Anklet with Golden Bells
        { spell =  90983, item =  64456, rarity =   "rare", patch = 40000 }, -- Arrival of the Naaru
        { spell =  90968, item =  64453, rarity = "common", patch = 40000 }, -- Baroque Sword Scabbard
        { spell =  90860, item =  64442, rarity = "common", patch = 40000 }, -- Carved Harp of Exotic Wood
        { spell =  90975, item =  64455, rarity = "common", patch = 40000 }, -- Dignified Portrait
        { spell =  90974, item =  64454, rarity = "common", patch = 40000 }, -- Fine Crystal Candelabra
        { spell =  90987, item =  64458, rarity = "common", patch = 40000 }, -- Plated Elekk Goad
        { spell =  90864, item =  64444, rarity = "common", patch = 40000 }, -- Scepter of the Nathrezim
        { spell =  90861, item =  64443, rarity = "common", patch = 40000 }, -- Strange Silver Paperweight
        { spell =  90984, item =  64457, rarity =   "rare", patch = 40000 }, -- The Last Relic of Argus
    },
    fossil = {
        { spell =  98560, item =  69776, rarity =   "rare", patch = 40100 }, -- Ancient Amber
        { spell =  90452, item =  64355, rarity = "common", patch = 40000 }, -- Ancient Shark Jaws
        { spell =  88930, item =  63121, rarity = "common", patch = 40000 }, -- Beautiful Preserved Fern
        { spell =  88929, item =  63109, rarity = "common", patch = 40000 }, -- Black Trilobite
        { spell =  90432, item =  64349, rarity = "common", patch = 40000 }, -- Devilsaur Tooth
        { spell =  98533, item =  69764, rarity =   "rare", patch = 40100 }, -- Extinct Turtle Shell
        { spell =  90617, item =  64385, rarity = "common", patch = 40000 }, -- Feathered Raptor Arm
        { spell =  89693, item =  60955, rarity =   "rare", patch = 40000 }, -- Fossilized Hatchling
        { spell =  90619, item =  60954, rarity =   "rare", patch = 40000 }, -- Fossilized Raptor
        { spell =  91132, item =  64473, rarity = "common", patch = 40000 }, -- Imprint of a Kraken Tentacle
        { spell =  90433, item =  64350, rarity = "common", patch = 40000 }, -- Insect in Amber
        { spell =  91089, item =  64468, rarity = "common", patch = 40000 }, -- Proto-Drake Skeleton
        { spell =  98582, item =  69821, rarity =   "rare", patch = 40100 }, -- Pterrordax Hatchling
        { spell =  93442, item =  66056, rarity = "common", patch = 40000 }, -- Shard of Petrified Wood
        { spell =  93443, item =  66057, rarity = "common", patch = 40000 }, -- Strange Velvet Worm
        { spell =  89895, item =  63527, rarity = "common", patch = 40000 }, -- Twisted Ammonite Shell
        { spell =  90618, item =  64387, rarity = "common", patch = 40000 }, -- Vicious Ancient Fish
    },
    nightelf = {
        { spell =  91761, item =  64646, rarity =   "rare", patch = 40000 }, -- Bones of Transformation
        { spell =  91762, item =  64647, rarity = "common", patch = 40000 }, -- Carcanet of the Hundred Magi
        { spell =  90610, item =  64379, rarity = "common", patch = 40000 }, -- Chest of Tiny Glass Animals
        { spell =  89696, item =  63407, rarity = "common", patch = 40000 }, -- Cloak Clasp with Antlers
        { spell =  89893, item =  63525, rarity = "common", patch = 40000 }, -- Coin from Eldre'Thalas
        { spell =  90611, item =  64381, rarity = "common", patch = 40000 }, -- Cracked Crystal Vial
        { spell =  90458, item =  64357, rarity = "common", patch = 40000 }, -- Delicate Music Box
        { spell =  90493, item =  64361, rarity =   "rare", patch = 40000 }, -- Druid and Priest Statue Set
        { spell =  89896, item =  63528, rarity = "common", patch = 40000 }, -- Green Dragon Ring
        { spell =  90453, item =  64356, rarity = "common", patch = 40000 }, -- Hairpin of Silver and Malachite
        { spell =  89009, item =  63129, rarity = "common", patch = 40000 }, -- Highborne Pyxis
        { spell =  90464, item =  64358, rarity =   "rare", patch = 40000 }, -- Highborne Soul Mirror
        { spell =  89012, item =  63130, rarity = "common", patch = 40000 }, -- Inlaid Ivory Comb
        { spell =  90451, item =  64354, rarity = "common", patch = 40000 }, -- Kaldorei Amphora
        { spell =  90614, item =  64383, rarity =   "rare", patch = 40000 }, -- Kaldorei Wind Chimes
        { spell =  93441, item =  66055, rarity = "common", patch = 40000 }, -- Necklace with Elune Pendant
        { spell =  90616, item =  64643, rarity =   "rare", patch = 40000 }, -- Queen Azshara's Dressing Gown
        { spell =  89014, item =  63131, rarity = "common", patch = 40000 }, -- Scandalous Silk Nightgown
        { spell =  90612, item =  64382, rarity = "common", patch = 40000 }, -- Scepter of Xavius
        { spell =  89894, item =  63526, rarity = "common", patch = 40000 }, -- Shattered Glaive
        { spell =  91766, item =  64648, rarity = "common", patch = 40000 }, -- Silver Scroll Case
        { spell =  90609, item =  64378, rarity = "common", patch = 40000 }, -- String of Small Pink Pearls
        { spell =  91757, item =  64645, rarity =   "rare", patch = 40000 }, -- Tyrande's Favorite Doll
        { spell =  91769, item =  64650, rarity = "common", patch = 40000 }, -- Umbra Crescent
        { spell =  91773, item =  64651, rarity =   "rare", patch = 40000 }, -- Wisp Amulet
    },
    nerubian = {
        { spell =  91214, item =  64481, rarity =   "rare", patch = 40000 }, -- Blessing of the Old God
        { spell =  91209, item =  64479, rarity = "common", patch = 40000 }, -- Ewer of Jormungar Blood
        { spell =  91191, item =  64477, rarity = "common", patch = 40000 }, -- Gruesome Heart Box
        { spell =  91188, item =  64476, rarity = "common", patch = 40000 }, -- Infested Ruby Ring
        { spell =  91215, item =  64482, rarity =   "rare", patch = 40000 }, -- Puzzle Box of Yogg-Saron
        { spell =  91170, item =  64475, rarity = "common", patch = 40000 }, -- Scepter of Nezar'azret
        { spell =  91197, item =  64478, rarity = "common", patch = 40000 }, -- Six-Clawed Cornice
        { spell =  91133, item =  64474, rarity = "common", patch = 40000 }, -- Spidery Sundial
        { spell =  91211, item =  64480, rarity = "common", patch = 40000 }, -- Vizier's Scrawled Streamer
    },
    tolvir = {
        { spell =  91790, item =  64657, rarity = "common", patch = 40000 }, -- Canopic Jar
        { spell =  91775, item =  64652, rarity = "common", patch = 40000 }, -- Castle of Sand
        { spell =  91779, item =  64653, rarity = "common", patch = 40000 }, -- Cat Statue with Emerald Eyes
        { spell =  92137, item =  60847, rarity =   "rare", patch = 40000 }, -- Crawling Claw
        { spell =  91785, item =  64656, rarity = "common", patch = 40000 }, -- Engraved Scimitar Hilt
        { spell =  92145, item =  64881, rarity =   "rare", patch = 40000 }, -- Pendant of the Scarab Storm
        { spell =  92168, item =  64904, rarity =   "rare", patch = 40000 }, -- Ring of the Boy Emperor
        { spell =  92148, item =  64883, rarity =   "rare", patch = 40000 }, -- Scepter of Azj'Aqir
        { spell =  92163, item =  64885, rarity =   "rare", patch = 40000 }, -- Scimitar of the Sirocco
        { spell =  91792, item =  64658, rarity = "common", patch = 40000 }, -- Sketch of a Desert Palace
        { spell =  91780, item =  64654, rarity = "common", patch = 40000 }, -- Soapstone Scarab Necklace
        { spell =  92139, item =  64880, rarity =   "rare", patch = 40000 }, -- Staff of Ammunae
        { spell =  91782, item =  64655, rarity = "common", patch = 40000 }, -- Tiny Oasis Mosaic
    },
    orc = {
        { spell =  90831, item =  64436, rarity = "common", patch = 40000 }, -- Fiendish Whip
        { spell =  90734, item =  64421, rarity = "common", patch = 40000 }, -- Fierce Wolf Figurine
        { spell =  90728, item =  64418, rarity = "common", patch = 40000 }, -- Gray Candle Stub
        { spell =  90843, item =  64644, rarity =   "rare", patch = 40000 }, -- Headdress of the First Shaman
        { spell =  90720, item =  64417, rarity = "common", patch = 40000 }, -- Maul of Stone Guard Mur'og
        { spell =  90730, item =  64419, rarity = "common", patch = 40000 }, -- Rusted Steak Knife
        { spell =  90732, item =  64420, rarity = "common", patch = 40000 }, -- Scepter of Nekros Skullcrusher
        { spell =  90833, item =  64438, rarity = "common", patch = 40000 }, -- Skull Drinking Cup
        { spell =  90832, item =  64437, rarity = "common", patch = 40000 }, -- Tile of Glazed Clay
        { spell =  90622, item =  64389, rarity = "common", patch = 40000 }, -- Tiny Bronze Scorpion
    },
    troll = {
        { spell =  90429, item =  64348, rarity = "common", patch = 40000 }, -- Atal'ai Scepter
        { spell =  90421, item =  64346, rarity = "common", patch = 40000 }, -- Bracelet of Jade and Coins
        { spell =  89891, item =  63524, rarity = "common", patch = 40000 }, -- Cinnabar Bijou
        { spell =  90581, item =  64375, rarity = "common", patch = 40000 }, -- Drakkari Sacrificial Knife
        { spell =  89890, item =  63523, rarity = "common", patch = 40000 }, -- Eerie Smolderthorn Idol
        { spell =  89711, item =  63413, rarity = "common", patch = 40000 }, -- Feathered Gold Earring
        { spell =  88907, item =  63120, rarity = "common", patch = 40000 }, -- Fetish of Hir'eek
        { spell =  93444, item =  66058, rarity = "common", patch = 40000 }, -- Fine Bloodscalp Dinnerware
        { spell =  90423, item =  64347, rarity = "common", patch = 40000 }, -- Gahz'rilla Figurine
        { spell =  98556, item =  69777, rarity =   "rare", patch = 40100 }, -- Haunted War Drum
        { spell =  89701, item =  63412, rarity = "common", patch = 40000 }, -- Jade Asp with Ruby Eyes
        { spell =  88908, item =  63118, rarity = "common", patch = 40000 }, -- Lizard Foot Charm
        { spell =  90420, item =  64345, rarity = "common", patch = 40000 }, -- Skull-Shaped Planter
        { spell =  90558, item =  64374, rarity = "common", patch = 40000 }, -- Tooth with Gold Filling
        { spell =  98588, item =  69824, rarity =   "rare", patch = 40100 }, -- Voodoo Figurine
        { spell =  88262, item =  63115, rarity = "common", patch = 40000 }, -- Zandalari Voodoo Doll
        { spell =  90608, item =  64377, rarity =   "rare", patch = 40000 }, -- Zin'rokh, Destroyer of Worlds
    },
    vrykul = {
        { spell =  91014, item =  64464, rarity = "common", patch = 40000 }, -- Fanged Cloak Pin
        { spell =  91012, item =  64462, rarity = "common", patch = 40000 }, -- Flint Striker
        { spell =  90988, item =  64459, rarity = "common", patch = 40000 }, -- Intricate Treasure Chest Key
        { spell =  90997, item =  64460, rarity =   "rare", patch = 40000 }, -- Nifflevar Bearded Axe
        { spell =  91008, item =  64461, rarity = "common", patch = 40000 }, -- Scramseax
        { spell =  91084, item =  64467, rarity = "common", patch = 40000 }, -- Thorned Necklace
        { spell =  98569, item =  69775, rarity =   "rare", patch = 40100 }, -- Vrykul Drinking Horn
    },
    mantid = {
        { spell = 139779, item =  95376, rarity = "common", patch = 50200, pristine = { item =  95384, quest =  32687 }, achieve = 20, crate = true }, -- Ancient Sap Feeder
        { spell = 139776, item =  95375, rarity = "common", patch = 50200, pristine = { item =  95383, quest =  32686 }, achieve = 20, crate = true }, -- Banner of the Mantid Empire
        { spell = 139781, item =  95378, rarity = "common", patch = 50200, pristine = { item =  95386, quest =  32689 }, achieve = 20, crate = true }, -- Inert Sound Beacon
        { spell = 139785, item =  95382, rarity = "common", patch = 50200, pristine = { item =  95390, quest =  32693 }, achieve = 20, crate = true }, -- Kypari Sap Container
        { spell = 139783, item =  95380, rarity = "common", patch = 50200, pristine = { item =  95388, quest =  32691 }, achieve = 20, crate = true }, -- Mantid Lamp
        { spell = 139786, item =  95391, rarity =   "rare", patch = 50200 },                                                                           -- Mantid Sky Reaver
        { spell = 139784, item =  95381, rarity = "common", patch = 50200, pristine = { item =  95389, quest =  32692 }, achieve = 20, crate = true }, -- Pollen Collector
        { spell = 139782, item =  95379, rarity = "common", patch = 50200, pristine = { item =  95387, quest =  32690 }, achieve = 20, crate = true }, -- Remains of a Paragon
        { spell = 139787, item =  95392, rarity =   "rare", patch = 50200 },                                                                           -- Sonic Pulse Generator
        { spell = 139780, item =  95377, rarity = "common", patch = 50200, pristine = { item =  95385, quest =  32688 }, achieve = 20, crate = true }, -- The Praying Mantid
    },
    pandaren = {
        { spell = 113977, item =  79903, rarity = "common", patch = 50000, pristine = { item =  89183, quest =  31802 }, achieve = 20, crate = true }, -- Apothecary Tins
        { spell = 113975, item =  79901, rarity = "common", patch = 50000, pristine = { item =  89181, quest =  31800 }, achieve = 20, crate = true }, -- Carved Bronze Mirror
        { spell = 113974, item =  79900, rarity = "common", patch = 50000, pristine = { item =  89180, quest =  31799 }, achieve = 20, crate = true }, -- Empty Keg
        { spell = 113976, item =  79902, rarity = "common", patch = 50000, pristine = { item =  89182, quest =  31801 }, achieve = 20, crate = true }, -- Gold-Inlaid Figurine
        { spell = 113971, item =  79897, rarity = "common", patch = 50000, pristine = { item =  85558, quest =  31796 }, achieve = 20, crate = true }, -- Pandaren Game Board
        { spell = 113968, item =  79896, rarity = "common", patch = 50000, pristine = { item =  85557, quest =  31795 }, achieve = 20, crate = true }, -- Pandaren Tea Set
        { spell = 113978, item =  79904, rarity = "common", patch = 50000, pristine = { item =  89194, quest =  31803 }, achieve = 20, crate = true }, -- Pearl of Yu'lon
        { spell = 113981, item =  89685, rarity =   "rare", patch = 50000 },                                                                           -- Spear of Xuen
        { spell = 113979, item =  79905, rarity = "common", patch = 50000, pristine = { item =  89185, quest =  31804 }, achieve = 20, crate = true }, -- Standard of Niuzao
        { spell = 113972, item =  79898, rarity = "common", patch = 50000, pristine = { item =  89178, quest =  31797 }, achieve = 20, crate = true }, -- Twin Stein Set
        { spell = 113980, item =  89684, rarity =   "rare", patch = 50000 },                                                                           -- Umbrella of Chi'Ji
        { spell = 113973, item =  79899, rarity = "common", patch = 50000, pristine = { item =  89179, quest =  31798 }, achieve = 20, crate = true }, -- Walking Cane
    },
    mogu = {
        { spell = 113993, item =  89614, rarity =   "rare", patch = 50000 },                                                                           -- Anatomical Dummy
        { spell = 113983, item =  79909, rarity = "common", patch = 50000, pristine = { item =  89170, quest =  31787 }, achieve = 20, crate = true }, -- Cracked Mogu Runestone
        { spell = 113987, item =  79913, rarity = "common", patch = 50000, pristine = { item =  89174, quest =  31791 }, achieve = 20, crate = true }, -- Edicts of the Thunder King
        { spell = 113988, item =  79914, rarity = "common", patch = 50000, pristine = { item =  89175, quest =  31792 }, achieve = 20, crate = true }, -- Iron Amulet
        { spell = 113982, item =  79908, rarity = "common", patch = 50000, pristine = { item =  89169, quest =  31786 }, achieve = 20, crate = true }, -- Manacles of Rebellion
        { spell = 113990, item =  79916, rarity = "common", patch = 50000, pristine = { item =  85477, quest =  31794 }, achieve = 20, crate = true }, -- Mogu Coin
        { spell = 113985, item =  79911, rarity = "common", patch = 50000, pristine = { item =  89172, quest =  31789 }, achieve = 20, crate = true }, -- Petrified Bone Whip
        { spell = 113992, item =  89611, rarity =   "rare", patch = 50000 },                                                                           -- Quilen Statuette
        { spell = 113984, item =  79910, rarity = "common", patch = 50000, pristine = { item =  89171, quest =  31788 }, achieve = 20, crate = true }, -- Terracotta Arm
        { spell = 113986, item =  79912, rarity = "common", patch = 50000, pristine = { item =  89173, quest =  31790 }, achieve = 20, crate = true }, -- Thunder King Insignia
        { spell = 113989, item =  79915, rarity = "common", patch = 50000, pristine = { item =  89176, quest =  31793 }, achieve = 20, crate = true }, -- Warlord's Branding Iron
        { spell = 113991, item =  79917, rarity = "common", patch = 50000, pristine = { item =  89209, quest =  31805 }, achieve = 20, crate = true }, -- Worn Monument Ledger
    },
    arakkoa = {
        { spell = 172460, item = 117354, rarity =   "rare", patch = 60000 },                                                                           -- Ancient Nest Guardian
        { spell = 168328, item = 114204, rarity = "common", patch = 60000, pristine = { item = 114222, quest =  36778 }, achieve = 20, crate = true }, -- Apexis Crystal
        { spell = 168329, item = 114205, rarity = "common", patch = 60000, pristine = { item = 114223, quest =  36779 }, achieve = 20, crate = true }, -- Apexis Hieroglyph
        { spell = 168330, item = 114206, rarity = "common", patch = 60000, pristine = { item = 114224, quest =  36780 }, achieve = 20, crate = true }, -- Apexis Scroll
        { spell = 168331, item = 117382, rarity =   "rare", patch = 60000 },                                                                           -- Breakbreaker of Terokk
        { spell = 168322, item = 114198, rarity = "common", patch = 60000, pristine = { item = 114216, quest =  36772 }, achieve = 20, crate = true }, -- Burial Urn
        { spell = 168323, item = 114199, rarity = "common", patch = 60000, pristine = { item = 114217, quest =  36773 }, achieve = 20, crate = true }, -- Decree Scrolls
        { spell = 168321, item = 114197, rarity = "common", patch = 60000, pristine = { item = 114215, quest =  36771 }, achieve = 20, crate = true }, -- Dreamcatcher
        { spell = 168327, item = 114203, rarity = "common", patch = 60000, pristine = { item = 114221, quest =  36777 }, achieve = 20, crate = true }, -- Outcast Dreamcatcher
        { spell = 168324, item = 114200, rarity = "common", patch = 60000, pristine = { item = 114218, quest =  36774 }, achieve = 20, crate = true }, -- Solar Orb
        { spell = 168325, item = 114201, rarity = "common", patch = 60000, pristine = { item = 114219, quest =  36775 }, achieve = 20, crate = true }, -- Sundial
        { spell = 168326, item = 114202, rarity = "common", patch = 60000, pristine = { item = 114220, quest =  36776 }, achieve = 20, crate = true }, -- Talonpriest Mask
    },
    draenorclans = {
        { spell = 168305, item = 114171, rarity = "common", patch = 60000, pristine = { item = 114172, quest =  36756 }, achieve = 20, crate = true }, -- Ancestral Talisman
        { spell = 172466, item = 117380, rarity =   "rare", patch = 60000 },                                                                           -- Ancient Frostwolf Fang
        { spell = 168301, item = 114163, rarity = "common", patch = 60000, pristine = { item = 114164, quest =  36753 }, achieve = 20, crate = true }, -- Barbed Fishing Hook
        { spell = 168298, item = 114157, rarity = "common", patch = 60000, pristine = { item = 114158, quest =  36750 }, achieve = 20, crate = true }, -- Blackrock Razor
        { spell = 168302, item = 114165, rarity = "common", patch = 60000, pristine = { item = 114166, quest =  36754 }, achieve = 20, crate = true }, -- Calcified Eye in a Jar
        { spell = 168303, item = 114167, rarity = "common", patch = 60000, pristine = { item = 114168, quest =  36755 }, achieve = 20, crate = true }, -- Ceremonial Tattoo Needles
        { spell = 168304, item = 114169, rarity = "common", patch = 60000, pristine = { item = 114170, quest =  36757 }, achieve = 20, crate = true }, -- Cracked Ivory Idol
        { spell = 168308, item = 114177, rarity = "common", patch = 60000, pristine = { item = 114178, quest =  36760 }, achieve = 20, crate = true }, -- Doomsday Prophecy
        { spell = 168297, item = 114155, rarity = "common", patch = 60000, pristine = { item = 114156, quest =  36749 }, achieve = 20, crate = true }, -- Elemental Bellows
        { spell = 168290, item = 114141, rarity = "common", patch = 60000, pristine = { item = 114142, quest =  36725 }, achieve = 20, crate = true }, -- Fang-Scarred Frostwolf Axe
        { spell = 168306, item = 114173, rarity = "common", patch = 60000, pristine = { item = 114174, quest =  36758 }, achieve = 20, crate = true }, -- Flask of Blazegrease
        { spell = 168291, item = 114143, rarity = "common", patch = 60000, pristine = { item = 114144, quest =  36743 }, achieve = 20, crate = true }, -- Frostwolf Ancestry Scrimshaw
        { spell = 168307, item = 114175, rarity = "common", patch = 60000, pristine = { item = 114176, quest =  36759 }, achieve = 20, crate = true }, -- Gronn-Tooth Necklace
        { spell = 172459, item = 116985, rarity =   "rare", patch = 60000 },                                                                           -- Headdress of the First Shaman
        { spell = 168300, item = 114161, rarity = "common", patch = 60000, pristine = { item = 114162, quest =  36752 }, achieve = 20, crate = true }, -- Hooked Dagger
        { spell = 168296, item = 114153, rarity = "common", patch = 60000, pristine = { item = 114154, quest =  36748 }, achieve = 20, crate = true }, -- Metalworker's Hammer
        { spell = 168294, item = 114149, rarity = "common", patch = 60000, pristine = { item = 114150, quest =  36746 }, achieve = 20, crate = true }, -- Screaming Bullroarer
        { spell = 168293, item = 114147, rarity = "common", patch = 60000, pristine = { item = 114148, quest =  36745 }, achieve = 20, crate = true }, -- Warsinger's Drums
        { spell = 168295, item = 114151, rarity = "common", patch = 60000, pristine = { item = 114152, quest =  36747 }, achieve = 20, crate = true }, -- Warsong Ceremonial Pike
        { spell = 168299, item = 114159, rarity = "common", patch = 60000, pristine = { item = 114160, quest =  36751 }, achieve = 20, crate = true }, -- Weighted Chopping Axe
        { spell = 168292, item = 114145, rarity = "common", patch = 60000, pristine = { item = 114146, quest =  36744 }, achieve = 20, crate = true }, -- Wolfskin Snowshoes
    },
    ogre = {
        { spell = 168315, item = 114191, rarity = "common", patch = 60000, pristine = { item = 114210, quest =  36767 }, achieve = 20, crate = true }, -- Eye of Har'gunn the Blind
        { spell = 168313, item = 114189, rarity = "common", patch = 60000, pristine = { item = 114208, quest =  36765 }, achieve = 20, crate = true }, -- Gladiator's Shield
        { spell = 168318, item = 114194, rarity = "common", patch = 60000, pristine = { item = 114213, quest =  36770 }, achieve = 20, crate = true }, -- Imperial Decree Stele
        { spell = 168314, item = 114190, rarity = "common", patch = 60000, pristine = { item = 114209, quest =  36766 }, achieve = 20, crate = true }, -- Mortar and Pestle
        { spell = 168311, item = 114185, rarity = "common", patch = 60000, pristine = { item = 114186, quest =  36763 }, achieve = 20, crate = true }, -- Ogre Figurine
        { spell = 168312, item = 114187, rarity = "common", patch = 60000, pristine = { item = 114188, quest =  36764 }, achieve = 20, crate = true }, -- Pictogram Carving
        { spell = 168317, item = 114193, rarity = "common", patch = 60000, pristine = { item = 114212, quest =  36769 }, achieve = 20, crate = true }, -- Rylak Riding Harness
        { spell = 168319, item = 117385, rarity =   "rare", patch = 60000 },                                                                           -- Sorcerer-King Toe Ring
        { spell = 168316, item = 114192, rarity = "common", patch = 60000, pristine = { item = 114211, quest =  36768 }, achieve = 20, crate = true }, -- Stone Dentures
        { spell = 168310, item = 114183, rarity = "common", patch = 60000, pristine = { item = 114184, quest =  36762 }, achieve = 20, crate = true }, -- Stone Manacles
        { spell = 168309, item = 114181, rarity = "common", patch = 60000, pristine = { item = 114182, quest =  36761 }, achieve = 20, crate = true }, -- Stonemaul Succession Stone
        { spell = 168320, item = 117384, rarity =   "rare", patch = 60000 },                                                                           -- Warmaul of the Warmaul Chieftain
    },
    highborne = {
        { spell = 196471, item = 130907, rarity = "common", patch = 70000, pristine = { item = 130922, quest =  40350 }, achieve = 20, crate = true }, -- Inert Leystone Charm
        { spell = 196474, item = 130910, rarity = "common", patch = 70000, pristine = { item = 130925, quest =  40353 }, achieve = 20, crate = true }, -- Nobleman's Letter Opener
        { spell = 196473, item = 130909, rarity = "common", patch = 70000, pristine = { item = 130924, quest =  40352 }, achieve = 20, crate = true }, -- Pre-War Highborne Tapestry
        { spell = 196472, item = 130908, rarity = "common", patch = 70000, pristine = { item = 130923, quest =  40351 }, achieve = 20, crate = true }, -- Quietwine Vial
        { spell = 196470, item = 130906, rarity = "common", patch = 70000, pristine = { item = 130921, quest =  40349 }, achieve = 20, crate = true }, -- Violetglass Vessel
        { spell = 223844, item = 131717, rarity =   "rare", patch = 70000 },                                                                           -- Starlight Beacon
        { spell = 223846, item = 131740, rarity =   "rare", patch = 70000 },                                                                           -- Crown Jewels of Suramar
        { spell = 223848, item = 131745, rarity =   "rare", patch = 70000 },                                                                           -- Key of Kalyndras
        { spell = 223849, item = 134078, rarity =   "rare", patch = 70000 },                                                                           -- Shard of Sciallax
        { spell = 223850, item = 131744, rarity =   "rare", patch = 70000 },                                                                           -- Key to Nar'thalas Academy
    },
    highmountaintauren = {
        { spell = 196478, item = 130914, rarity = "common", patch = 70000, pristine = { item = 130929, quest =  40357 }, achieve = 20, crate = true }, -- Drogbar Gem-Roller
        { spell = 196477, item = 130913, rarity = "common", patch = 70000, pristine = { item = 130928, quest =  40356 }, achieve = 20, crate = true }, -- Hand-Smoothed Pyrestone
        { spell = 196476, item = 130912, rarity = "common", patch = 70000, pristine = { item = 130927, quest =  40355 }, achieve = 20, crate = true }, -- Moosebone Fish-Hook
        { spell = 196479, item = 130915, rarity = "common", patch = 70000, pristine = { item = 130930, quest =  40358 }, achieve = 20, crate = true }, -- Stonewood Bow
        { spell = 196475, item = 130911, rarity = "common", patch = 70000, pristine = { item = 130926, quest =  40354 }, achieve = 20, crate = true }, -- Trailhead Drum
        { spell = 223851, item = 131733, rarity =   "rare", patch = 70000 },                                                                           -- Spear of Rethu
        { spell = 223852, item = 131736, rarity =   "rare", patch = 70000 },                                                                           -- Prizerock Neckbacnd
        { spell = 223853, item = 131734, rarity =   "rare", patch = 70000 },                                                                           -- Spirit of Eche'ro
    },
    demonic = {
        { spell = 196481, item = 130917, rarity = "common", patch = 70000, pristine = { item = 130932, quest =  40360 }, achieve = 20, crate = true }, -- Flayed-Skin Chronicle
        { spell = 196484, item = 130920, rarity = "common", patch = 70000, pristine = { item = 130935, quest =  40363 }, achieve = 20, crate = true }, -- Houndstooth Hauberk
        { spell = 196480, item = 130916, rarity = "common", patch = 70000, pristine = { item = 130931, quest =  40359 }, achieve = 20, crate = true }, -- Imp's Cup
        { spell = 196482, item = 130918, rarity = "common", patch = 70000, pristine = { item = 130933, quest =  40361 }, achieve = 20, crate = true }, -- Malformed Abyssal
        { spell = 196483, item = 130919, rarity = "common", patch = 70000, pristine = { item = 130934, quest =  40362 }, achieve = 20, crate = true }, -- Orb of Inner Chaos
        { spell = 223854, item = 131724, rarity =   "rare", patch = 70000 },                                                                           -- Crystalline Eye of Undravius
        { spell = 223855, item = 131735, rarity =   "rare", patch = 70000 },                                                                           -- Imp Generator
        { spell = 223856, item = 136922, rarity =   "rare", patch = 70000 },                                                                           -- Wyrmy Tunkins
        { spell = 223857, item = 131743, rarity =   "rare", patch = 70000 },                                                                           -- Blood of Young Mannoroth
        { spell = 223858, item = 131732, rarity =   "rare", patch = 70000 },                                                                           -- Purple Hills of Mac'Aree
    },
    drust = {
        { spell = 257715, item = 154921, rarity = "common", patch = 80000, pristine = { item = 154926, quest =  51950 }, crate = true },               -- Ceremonial Bonesaw
        { spell = 257716, item = 154922, rarity = "common", patch = 80000, pristine = { item = 154927, quest =  51951 }, crate = true },               -- Ancient Runebound Tome
        { spell = 257717, item = 154923, rarity = "common", patch = 80000, pristine = { item = 154928, quest =  51952 }, crate = true },               -- Disembowling Sickle (yes the game calls it "Disembowling")
        { spell = 257718, item = 154924, rarity = "common", patch = 80000, pristine = { item = 154929, quest =  51953 }, crate = true },               -- Jagged Blade of the Drust
        { spell = 257719, item = 154925, rarity = "common", patch = 80000, pristine = { item = 154930, quest =  51954 }, crate = true },               -- Ritual Fetish
        { spell = 273851, item = 160741, rarity = "common", patch = 80000, pristine = { item = 160742, quest =  51955 }, crate = true },               -- Soul Coffer
        { spell = 273852, item = 160751, rarity =   "rare", patch = 80000 },                                                                           -- Dance of the Dead
        { spell = 273854, item = 161089, rarity =   "rare", patch = 80000 },                                                                           -- Restored Revenant
        { spell = 273855, item = 160833, rarity =   "rare", patch = 80000 },                                                                           -- Fetish of the Tormented Mind

    },
    zandalari = {
        { spell = 257720, item = 154913, rarity = "common", patch = 80000, pristine = { item = 154931, quest =  51926 }, crate = true },               -- Akun'Jar Vase
        { spell = 257721, item = 154914, rarity = "common", patch = 80000, pristine = { item = 154932, quest =  51929 }, crate = true },               -- Urn of Passage
        { spell = 257722, item = 154915, rarity = "common", patch = 80000, pristine = { item = 154933, quest =  51932 }, crate = true },               -- Rezan Idol
        { spell = 257723, item = 154916, rarity = "common", patch = 80000, pristine = { item = 154934, quest =  51934 }, crate = true },               -- High Apothecary's Hood
        { spell = 257724, item = 154917, rarity = "common", patch = 80000, pristine = { item = 154935, quest =  51936 }, crate = true },               -- Bwonsamdi Voodoo Mask
        { spell = 273812, item = 160743, rarity = "common", patch = 80000, pristine = { item = 160744, quest =  51937 }, crate = true },               -- Blowgun of the Sethra
        { spell = 273815, item = 160740, rarity =   "rare", patch = 80000 },                                                                           -- Croak Crock
        { spell = 273817, item = 161080, rarity =   "rare", patch = 80000 },                                                                           -- Intact Direhorn Hatchling
        { spell = 273819, item = 160753, rarity =   "rare", patch = 80000 },                                                                           -- Sanguinating Totem
    }
}

private.data.raceOrder = { -- Because Blizzard reordered all the races in Legion.
    -- Note: This is not the display order for the races, this is the order they're in in the game's data.
    -- Reordering these incorrectly leads to incorrect data being loaded.
    -- The display order is the next one.
    [40000] = { "dwarf", "draenei", "fossil", "nightelf", "nerubian", "orc", "tolvir", "troll", "vrykul", "mantid", "pandaren", "mogu", "arakkoa", "draenorclans", "ogre" },
    [70000] = { "demonic", "highmountaintauren", "highborne", "ogre", "draenorclans", "arakkoa", "mogu", "pandaren", "mantid", "vrykul", "troll", "tolvir", "orc", "nerubian", "nightelf", "fossil", "draenei", "dwarf" },
    [80000] = { "drust", "zandalari", "demonic", "highmountaintauren", "highborne", "ogre", "draenorclans", "arakkoa", "mogu", "pandaren", "mantid", "vrykul", "troll", "tolvir", "orc", "nerubian", "nightelf", "fossil", "draenei", "dwarf" }
}

private.data.pages = {
    {
        title = EXPANSION_NAME7,
        patch = 80000,
        "drust", "zandalari"
    },
    {
        title = EXPANSION_NAME6,
        patch = 70000,
        "demonic", "highmountaintauren", "highborne"
    },
    {
        title = EXPANSION_NAME5,
        patch = 60000,
        "arakkoa", "draenorclans", "ogre"
    },
    {
        title = EXPANSION_NAME4,
        patch = 50000,
        "pandaren", "mogu", "mantid"
    },
    {
        title = EXPANSION_NAME3,
        patch = 40000,
        "dwarf", "draenei", "fossil", "nightelf", "nerubian", "orc", "tolvir", "troll", "vrykul"
    }
}