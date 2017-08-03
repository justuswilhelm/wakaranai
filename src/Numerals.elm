module Numerals exposing (arabicToJapanese)

import Dict


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
        digits =
            Dict.fromList
                [ ( '0', '○' )
                , ( '1', '一' )
                , ( '2', '二' )
                , ( '3', '三' )
                , ( '4', '四' )
                , ( '5', '五' )
                , ( '6', '六' )
                , ( '7', '七' )
                , ( '8', '八' )
                , ( '9', '九' )
                ]

        convertNumber ( a, b ) =
            ( a |> Maybe.andThen (\a -> Dict.get a digits)
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
