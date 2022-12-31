module Web.Controller.RegisterPage where

import Web.Controller.Prelude

instance Controller RegisterPageController where
  action GetRegisterPageDataAction = do
    renderJson $ toJSON theData

theData :: PageData
theData = PageData
  { title = "Register Page"
  , nav = navData ActiveRegisterPage
  , body = BodyData
    { home = Nothing
    , profile = Nothing
    , register = Just $ RegisterBodyData
      { login = ""
      , email = ""
      , password = ""
      }
    , login = Nothing
    }
  }


