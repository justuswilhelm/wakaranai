module View.About exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


--

import Model exposing (Model)
import Msg exposing (..)


view : Model -> List (Html Msg)
view model =
    [ div [ class "content" ]
        [ p [] [ text "Hello, World! This is the About Page." ]
        ]
    ]
