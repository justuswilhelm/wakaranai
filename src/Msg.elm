module Msg exposing (Msg(..))

import Msg.Conversion
import Msg.PageState
import Msg.Session


type Msg
    = PageState Msg.PageState.Msg
    | Conversion Msg.Conversion.Msg
    | Session Msg.Session.Msg
