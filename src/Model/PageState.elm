module Model.PageState
    exposing
        ( Page(..)
        , PageState
        , init
        , parseHash
        )


type Page
    = Home


type alias PageState =
    { page : Page }


init : Page -> PageState
init page =
    { page = page }



--- Decoders


parseHash : String -> Page
parseHash fragment =
    case fragment of
        "home" ->
            Home

        _ ->
            Home
