module Model
    exposing
        ( Model
        , init
        )

import Model.Session
import Model.PageState


type alias Model =
    { session : Model.Session.Session
    , pageState : Model.PageState.PageState
    }


init : Model
init =
    { session = Model.Session.init
    , pageState = Model.PageState.init
    }
