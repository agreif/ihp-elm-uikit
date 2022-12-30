module Web.Controller.LoginPage where

import Web.Controller.Prelude

instance Controller LoginPageController where
  action GetLoginPageDataAction = do
    renderJson $ toJSON theData

theData :: PageData
theData = PageData
  { title = "Login Page"
  , nav = navData ActiveLoginPage
  , body = BodyData
    { home = Nothing
    , profile = Nothing
    , login = Just $ LoginBodyData
      { login = ""
      , password = ""
      }
    }
  }


