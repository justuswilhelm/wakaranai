module View.About exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)


view : Model -> List (Html Msg)
view model =
    [ p [] [ text "Hello, World! This is the About Page." ]
    ]
