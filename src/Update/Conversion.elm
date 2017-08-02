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

        mapZero digit =
            ( greaterZero
            , Just digit
            )

        mapSignificant digit =
            ( greaterOne
            , Just digit
            )
    in
        case position % 4 of
            0 ->
                case position // 4 of
                    0 ->
                        ( greaterZero
                        , Nothing
                        )

                    1 ->
                        mapZero '万'

                    2 ->
                        mapZero '億'

                    3 ->
                        mapZero '兆'

                    4 ->
                        mapZero '京'

                    _ ->
                        ( Nothing, Nothing )

            1 ->
                mapSignificant '十'

            2 ->
                mapSignificant '百'

            3 ->
                mapSignificant '千'

            _ ->
                ( Nothing, Nothing )


arabicToJapanese : String -> String
arabicToJapanese arabic =
    let
        convertNumber ( a, b ) =
            ( Maybe.map
                (\a ->
                    case a of
                        '0' ->
                            '○'

                        '1' ->
                            '一'

                        '2' ->
                            '二'

                        '3' ->
                            '三'

                        '4' ->
                            '四'

                        '5' ->
                            '五'

                        '6' ->
                            '六'

                        '7' ->
                            '七'

                        '8' ->
                            '八'

                        '9' ->
                            '九'

                        _ ->
                            '?'
                )
                a
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
            case input of
                "" ->
                    Nothing

                input ->
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
