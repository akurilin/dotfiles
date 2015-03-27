import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig

main = xmonad $ ewmh defaultConfig
         { modMask = mod4Mask
         , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
         -- enable this when you want to run some xmodmap commands to replace
         -- key bindings
         -- , startupHook = spawnOnce "xmodmap ~/.xmodmap"
         }
         `additionalKeys`
         [ ((0, xK_Super_L), return ()) ]
