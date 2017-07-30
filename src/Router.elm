module Router
    exposing
        ( route
        , routeMsg
        , routeInit
        )

import UrlParser exposing (Parser, (</>), s, int, string, map, oneOf, parseHash)
import Msg
import Navigation
import Model.PageState exposing (Page(..))
import Model


route : Parser (Page -> a) a
route =
    oneOf
        [ map Home (s "home")
        ]


routeMsg : Navigation.Location -> Msg.Msg
routeMsg loc =
    Msg.Navigate <| Maybe.withDefault Home <| parseHash route loc


routeInit : Navigation.Location -> Model.Model
routeInit loc =
    Model.init <| Maybe.withDefault Home <| parseHash route loc
