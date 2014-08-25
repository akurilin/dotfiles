import qualified Data.Map as M
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Accordion
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.StackSet(greedyView)

myManageHook = composeAll
    [ manageHook gnomeConfig
    , resource  =? "stalonetray" --> doIgnore
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doFloat
    , className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , manageDocks
    ]

myStartupHook = do
  -- spawnOnce "xmodmap ~/.Xmodmap"
  -- spawnOnce "feh --bg-scale ~/Pictures/wallpaper-2782461.jpg"
  spawnOnce "nm-applet"
  spawnOnce "stalonetray"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/callen/.xmobarrc"
    xmonad $ gnomeConfig {
         manageHook = myManageHook
       , layoutHook = smartBorders $ avoidStruts $ layoutHook defaultConfig
       , logHook = dynamicLogWithPP xmobarPP
                   { ppOutput = hPutStrLn xmproc
                   , ppTitle = xmobarColor "green" "" . shorten 50
                   }
       , startupHook = myStartupHook
       , modMask = mod4Mask
       , terminal = "gnome-terminal"
       }
