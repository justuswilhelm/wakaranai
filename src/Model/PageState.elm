module Model.PageState
    exposing
        ( Page(..)
        , PageState
        , init
        )


type Page
    = Home


type alias PageState =
    { page : Page }


init : Page -> PageState
init page =
    { page = page }
