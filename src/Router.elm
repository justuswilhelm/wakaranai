module Router
    exposing
        ( route
        , routeMsg
        , routeInit
        , reverse
        , reverseHref
        )

import Html
import Html.Attributes
import UrlParser exposing (Parser, (</>), s, int, string, map, oneOf, parseHash)
import Msg
import Msg.PageState
import Navigation
import Model.PageState exposing (Page(..))
import Model


route : Parser (Page -> a) a
route =
    oneOf
        [ map HomeP (s "home")
        , map AboutP (s "about")
        ]


routeMsg : Navigation.Location -> Msg.Msg
routeMsg loc =
    parseHash route loc
        |> Maybe.withDefault HomeP
        |> Msg.PageState.Navigate
        |> Msg.PageState


routeInit : Navigation.Location -> Model.Model
routeInit loc =
    Model.init <| Maybe.withDefault HomeP <| parseHash route loc


reverse : Page -> String
reverse page =
    ((++) "#") <|
        case page of
            HomeP ->
                "home"

            AboutP ->
                "about"


reverseHref : Page -> Html.Attribute Msg.Msg
reverseHref =
    Html.Attributes.href << reverse
