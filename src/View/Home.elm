module View.Home exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msg exposing (..)


view : Model -> List (Html Msg)
view model =
    [ section
        [ class "section" ]
        [ div [ class "content" ]
            [ p [] [ text "Hello, World! This is the Home Page." ]
            ]
        ]
    ]
