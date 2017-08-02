module Model.Conversion exposing (Conversion, init)


type alias Conversion =
    { arabic : Maybe String
    , japanese : Maybe String
    }


init : Conversion
init =
    { arabic = Nothing
    , japanese = Nothing
    }
