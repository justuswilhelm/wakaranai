module Msg exposing (Msg(..))

import Msg.PageState
import Msg.Session


type Msg
    = PageState Msg.PageState.Msg
    | Session Msg.Session.Msg
