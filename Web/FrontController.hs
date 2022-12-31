module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Static

import Web.Controller.RegisterPage
import Web.Controller.LoginPage
import Web.Controller.HomePage
import Web.Controller.ProfilePage

instance FrontController WebApplication where
    controllers =
        [ parseRoute @RegisterPageController
        , parseRoute @LoginPageController
        , parseRoute @HomePageController
        , parseRoute @ProfilePageController
        , catchAll WelcomeAction
        -- Generator Marker
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
