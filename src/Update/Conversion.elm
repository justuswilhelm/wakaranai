module Update.Conversion exposing (update)

import Msg
import Msg.Conversion exposing (..)
import Model exposing (Model)
import Result


toDigit : Int -> Char -> ( Maybe Char, Maybe Char )
toDigit position number =
    let
        greaterOne =
            case number of
                '0' ->
                    Nothing

                '1' ->
                    Nothing

                _ ->
                    Just number

        greaterZero =
            case number of
                '0' ->
                    Nothing

                _ ->
                    Just number
    in
        case position % 4 of
            0 ->
                case position // 4 of
                    0 ->
                        ( case number of
                            '0' ->
                                Nothing

                            _ ->
                                Just number
                        , Nothing
                        )

                    1 ->
                        ( case number of
                            '0' ->
                                Nothing

                            _ ->
                                Just number
                        , Just '万'
                        )

                    2 ->
                        ( case number of
                            '0' ->
                                Nothing

                            _ ->
                                Just number
                        , Just '億'
                        )

                    3 ->
                        ( case number of
                            '0' ->
                                Nothing

                            _ ->
                                Just number
                        , Just '兆'
                        )

                    4 ->
                        ( case number of
                            '0' ->
                                Nothing

                            _ ->
                                Just number
                        , Just '京'
                        )

                    _ ->
                        ( Nothing, Nothing )

            1 ->
                ( greaterOne, Just '十' )

            2 ->
                ( greaterOne, Just '百' )

            3 ->
                ( greaterOne, Just '千' )

            _ ->
                ( Nothing, Nothing )


arabicToJapanese : String -> String
arabicToJapanese arabic =
    let
        convertNumber ( a, b ) =
            ( case a of
                Nothing ->
                    Nothing

                Just '0' ->
                    Just '○'

                Just '1' ->
                    Just '一'

                Just '2' ->
                    Just '二'

                Just '3' ->
                    Just '三'

                Just '4' ->
                    Just '四'

                Just '5' ->
                    Just '五'

                Just '6' ->
                    Just '六'

                Just '7' ->
                    Just '七'

                Just '8' ->
                    Just '八'

                Just '9' ->
                    Just '九'

                _ ->
                    Nothing
            , b
            )

        collapse ( a, b ) =
            case ( a, b ) of
                ( Just number, Just digit ) ->
                    [ number, digit ]

                ( Nothing, Just digit ) ->
                    [ digit ]

                ( Just number, Nothing ) ->
                    [ number ]

                ( Nothing, Nothing ) ->
                    []
    in
        arabic
            |> String.toList
            |> List.reverse
            |> List.indexedMap toDigit
            |> List.map convertNumber
            |> List.map collapse
            |> List.foldl (++) []
            |> String.fromList


updateConversion : String -> Model -> Model
updateConversion input model =
    let
        conversion =
            model.conversion

        arabic =
            case Result.toMaybe <| String.toInt input of
                Nothing ->
                    model.conversion.arabic

                result ->
                    Just input

        japanese =
            Maybe.map arabicToJapanese arabic |> Debug.log "japanese"
    in
        { model
            | conversion =
                { conversion
                    | arabic = arabic
                    , japanese = japanese
                }
        }


update : Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        EnterArabic arabic ->
            updateConversion arabic model ! []
