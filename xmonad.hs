import XMonad
import XMonad.Util.SpawnOnce

main = xmonad defaultConfig
         { modMask = mod4Mask
         -- enable this when you want to run some xmodmap commands to replace
         -- key bindings
         -- , startupHook = spawnOnce "xmodmap ~/.xmodmap"
         }
