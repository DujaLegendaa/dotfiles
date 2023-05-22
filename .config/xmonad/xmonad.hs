import XMonad

import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers

-- Hooks
import XMonad.Hooks.SetWMName 

-- Utilities
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers
import qualified Data.Map as M
import Data.Maybe (fromJust)


myModMask :: KeyMask
myModMask = mod1Mask

myTerminal :: String 
myTerminal = "alacritty"

myEditor :: String 
myEditor = myTerminal ++ " -e nvim "

myBorderWidth :: Dimension
myBorderWidth = 2

mySpacing :: Int
mySpacing = 6

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "lxsession"
  spawnOnce "picom --experimental-backends"
  spawnOnce "brave"
  spawnOnce "nicotine -s"
  setWMName "LG3D"



myLayoutHook = smartSpacingWithEdge mySpacing $ tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100


myWorkspaces = [" \xf268 ", " \xf121 ", " \xf392 ", " \xf143 ", "\xf11b ", "\xf001 "]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "Brave-browser" --> doShift (myWorkspaces !! 0) 
  , className =? "discord" --> doShift (myWorkspaces !!  2)
  , className =? "fluent-reader" --> doShift (myWorkspaces !!  3)
  , className =? "Lutris" --> doShift (myWorkspaces !! 4)
  , className =? "Nicotine" --> doShift (myWorkspaces !! 5)
  ]


myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

main :: IO ()
main = xmonad 
      . ewmhFullscreen 
      . ewmh 
      . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
      $ def 

      {
        modMask = myModMask
        , terminal = myTerminal
        , startupHook = myStartupHook
        , layoutHook = myLayoutHook
        , workspaces = myWorkspaces
        , borderWidth = myBorderWidth
        , normalBorderColor = "#282a36"
        , focusedBorderColor = "#f8f8f2"
        , manageHook = myManageHook
      }
      `additionalKeysP`
      [ ("<Print>", spawn "flameshot gui")
        
      ]
