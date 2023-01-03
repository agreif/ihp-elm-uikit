module Common exposing
    ( Form(..)
    , HomePageData
    , LoginPageData
    , Model
    , Msg(..)
    , MsgRegisterFormField(..)
    , NavData
    , Page(..)
    , ProfilePageData
    , RegisterFormRec
    , RegisterPageData
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



-- MODEL


type alias Model =
    { key : Nav.Key
    , page : Page
    , form : Form
    }


type Page
    = EmptyPage
    | RegisterPage RegisterPageData
    | LoginPage LoginPageData
    | HomePage HomePageData
    | ProfilePage ProfilePageData
    | ErrorPage String


type Form
    = NoForm
    | RegisterForm RegisterFormRec


type alias RegisterFormRec =
    { login : String, email : String, password : String }



-- MSG


type Msg
    = MsgLinkClicked Browser.UrlRequest
    | MsgUrlChanged Url.Url
    | MsgGotRegisterPageData (Result Http.Error RegisterPageData)
    | MsgChangedRegisterForm MsgRegisterFormField
    | MsgGotLoginPageData (Result Http.Error LoginPageData)
    | MsgGotProfilePageData (Result Http.Error ProfilePageData)
    | MsgGotHomePageData (Result Http.Error HomePageData)


type MsgRegisterFormField
    = MsgFieldLogin String
    | MsgFieldEmail String
    | MsgFieldPassword String



-- DATA - REGISTER


type alias RegisterPageData =
    { title : String
    , nav : NavData
    , register : RegisterBodyData
    }


type alias RegisterBodyData =
    { login : String
    , email : String
    , password : String
    }


registerPageDecoder : J.Decoder RegisterPageData
registerPageDecoder =
    J.map3 RegisterPageData
        (J.field "title" J.string)
        (J.field "nav" navDecoder)
        (J.field "body" (J.field "register" registerBodyDecoder))


registerBodyDecoder : J.Decoder RegisterBodyData
registerBodyDecoder =
    J.map3 RegisterBodyData
        (J.field "login" J.string)
        (J.field "email" J.string)
        (J.field "password" J.string)



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


postForm : String -> Http.Body -> Http.Expect Msg -> Cmd Msg
postForm dataUrl body expect =
    Http.post
        { url = dataUrl
        , body = body
        , expect = expect
        }


fetchData : Url.Url -> Cmd Msg
fetchData pageUrl =
    case pageUrl.path of
        "/register" ->
            Http.get
                { url = "/GetRegisterPageData"
                , expect = Http.expectJson MsgGotRegisterPageData registerPageDecoder
                }

        "/login" ->
            Http.get
                { url = "/GetLoginPageData"
                , expect = Http.expectJson MsgGotLoginPageData loginPageDecoder
                }

        "/profile" ->
            Http.get
                { url = "/GetProfilePageData"
                , expect = Http.expectJson MsgGotProfilePageData profilePageDecoder
                }

        "/home" ->
            Http.get
                { url = "/GetHomePageData"
                , expect = Http.expectJson MsgGotHomePageData homePageDecoder
                }

        _ ->
            Nav.load "/home"
