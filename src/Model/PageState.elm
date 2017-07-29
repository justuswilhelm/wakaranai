module Model.PageState exposing (Page(..), PageState, init)


type Page
    = Home


type alias PageState =
    { currentPage : Page }


init : PageState
init =
    { currentPage = Home }
