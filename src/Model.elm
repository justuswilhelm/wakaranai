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


init : Model.PageState.Page -> Model
init page =
    { session = Model.Session.init
    , pageState = Model.PageState.init page
    }
