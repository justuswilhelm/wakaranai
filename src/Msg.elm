module Msg exposing (Msg(..))

import Msg.Conversion
import Msg.PageState


type Msg
    = PageState Msg.PageState.Msg
    | Conversion Msg.Conversion.Msg
