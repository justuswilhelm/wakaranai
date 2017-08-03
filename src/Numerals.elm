module Numerals
    exposing
        ( arabicToJapanese
        , toArabicDigit
        )

import Dict


japaneseDigits : Dict.Dict Char Char
japaneseDigits =
    Dict.fromList
        [ ( '1', '一' )
        , ( '2', '二' )
        , ( '3', '三' )
        , ( '4', '四' )
        , ( '5', '五' )
        , ( '6', '六' )
        , ( '7', '七' )
        , ( '8', '八' )
        , ( '9', '九' )
        ]


arabicDigits : Dict.Dict Char Int
arabicDigits =
    Dict.fromList
        [ ( '一', 1 )
        , ( '二', 2 )
        , ( '三', 3 )
        , ( '四', 4 )
        , ( '五', 5 )
        , ( '六', 6 )
        , ( '七', 7 )
        , ( '八', 8 )
        , ( '九', 9 )
        ]


toArabicDigit : ( Maybe Char, Maybe Char ) -> Maybe Int
toArabicDigit ( maybeDigit, maybePosition ) =
    let
        digit =
            maybeDigit
                |> Maybe.andThen (\digit -> Dict.get digit arabicDigits)
    in
        maybePosition
            |> Maybe.andThen
                (\position ->
                    case position of
                        '十' ->
                            Just 10

                        '百' ->
                            Just 100

                        '千' ->
                            Just 1000

                        _ ->
                            Nothing
                )
            |> Maybe.map2 (*) digit


toJapaneseDigit : Int -> Char -> ( Maybe Char, Maybe Char )
toJapaneseDigit position number =
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
            case number of
                '0' ->
                    ( Nothing, Nothing )

                '1' ->
                    ( Nothing, Just digit )

                _ ->
                    ( greaterZero, Just digit )
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
            ( a |> Maybe.andThen (\a -> Dict.get a japaneseDigits)
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
            |> List.indexedMap toJapaneseDigit
            |> List.map convertNumber
            |> List.map collapse
            |> List.foldl (++) []
            |> String.fromList
