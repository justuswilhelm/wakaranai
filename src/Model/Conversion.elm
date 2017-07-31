module Model.Conversion exposing (Conversion, init)


type alias Conversion =
    { arabic : Maybe Int
    , japanese : Maybe String
    }


init : Conversion
init =
    { arabic = Nothing
    , japanese = Nothing
    }
