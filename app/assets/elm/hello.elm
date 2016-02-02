module Hello where


import Debug
import Char
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing ((:=))
import String
import Task exposing (..)

port noun : String

-- VIEW

view : String -> Result String (List String) -> Html
view string result =
  let field =
        input
          [ placeholder "User Name"
          , value string
          , on "input" targetValue (Signal.message query.address)
          , myStyle
          ]
          []

      messages =
        case result of
          Err msg ->
              [ div [ myStyle ] [ Html.text msg ] ]

          Ok users ->
              List.map (\user -> div [ myStyle ] [ Html.text user ]) users
  in
      div [] (field :: messages)


myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]


-- WIRING

main =
  Signal.map2 view query.signal results.signal


query : Signal.Mailbox String
query =
  Signal.mailbox ""


results : Signal.Mailbox (Result String (List String))
results =
  Signal.mailbox (Err "A valid User name is 3 characters")


port requests : Signal (Task x ())
port requests =
  Signal.map lookupZipCode query.signal
    |> Signal.map (\task -> Task.toResult task `andThen` Signal.send results.address)


lookupZipCode : String -> Task String (List String)
lookupZipCode query =
  let toUrl =
        if True
          then succeed ("http://localhost:3000/users/findme/" ++ query ++ ".json")
          else fail "No User With that name"
  in
      toUrl `andThen` (mapError (always "User not found") << Http.get users)



users : Json.Decoder (List String)
users =
  let user =
        Json.object2 (\name password -> name ++ ", " ++ password)
          ("name" := Json.string)
          ("password" := Json.string)
  in
      "names" := Json.list user
