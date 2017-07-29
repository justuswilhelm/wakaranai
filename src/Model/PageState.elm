module Model.PageState exposing (Page(..), PageState, init)


type Page
    = Home


type alias PageState =
    { page : Page }


init : PageState
init =
    { page = Home }
