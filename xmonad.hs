import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

main = xmonad $ ewmh defaultConfig
         { modMask = mod4Mask
         , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
         } `additionalKeys` myKeys

myKeys = [ ((0, xK_Super_L), return ())
         ]
         ++
         [ ((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f)) -- Replace 'mod1Mask' with your mod key of choice.
         | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2] -- was [0..] *** change to match your screen order ***
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]
