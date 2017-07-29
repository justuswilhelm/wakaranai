module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events.Extra exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import View.Home
import Model.PageState exposing (Page(..))


viewNav : Page -> Html Msg
viewNav page =
    nav []
        [ a [ href "", onClickPreventDefault (Navigate Home) ] [ text "Home" ]
        ]


viewFooter : Html Msg
viewFooter =
    footer []
        [ p [] [ text "This is the footer" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewNav model.pageState.page
        , case model.pageState.page of
            Home ->
                View.Home.view model
        , viewFooter
        ]
