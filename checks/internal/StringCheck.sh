#!/bin/bash

# Check if PID is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <PID>"
    exit 1
fi

PID=$1
sudo rm -f output/dumpJ.txt

# Internal Checks Java
sudo -E ./external-tools/lsdumper $PID >> output/dumpJ.txt
echo -e "\e[8;30;100t"
strings_to_check=(
"ucoz"
"yoKXth8DfBuCOZGvc+OIWUebiXuVtoJEPrFaoKA8HrY="
"gRYVNDkJr03nW7iDJP6gXnNM3mex+IF3i+YUCozyWEs="
"javax.swing.jframe"
"autoclicker.class"
"me/veylkar/pepe"
"_w_y6"
"net/minecraftxray/cv"
"reachmod/reachmod.class"
"a/a/a/oo000o00o0o00oo"
"_o&\`egdik0,ak"
"aimbot.class"
"ping:textures/ping.png"
"aimbot.java"
"!(ltrumpclientftw_bape_ggap)v"
"autoclicker.java"
"antivelocity"
"combat/forcefield"
"autotool.class"
"tsissamia"
"isaimbotenabled"
"settimerrate"
"modules.smoothaim"
"leonhard08kl1156126403715"
"me.tsglu.ke.djqjbqxtycwqpldszyig"
"me.tyler.module.mods.criticals"
"combat.autoclicker"
"dmillerw.ping.proxy.clientproxy"
"net/kohi/tcpnodelaymod/a.classpk"
"modules/aimassist"
"mojang/craft/block/w0mb4t/ac\$m"
"czaarek99"
"net/wurstclient/features/mod"
"awhhshithefuckedup.java"
"leakforums.net.user665158.modules.smoothaimbot"
"net.cancer.proxyclient"
"me/tsglu/ke/hitboxcommands"
"unique/unique0.class"
"modules.combat"
"knockback.setvalue"
"killaura.class"
"znvuy18xndg4mjffyq=="
"me.tojatta.clicker.ui.cl"
"pw/cinque/keystrokesmod/render/awhhshithefuckedup.classut"
"doubleclicker.properties"
"kyoctaviaprg.omikronclient.com"
"net.ccbluex.liquidbounce.injection.mixins.mixinblockladder"
"me/tru3/base/modules/modulemanager"
"assets/minecraft/huzuni"
"hypixel/xray/bypass/xray\$1"
"aura.class"
"libphantomclient.so"
"combat/entitykiller"
"aims for u, but smoooothly."
"aimboat.class"
"phantomclient.java"
"libphantom.so"
"phantom\\\\modules.properties"
"autocombo.class"
"io/fishermen/fpsdisplay/settings/ve.class"
"autoanchorfeature.class"
"autorekit.class"
"autototemfeature.class"
"auto retotem"
"autoenderabuse.class"
"autoanchor.class"
"extendedreach.class"
"autoinventorytotem.class"
"autodtap.class"
"autodoublehand.class"
"autohitcrystal.class"
"fastcrystals.class"
"a/a/a/a/a/b.class"
"automatically rekit when you run out of totems"
"autoclick.class"
"cheststealer"
"automatically attacks players for you"
"Double Crystal is a rewrite of MC"
"176.118.165.49"
"org.apache.core.m.ms.co.adh$$lambda$3461/0x000000080098e098"
"lorg/apache/core/mx/boxmixin;mix"
"org.apache.core.m.s.ks$1y"
"org/mapleir/dot4j/systems/module/impl/combat/"
"org/apache/core/m/ms/co/h/asm/mi"
"(lorg/apache/core/m/ms/co/adh;)vy"
"double pop like theo404"
"org.apache.core.m.ms.co.tb$$lambda$"
"http://31.220.80.176:1337/hwid"
"31.220.80.176"
"when enabled, crystal prediction will only activate when someone is pointing at an obsidian"
"/org/apache/core/e/e/sendchatmessagelistener$sendchatmessageevent.class"
"=>2>6>->#~j|k|{"
"when enabled, crystal prediction will only activate when someone is pointing at an obsidian with crystals out"
"org.apache.core.m.ms.co.art$$lambda$3488"
"org.apache.core.m.ms.r.nhc"
"(lorg/apache/core/m/s/bs;)v"
"org.apache.core.m.ms.r.ny"
"keystrokesmod/clickgui/raven/components/ButtonCategory"
"some_other_string"
"another_string"
"net/skliggahack"
"cc/aidshack/"
"net\\\\reach\\\\verzide"
"me/massi/reach"
"reach/verzide"
")&lt;*=,t-u/y0\\x02d3k5o7"
"net/reach/verzidesmoothaim-"
"me/massi/reach/reach.class"
"net.reach.verzide"
"VertexLib"
"by lattiahirvio"
"net/wurstclient/features/mod"
"assets/metro/",
"assets/metro/fonts"
"ReachCommands"
"aimassist"
"aim assist"
"aimbot"
"killaura"
"kill aura"
"triggerbot"
"autopot"
"auto pot"
"wallhack"
"wall hack"
"autoclick"
"auto click"
"reach.class"
"aimboat"
"aim boat"
"antivoid"
"anti void"
"AimbotGui"
"Aimbot Gui"
"AutoSoup"
"Auto Soup"
"Freecam"
"NoSlowDown"
"No Slow Down"
"Cancel all fall damage"
"AntiFall"
"Anti Fall"
"Scaffold.block"
"BedFucker"
"Bed Fucker"
"FastEat"
"Fast Eat"
"ChestEsp"
"Chest Esp"
"ChestStealer"
"Chest Stealer"
"InfinityJump"
"Infinity Jump"
"AutoArmor"
"Auto Armor"
"BaseFinder"
"Base Finder"
"AutoGap"
"Auto Gap"
"ChestAura"
"Chest Aura"
"AutoBlockhit"
"Auto Blockhit"
"SpawnerFinder"
"Spawner Finder"
"Cavefinder"
"Cave finder"
"StorageESP"
"Storage ESP"
"NametagsESP"
"Nametags ESP"
"ItemESP"
"Item ESP"
"NoClickDelay"
"AutoRefill"
"Auto Refill"
"AutoPearl"
"Auto Pearl"
"AutoEat"
"Auto Eat"
"airjump"
"air jump"
"Lagback"
"Backtrack"
"TPAura_Attack"
"_Velocity_Horizontal"
"_Velocity_Vertical"
"_Velocity_Delayed Horizontal"
"_Velocity_Delayed Vertical"
"_Regen_Health_"
"_NoFall_Mode_"
"WaterSpeed"
"Water Speed"
"AntiFire"
"Anti Fire"
"AimSpeed"
"Aim Speed"
"CrystalAura"
"Crystal Aura"
"clicker (add generic)"
"Aura_range"
"Teleport Aura"
"Target Strafe"
"Ping Spoof"
"Anti-KnockBack"
"Anti KnockBack"
"AutoDobleHand"
"Auto DobleHand"
"AutoRekit"
"Auto Rekit"
"AutoRefill"
"Auto Refill"
"AutoCringe"
"Auto Cringe"
"SpeedHack"
"Speed Hack"
"SpeedNuker"
"Speed Nuker"
"BonemealAura"
"Bonemeal Aura"
"BunnyHop"
"Bunny Hop"
"CameraNoClip"
"AutoMine"
"Auto Mine"
"AutoSteal"
"Auto Steal"
"AutoTotem"
"Auto Totem"
"AutoBuild"
"Auto Build"
"AntiWaterPush"
"Anti Water Push"
"AntiBlind"
"Anti Blind"
"AntiCactus"
"Anti Cactus"
"ClickAura"
"Click Aura"
"stoponKill"
"checkplayersaround"
"check players around"
"trackplayersaround"
"track players around"
"CwCrystalReWrite"
"autohitcrystal"
"auto hit crystal"
"AutoDobleHand"
"Auto Doble Hand"
"undetectablecrystal"
"undetectable crystal"
"18PingCrystal"
"AutoInventoryTotem"
"Auto Inventory Totem"
"AntiSlowness"
"Anti Slowness"
"Antislipperiness"
"Anti slipperiness"
"HackerDetector"
"Hacker Detector"
"Teleport hack"
"ReachCircle"
"Reach Circle"
"ClientNameSpoofer"
"Client Name Spoofer"
"bedaura"
"Bed Aura"
"antishuffle"
"Anti Shuffle"
"AutoHeadHitter"
"Auto Head Hitter"
"bednuker"
"Bed Nuker"
"MouseSpoofer"
"Mouse Spoofer"
"VClip (add generic)"
"AutoPlace"
"Auto Place"
"bridgeassist"
"Bridge Assist"
"AntiBot"
"Anti Bot"
"SprintResetTimings"
"Sprint Reset Timings"
"SafeWalk"
"Safe Walk"
"enjoy cheating"
"AntiHunger"
"Anti Hunger"
"playerhighlighter"
"Player Highlighter"
"hackerdetect"
"Destruct.class"
"hacks/module"
"hacks.module"
"hack/module"
"hack.module"
"baritone (add generic)"
"LegitReach"
"Legit Reach"
"NewTeleportAura"
"New Teleport Aura"
"StaffDetector"
"NoGroundCriticals"
"No Ground Criticals"
"AimBacktrack"
"Backtrack (add generic)"
"LegitWTap"
"AntiSuffocate"
"Anti Suffocate"
"SelfDestruct (add generic)"
"Ghosthand (add generic)"
"AttackEntityListener"
"Attack Entity Listener"
"automatically rekit when you run out of totems"
"automatically attack entity you are aiming at"
"automatically aims for you"
"automatically attacks players for you"
"Automatically puts on totems for you when you are in inventory"
"Aims at the closest entity to your cursor"
"Prevents Killaura from attacking teammates"
"AutoTotemFeature"
"Auto Tomem Feature"
"AutoAnchorFeature"
"Auto Anchor Feature"
"AutoEnderAbuse"
"Auto Ender Abuse"
"AutoEnderpearl"
"Auto Enderpearl"
"expand players hitbox"
"Auto Retotem"
"AutoRetotem"
"Verus_Combat"
"autocombo"
"autodtap"
"fastcrystals"
"Fast Crystals"
"autodoublehand"
"aura (add generic)"
"velocity (add generic)"
"smoothaim"
"Jitter Simulation"
"Jitter amount"
"clicker (add generic)"
"7selfDestruct"
"Self-Destruct"
"Self Destruct"
"Strings Deleted Succesfully"
"pww/cinque"
"onCl1ck"
"Criticals[Packets]"
"FastLadder"
"Fast Ladder"
"AutoClicker"
"Auto Clicker"
"Set Knockback Multiplier"
"Player ESP"
"PlayerESP"
"Skeleton ESP"
"SkeletonESP"
"togglemyinvishacks"
"Set Reach Amount"
"InvWalk"
"InstandLadders"
"Mob Aura"
"MobAura"
"FastBow"
"Fast Bow"
"External Misplace"
"Flight Engaged"
"Flight Disengaged"
"average cps"
"amount of cps"
"amount of click"
"Left Mouse Clicker"
"Right Mouse Clicker"
"Min CPS"
"MaxCPS"
"Max CPS"
"TPAura_Attack"
"Aura_Max CPS"
"FightBot"
"Fight Bot"
"Edge Sneak"
"EdgeSneak"
"AntiAFK"
"Anti AFK"
"KnockSpeed"
"Knock Speed"
"OutlineESP"
"Outline ESP"
"AntiVanish"
"Anti Vanish"
"cps add"
"cps subtract"
"click randomization"
"Advanced Randomization"
"Extreme Randomization"
"only while clicking"
"RMB Lock"
"LMB Lock"
"Enable JITTER"
"Click Multiplier"
"Mouse Clicker"
"delay between clicks"
"SetMouseHook"
"me.tsglu.ke"
"me/tsglu/ke"
"SumoClicker"
"LeftClicker"
"Left Clicker"
"RightClicker"
"Right Clicker"
"StringEncrypt (add generic)"
"NATIVE_MOUSE_PRESSED"
"jnativehook.dll"
"libJNativeHook.so"
"JNativeHook.soPK"
"TcpNoDelayTweaker"
"NativeMouseInput"
"NativeMouseEvent"
"NativeMouseMotion"
"NativeMouseWheel"
"SwingMouseWheel"
"NativeHookDemo"
"NativeHookException"
"NativeHookThread"
"NativeKeyEvent"
"CPS Scale"
"WatchdogAntiBot"
"MatrixAntiBot"
"Watchdog AntiBot"
"module.combat"
"module/combat"
"modules.combat"
"modules/combat"
"Bind (module name) to"
"Choose a (module name) value"
"| Keybind"
"Bind_"
"Auto (on some modules)"
)

for string in "${strings_to_check[@]}"; do
    if grep -Fq "$string" output/dumpJ.txt; then
        echo -e "[⚠️] Failed Generic Client C with string $string [In instance]" >> output/results.txt
        echo -e "[⚠️] \033[31mFailed Generic Client C with string $string [In instance]\033[0m"
    fi
done
