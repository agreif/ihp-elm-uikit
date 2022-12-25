module LoginPage exposing (loginPageView)

import Browser
import Common exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as J


loginPageView : LoginPageData -> Browser.Document Msg
loginPageView data =
    let
        login =
            data.login
    in
    pageView
        data.title
        data.nav
        [ h2 []
            [ text data.title ]
        ]
