module View.Home exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msg exposing (..)


view : Model -> List (Html Msg)
view model =
    [ div [ class "content" ]
        [ p [] [ text "Hello, World! This is the Home Page." ]
        , h1 [] [ text "The time is" ]
        , p []
            [ model.session.time
                |> Maybe.map toString
                |> Maybe.withDefault "Unknown"
                |> text
            ]
        ]
    ]
