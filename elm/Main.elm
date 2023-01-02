module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Common exposing (..)
import ErrorPage exposing (..)
import HomePage exposing (..)
import Http
import Json.Decode as J
import LoginPage exposing (..)
import ProfilePage exposing (..)
import RegisterPage exposing (..)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = MsgUrlChanged
        , onUrlRequest = MsgLinkClicked
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags pageUrl key =
    ( Model key EmptyPage NoForm
    , Nav.pushUrl key pageUrl.path
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgLinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal pageUrl ->
                    ( model, Nav.pushUrl model.key (Url.toString pageUrl) )

                Browser.External href ->
                    ( model, Nav.load href )

        MsgUrlChanged pageUrl ->
            ( model, fetchData pageUrl )

        MsgGotRegisterPageData result ->
            case result of
                Ok data ->
                    ( { model
                        | page = RegisterPage data
                        , form = RegisterForm { login = "", email = "", password = "" }
                      }
                    , Cmd.none
                    )

                Err message ->
                    error model message

        MsgChangedRegisterForm field ->
            updateModelRegisterForm model field

        MsgGotLoginPageData result ->
            case result of
                Ok data ->
                    ( { model | page = LoginPage data }, Cmd.none )

                Err message ->
                    error model message

        MsgGotProfilePageData result ->
            case result of
                Ok data ->
                    ( { model | page = ProfilePage data }, Cmd.none )

                Err message ->
                    error model message

        MsgGotHomePageData result ->
            case result of
                Ok data ->
                    ( { model | page = HomePage data }, Cmd.none )

                Err message ->
                    error model message


error : Model -> Http.Error -> ( Model, Cmd Msg )
error model httperror =
    ( { model | page = ErrorPage ("http error: " ++ httpErrorToString httperror) }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.page of
        RegisterPage data ->
            registerPageView data

        LoginPage data ->
            loginPageView data

        HomePage data ->
            homePageView data

        ProfilePage data ->
            profilePageView data

        EmptyPage ->
            { title = "", body = [] }

        ErrorPage message ->
            errorPageView message
