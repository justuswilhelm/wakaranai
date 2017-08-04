module Model.Session exposing (Session, init)

import Time


type alias Session =
    { time : Maybe Time.Time
    }


init : Session
init =
    { time = Nothing
    }
