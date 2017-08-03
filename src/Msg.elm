module Msg exposing (Msg(..))

import Msg.PageState


type Msg
    = PageState Msg.PageState.Msg
