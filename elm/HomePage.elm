module HomePage exposing (homePageView)

import Browser
import Common exposing (..)
import Html exposing (..)
import Html.Attributes as Attr
import Json.Decode as J


homePageView : HomePageData -> Browser.Document Msg
homePageView data =
    let
        home =
            data.home
    in
    pageView
        data.title
        data.nav
        [ h2 []
            [ text data.title ]
        , b [] [ text "text: " ]
        , span [] [ text home.text ]
        ]
