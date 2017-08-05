module View.Home exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


--

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
        [ div [ class "field" ]
            [ label [ class "label" ] [ text "アラビア数字" ]
            , div [ class "control" ]
                [ input
                    [ placeholder "入力してください"
                    , class "input"
                    , onInput (Msg.Conversion << Msg.Conversion.EnterArabic)
                    , value <|
                        Maybe.withDefault "" <|
                            model.conversion.arabic
                    ]
                    []
                ]
            ]
        , div [ class "field" ]
            [ label [ class "label" ] [ text "漢数字" ]
            , div [ class "control" ]
                [ input
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
    ]
