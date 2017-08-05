module Model
    exposing
        ( Model
        , init
        )

import Model.Session
import Model.PageState
import Model.Conversion


type alias Model =
    { session : Model.Session.Session
    , pageState : Model.PageState.PageState
    , conversion : Model.Conversion.Conversion
    }


init : Model
init =
    { session = Model.Session.init
    , pageState = Model.PageState.init
    , conversion = Model.Conversion.init
    }
