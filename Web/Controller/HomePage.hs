module Web.Controller.HomePage where

import Web.Controller.Prelude

instance Controller HomePageController where
  action GetHomePageDataAction = do
    renderJson $ toJSON theData

theData :: PageData
theData = PageData
  { title = "Home Page"
  , nav = navData ActiveHomePage
  , page = PagesData
    { home = Just $ GetHomePageData
      { body = "Home Page Body..."
      }
    , profile = Nothing
    }
  }


