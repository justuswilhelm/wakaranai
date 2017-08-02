module Update.Conversion exposing (update)

import Msg
import Msg.Conversion exposing (..)
import Model exposing (Model)
import Result
import Numerals


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
            Maybe.map Numerals.arabicToJapanese arabic
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
