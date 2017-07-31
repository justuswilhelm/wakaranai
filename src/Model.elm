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


init : Model.PageState.Page -> Model
init page =
    { session = Model.Session.init
    , pageState = Model.PageState.init page
    , conversion = Model.Conversion.init
    }
