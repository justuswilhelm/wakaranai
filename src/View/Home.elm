module View.Home exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import Msg
import Msg.Conversion


view : Model -> List (Html Msg.Msg)
view model =
    [ div [ class "content" ]
        [ h1 []
            [ text "アラビア数字変換"
            ]
        ]
    , Html.form []
        [ label
            [ class "label"
            ]
            [ text "アラビア数字"
            , input
                [ placeholder "入力ください"
                , class "input"
                , onInput (Msg.Conversion << Msg.Conversion.EnterArabic)
                , value <|
                    Maybe.withDefault "" <|
                        model.conversion.arabic
                ]
                []
            ]
        , br [] []
        , label
            [ class "label"
            ]
            [ text "漢数字"
            , input
                [ placeholder "結果"
                , class "input"
                , disabled True
                , value <|
                    Maybe.withDefault "" <|
                        model.conversion.japanese
                ]
                []
            ]
        ]
    ]
