module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)
import Numerals


suite : Test
suite =
    describe "Numerals"
        [ describe "arabicToJapanese" <|
            let
                expect a b =
                    test a <| \_ -> Expect.equal b (Numerals.arabicToJapanese a)
            in
                [ expect "17" "十七"
                , expect "151" "百五十一"
                , expect "302" "三百二"
                , expect "469" "四百六十九"
                , expect "2025" "二千二十五"
                , expect "9836703" "九百八十三万六千七百三"
                , expect "2036521801" "二十億三千六百五十二万千八百一"
                ]
        , describe "toArabicDigit" <|
            let
                expect a b =
                    test "Conversion" <| \_ -> Expect.equal b (Numerals.toArabicDigit a)
            in
                [ expect ( Just '五', Just '十' ) <| Just 50
                ]
        ]
