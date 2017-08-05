# Elm Template

## Quickstart

```
npm install -g elm elm-live elm-test
make live
```

## Adding a View

Let's assume your view name is "Example", then make the following adjustments:

```
-- src/Model/PageState.elm
-- ...
type Page
    = HomeP
    | AboutP
    | ExampleP -- << Add this
```

```
-- src/Router.elm
-- ...
route : Parser (Page -> a) a
route =
    oneOf
        [ map HomeP (s "home")
        , map AboutP (s "about")
        , map ExampleP (s "view") -- << Add this and missing attributes
        ]
```

```
-- src/View/Example.elm
module View.Example exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (..)

-- << Your view code here
view : Model -> List (Html Msg)
view model =
    [ div [] [] ]
```

```
-- src/View.elm
-- ...
import View.Example -- << Add the import
-- ...
view : Model -> Html Msg
view model =
    div []
        [ viewNav model.pageState.page
        , section [ class "section" ] <|
            case model.pageState.page of
                HomeP ->
                    View.Home.view model

                AboutP ->
                    View.About.view model

                ExampleP ->
                    View.Example.view model -- << Add here
        , viewFooter
        ]
```

## Adding a Model

If you would like to add a model, first create the model file. We are going
to call our example model `Example`. Therefore, we edit the file
`src/Model/Example.elm`:

```
-- src/Model/Example.elm
module Model.Example exposing (Example, init)


type alias Example =
    { nothing : Maybe String
    }


init : Example
init =
    { nothing = Nothing
    }
```

Then, we add the model to the global model in `src/Model.elm`.

```
-- src/Model.elm
import Model.Session
import Model.PageState
import Model.Example -- << Add this

type alias Model =
    { session : Model.Session.Session
    , pageState : Model.PageState.PageState
    , view : Model.Example.Example -- << Add this
    }


init : Model.PageState.Page -> Model
init page =
    { session = Model.Session.init
    , pageState = Model.PageState.init page
    , view = Model.Example.init -- << Add this
    }
```

## Adding Operations

For simple messages, first create `src/Msg/Example.elm`

```
-- src/Msg/Example.elm
module Msg.Example exposing (Msg(..))


type Msg
    = NoOp -- << Add your messages
```

and then edit `src/Msg.elm`

```
-- src/Msg.elm
import Msg.PageState
import Msg.Session
import Msg.Example -- << Add this


type Msg
    = PageState Msg.PageState.Msg
    | Session Msg.Session.Msg
    | Example Msg.Example.Msg -- << Add this
```

### Adding asynchronous Operations

First, create `src/Update/Example.elm`.

```
-- src/Update/Example.elm
module Update.Example exposing (update)

import Msg
import Msg.Example exposing (..)
import Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    let
        example =
            model.example
    in
        case msg of
            NoOp ->
                let -- << Example update
                    model_ =
                        { model | example = example }
                in
                    model_ ! []
```

And add the right update operations to `src/Update.elm`

```
-- src/Update.elm
-- ...
update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg =
    case msg of
        Msg.PageState msg ->
            Update.PageState.update msg

        Msg.Session msg ->
            Update.Session.update msg

        Msg.Example msg -> -- << Add here
            Update.Example.update msg -- << And here
```

## Naming Scheme

- Route names shall be appended with a `P`. A route called `Session` will
therefore be named `SessionP`.

## Import formatting

Keep Library, Third-Party and First-Party imports separate.

Good:

```
import Html exposing (..)
import Html.Attributes exposing (..)


--

import Model exposing (Model)
```

Not good:
```
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
```

## Testing

Run

```
elm-test
```

## Further Reading

- Elm Live: https://github.com/tomekwi/elm-live
- Elm Test: http://package.elm-lang.org/packages/elm-community/elm-test/latest
