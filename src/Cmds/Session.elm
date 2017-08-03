module Cmds.Session exposing (..)

import Task
import Time
import Msg
import Msg.Session


getTime : Cmd Msg.Msg
getTime =
    Time.now
        |> Task.perform (Msg.Session << Msg.Session.GetTime)
