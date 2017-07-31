module Update.Conversion exposing (update)

import Dict
import Msg
import Msg.Conversion exposing (..)
import Model exposing (Model)
import Result
import List.Extra


digits : Int -> List Int
digits number =
    let
        digit =
            number % 10

        rest =
            number // 10
    in
        if number > 9 then
            digits rest ++ [ digit ]
        else
            [ digit ]


groups : List a -> List (List a)
groups lst =
    List.map List.reverse <|
        List.Extra.greedyGroupsOf 4 <|
            List.reverse lst


japaneseGrouping : List (Maybe Char)
japaneseGrouping =
    [ Nothing, Just '万', Just '億' ]


japaneseDigits : List (Maybe Char)
japaneseDigits =
    [ Nothing, Just '十', Just '百', Just '千' ]


appendMaybe : Maybe a -> List a -> List a
appendMaybe maybe list =
    case maybe of
        Just a ->
            list ++ [ a ]

        Nothing ->
            list


pairMaybe : Maybe a -> a -> List a
pairMaybe maybe b =
    case maybe of
        Just a ->
            [ b, a ]

        Nothing ->
            [ b ]


appendDigits : List Char -> List Char
appendDigits list =
    list
        |> List.reverse
        |> List.map2 pairMaybe japaneseDigits
        |> List.foldl (++) []


toJapaneseDigits : Dict.Dict Int Char
toJapaneseDigits =
    Dict.fromList
        [ ( 0, '○' )
        , ( 1, '一' )
        , ( 2, '二' )
        , ( 3, '三' )
        , ( 4, '四' )
        , ( 5, '五' )
        , ( 6, '六' )
        , ( 7, '七' )
        , ( 8, '八' )
        , ( 9, '九' )
        ]


arabicToJapanese : Int -> String
arabicToJapanese arabic =
    digits arabic
        |> List.map (\d -> Dict.get d toJapaneseDigits |> Maybe.withDefault '○')
        |> groups
        |> List.map appendDigits
        |> List.map2 appendMaybe japaneseGrouping
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
                    result

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
