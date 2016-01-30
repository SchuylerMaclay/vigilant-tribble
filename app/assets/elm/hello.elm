module Hello where

import Graphics.Element exposing (show)

port noun : String

main =
  show ("Hello " ++ noun)
