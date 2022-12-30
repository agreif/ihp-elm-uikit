module Common exposing
    ( HomePageData
    , LoginPageData
    , Msg(..)
    , NavData
    , ProfilePageData
    , fetchData
    , homePageDecoder
    , httpErrorToString
    , navDecoder
    , navView
    , pageNoNavView
    , pageView
    , profilePageDecoder
    )

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as Attr
import Http
import Json.Decode as J
import Url



-- MSG


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotLoginPageData (Result Http.Error LoginPageData)
    | GotProfilePageData (Result Http.Error ProfilePageData)
    | GotHomePageData (Result Http.Error HomePageData)



-- DATA - LOGIN


type alias LoginPageData =
    { title : String
    , nav : NavData
    , login : LoginBodyData
    }


type alias LoginBodyData =
    { login : String
    , password : String
    }


loginPageDecoder : J.Decoder LoginPageData
loginPageDecoder =
    J.map3 LoginPageData
        (J.field "title" J.string)
        (J.field "nav" navDecoder)
        (J.field "body" (J.field "login" loginBodyDecoder))


loginBodyDecoder : J.Decoder LoginBodyData
loginBodyDecoder =
    J.map2 LoginBodyData
        (J.field "login" J.string)
        (J.field "password" J.string)



-- DATA - HOME


type alias HomePageData =
    { title : String
    , nav : NavData
    , home : HomeBodyData
    }


type alias HomeBodyData =
    { text : String
    }


homePageDecoder : J.Decoder HomePageData
homePageDecoder =
    J.map3 HomePageData
        (J.field "title" J.string)
        (J.field "nav" navDecoder)
        (J.field "body" (J.field "home" homeBodyDecoder))


homeBodyDecoder : J.Decoder HomeBodyData
homeBodyDecoder =
    J.map HomeBodyData
        (J.field "text" J.string)



-- DATA - PROFILE


type alias ProfilePageData =
    { title : String
    , nav : NavData
    , profile : ProfileBodyData
    }


type alias ProfileBodyData =
    { text1 : String
    , text2 : String
    }


profilePageDecoder : J.Decoder ProfilePageData
profilePageDecoder =
    J.map3 ProfilePageData
        (J.field "title" J.string)
        (J.field "nav" navDecoder)
        (J.field "body" (J.field "profile" profileBodyDecoder))


profileBodyDecoder : J.Decoder ProfileBodyData
profileBodyDecoder =
    J.map2 ProfileBodyData
        (J.field "text1" J.string)
        (J.field "text2" J.string)



-- NAVIGATION


type alias NavData =
    { items : List NavItem
    }


type alias NavItem =
    { label : String
    , url : String
    , active : Bool
    }


navDecoder : J.Decoder NavData
navDecoder =
    J.map NavData
        (J.list navItemDecoder)


navItemDecoder : J.Decoder NavItem
navItemDecoder =
    J.map3 NavItem
        (J.field "label" J.string)
        (J.field "url" J.string)
        (J.field "active" J.bool)


navView : NavData -> Html Msg
navView data =
    nav
        [ Attr.class "uk-navbar-container uk-margin"
        , Attr.attribute "uk-navbar" ""
        ]
        [ div
            [ Attr.class "uk-navbar-left uk-margin-left"
            ]
            [ a
                [ Attr.class "uk-navbar-item uk-logo"
                , Attr.href "#"
                ]
                [ text "IHP-Elm" ]
            , ul
                [ Attr.class "uk-navbar-nav"
                ]
                (List.map navItemViewLink data.items)
            ]
        , div
            [ Attr.class "uk-navbar-right uk-margin-right"
            ]
            []
        ]


navItemViewLink : NavItem -> Html Msg
navItemViewLink item =
    let
        activeClass =
            if item.active then
                "uk-active"

            else
                ""
    in
    li
        [ Attr.class activeClass
        ]
        [ a
            [ Attr.href item.url
            ]
            [ text item.label ]
        ]



-- PAGE VIEW


pageView : String -> NavData -> List (Html Msg) -> Browser.Document Msg
pageView title nav bodyElems =
    { title = title
    , body =
        [ div [ Attr.class "uk-container uk-margin-left" ]
            ([ navView nav ]
                ++ bodyElems
            )
        ]
    }


pageNoNavView : String -> List (Html Msg) -> Browser.Document Msg
pageNoNavView title bodyElems =
    { title = title
    , body =
        [ div [ Attr.class "uk-container uk-margin-left" ]
            bodyElems
        ]
    }



-- HELPERS


httpErrorToString : Http.Error -> String
httpErrorToString error =
    case error of
        Http.BadUrl url ->
            "The URL " ++ url ++ " was invalid"

        Http.Timeout ->
            "Unable to reach the server, try again"

        Http.NetworkError ->
            "Unable to reach the server, check your network connection"

        Http.BadStatus 500 ->
            "The server had a problem, try again later"

        Http.BadStatus 400 ->
            "Verify your information and try again"

        Http.BadStatus _ ->
            "Unknown error"

        Http.BadBody errorMessage ->
            errorMessage


fetchData : Url.Url -> Cmd Msg
fetchData pageUrl =
    case pageUrl.path of
        "/login" ->
            Http.get
                { url = "/GetLoginPageData"
                , expect = Http.expectJson GotLoginPageData loginPageDecoder
                }

        "/profile" ->
            Http.get
                { url = "/GetProfilePageData"
                , expect = Http.expectJson GotProfilePageData profilePageDecoder
                }

        "/home" ->
            Http.get
                { url = "/GetHomePageData"
                , expect = Http.expectJson GotHomePageData homePageDecoder
                }

        _ ->
            Nav.load "/home"
