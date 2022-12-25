module Web.Controller.ProfilePage where

import Web.Controller.Prelude

instance Controller ProfilePageController where
  action GetProfilePageDataAction = do
    renderJson $ toJSON theData

theData :: PageData
theData = PageData
  { title = "Profile Page"
  , nav = navData ActiveProfilePage
  , page = PagesData
    { home = Nothing
    , profile = Just $ GetProfilePageData
      { text1 = "foo foo foo"
      , text2 = "bar bar"
      }
    }
  }


