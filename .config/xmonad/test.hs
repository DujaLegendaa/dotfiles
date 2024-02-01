import System.Process (readProcess)
import Data.List (isPrefixOf)

-- Function to switch keyboard layout
switchKeyboardLayout :: IO ()
switchKeyboardLayout = do
  -- Read current layout
  currentLayout <- readProcess "setxkbmap" ["-query"] ""

  -- Extract the current layout code
  let layoutCode = extractLayoutCode currentLayout

  -- Switch to the other layout
  let newLayoutCode = if layoutCode == "us" then "rs" else "us"
  let flags = if layoutCode == "us" then ["-layout", "rs", "-variant", "alternatequotes"] else ["-layout", "us"]

  -- Execute setxkbmap command to switch layout
  _ <- readProcess "setxkbmap" flags ""

  putStrLn $ "Switched from " ++ layoutCode ++ " to " ++ newLayoutCode ++ " keyboard layout."

-- Extracts the layout code from the setxkbmap output
extractLayoutCode :: String -> String
extractLayoutCode output = 
  let lines' = lines output
      layoutLine = head $ filter (isPrefixOf "layout:") lines'
  in last $ words layoutLine

-- Example usage
main :: IO ()
main = switchKeyboardLayout
