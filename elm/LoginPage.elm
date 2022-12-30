module LoginPage exposing (loginPageView)

import Browser
import Common exposing (..)
import Html exposing (..)
import Html.Attributes as Attr
import Json.Decode as J


loginPageView : LoginPageData -> Browser.Document Msg
loginPageView data =
    let
        login =
            data.login
    in
    pageNoNavView
        data.title
        [ div
            [ Attr.class "uk-flex uk-flex-middle uk-margin-top"
            ]
            [ div
                [ Attr.class "uk-width-1-1"
                ]
                [ div
                    [ Attr.class "uk-container"
                    ]
                    [ div
                        [ Attr.class "uk-grid-margin uk-grid uk-grid-stack"
                        , Attr.attribute "uk-grid" ""
                        ]
                        [ div
                            [ Attr.class "uk-width-1-1@m"
                            ]
                            [ div
                                [ Attr.class "uk-margin uk-width-large uk-margin-auto uk-card uk-card-default uk-card-body uk-box-shadow-large"
                                ]
                                [ h3
                                    [ Attr.class "uk-card-title uk-text-center"
                                    ]
                                    [ text "Login" ]
                                , form
                                    [ Attr.id "login"
                                    ]
                                    [ div
                                        [ Attr.class "uk-margin"
                                        ]
                                        [ div
                                            [ Attr.class "uk-inline uk-width-1-1"
                                            ]
                                            [ span
                                                [ Attr.class "uk-form-icon"
                                                , Attr.attribute "uk-icon" "icon: user"
                                                ]
                                                []
                                            , input
                                                [ Attr.type_ "text"
                                                , Attr.name "login"
                                                , Attr.class "uk-input uk-form-large"
                                                , Attr.placeholder "Login"
                                                ]
                                                []
                                            ]
                                        , ul
                                            [ Attr.class "uk-list uk-list-collapse uk-margin-remove-top"
                                            ]
                                            [ li
                                                []
                                                [ span
                                                    [ Attr.class "uk-text-danger"
                                                    ]
                                                    [ text "" ]
                                                ]
                                            ]
                                        ]
                                    , div
                                        [ Attr.class "uk-margin"
                                        ]
                                        [ div
                                            [ Attr.class "uk-inline uk-width-1-1"
                                            ]
                                            [ span
                                                [ Attr.class "uk-form-icon"
                                                , Attr.attribute "uk-icon" "icon: lock"
                                                ]
                                                []
                                            , input
                                                [ Attr.type_ "password"
                                                , Attr.name "password"
                                                , Attr.class "uk-input uk-form-large"
                                                , Attr.placeholder "Password"
                                                ]
                                                []
                                            ]
                                        , ul
                                            [ Attr.class "uk-list uk-list-collapse uk-margin-remove-top"
                                            ]
                                            [ li
                                                []
                                                [ span
                                                    [ Attr.class "uk-text-danger"
                                                    ]
                                                    [ text "" ]
                                                ]
                                            ]
                                        ]
                                    , ul
                                        [ Attr.class "uk-list uk-list-collapse"
                                        ]
                                        [ li
                                            []
                                            [ span
                                                [ Attr.class "uk-text-danger"
                                                ]
                                                [ text "" ]
                                            ]
                                        ]
                                    , div
                                        [ Attr.class "uk-margin"
                                        ]
                                        [ button
                                            [ Attr.attribute "onclick" "{login}"
                                            , Attr.class "uk-button uk-button-primary uk-button-large uk-width-1-1"
                                            ]
                                            [ text "Login" ]
                                        ]
                                    , div
                                        [ Attr.class "uk-text-small uk-text-center uk-margin-top"
                                        ]
                                        [ a
                                            [ Attr.href "{context.data.pages.login.register_url}"
                                            , Attr.attribute "onclick" "{showRegisterPage}"
                                            ]
                                            [ text "{context.data.translations['Register']}" ]
                                        , text "|"
                                        , a
                                            [ Attr.href "#"
                                            ]
                                            [ text "{context.data.translations['Forgot your password']}" ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
