module View.Index exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)


view : Model -> Html Msg
view model =
    p [] [ text "Hello, World!" ]
