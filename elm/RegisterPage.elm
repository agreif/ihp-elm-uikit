module RegisterPage exposing
    ( registerPageView
    , updateModelRegisterForm
    )

import Browser
import Common exposing (..)
import Html exposing (..)
import Html.Attributes as Attr
import Html.Events as Event
import Json.Decode as J


updateModelRegisterForm : Model -> MsgRegisterFormField -> ( Model, Cmd Msg )
updateModelRegisterForm model field =
    let
        form =
            case model.form of
                RegisterForm rec ->
                    case field of
                        MsgFieldLogin val ->
                            RegisterForm { rec | login = val }

                        MsgFieldEmail val ->
                            RegisterForm { rec | email = val }

                        MsgFieldPassword val ->
                            RegisterForm { rec | password = val }

                _ ->
                    NoForm
    in
    ( { model | form = form }, Cmd.none )


type Field
    = Login
    | Email
    | Password


fieldChanged : Field -> String -> Msg
fieldChanged field val =
    MsgChangedRegisterForm
        (case field of
            Login ->
                MsgFieldLogin val

            Email ->
                MsgFieldEmail val

            Password ->
                MsgFieldPassword val
        )


registerPageView : RegisterPageData -> Browser.Document Msg
registerPageView data =
    let
        register =
            data.register
    in
    pageNoNavView
        data.title
        [ div
            [ Attr.class "uk-flex uk-flex-middle"
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
                                    [ text "Register" ]
                                , form
                                    [ Attr.id "register"
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
                                                , Event.onInput (fieldChanged Login)
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
                                                , Attr.attribute "uk-icon" "icon: user"
                                                ]
                                                []
                                            , input
                                                [ Attr.type_ "text"
                                                , Attr.name "email"
                                                , Attr.class "uk-input uk-form-large"
                                                , Attr.placeholder "Email"
                                                , Event.onInput (fieldChanged Email)
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
                                                , Event.onInput (fieldChanged Password)
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
                                        [ button
                                            [ Attr.attribute "onclick" "{register}"
                                            , Attr.class "uk-button uk-button-primary uk-button-large uk-width-1-1"
                                            ]
                                            [ text "{context.data.translations['Register']}" ]
                                        ]
                                    , div
                                        [ Attr.class "uk-text-small uk-text-center uk-margin-top"
                                        ]
                                        [ a
                                            [ Attr.href "{context.data.pages.register.login_url}"
                                            , Attr.attribute "onclick" "{showLoginPage}"
                                            ]
                                            [ text "Log in" ]
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
