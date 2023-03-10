module Web.Controller.HomePage where

import Web.Controller.Prelude

instance Controller HomePageController where
  action GetHomePageDataAction = do
    renderJson $ toJSON theData

theData :: PageData
theData = PageData
  { title = "Home Page"
  , nav = navData ActiveHomePage
  , body = BodyData
    { register = Nothing
    , login = Nothing
    , home = Just $ HomeBodyData
      { text = "Home Page Body..."
      }
    , profile = Nothing
    }
  }


