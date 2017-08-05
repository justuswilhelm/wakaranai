module Model.PageState
    exposing
        ( Page(..)
        , PageState
        , init
        )


type Page
    = HomeP
    | AboutP


type alias PageState =
    { page : Page }


init : PageState
init =
    { page = HomeP }
