module Goodbye where


import Debug
import Char
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing ((:=))
import String
import Task exposing (..)
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window

port noun : String


myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]



main : Signal Element
main =
  Signal.map2 scene Mouse.position Window.dimensions


scene : (Int,Int) -> (Int,Int) -> Element
scene (x,y) (w,h) =
  let
    (dx,dy) =
      (toFloat x - toFloat w / 2, toFloat h / 2 - toFloat y)
  in
    collage w h
      [ ngon 3 100
          |> filled blue
          |> rotate (atan2 dy dx)
      , ngon 6 30
          |> filled orange
          |> move (dx, dy)
      ]
