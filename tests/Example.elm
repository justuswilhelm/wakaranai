module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)
import Numerals


expectArabicToJapanese a b =
    test a <| \_ -> Expect.equal b (Numerals.arabicToJapanese a)


suite : Test
suite =
    describe "arabicToJapanese"
        [ expectArabicToJapanese "17" "十七"
        , expectArabicToJapanese "151" "百五十一"
        , expectArabicToJapanese "302" "三百二"
        , expectArabicToJapanese "469" "四百六十九"
        , expectArabicToJapanese "2025" "二千二十五"
        , expectArabicToJapanese "9836703" "九百八十三万六千七百三"
        , expectArabicToJapanese "2036521801" "二十億三千六百五十二万千八百一"
        ]
