module Web.Controller.ProfilePage where

import Web.Controller.Prelude

instance Controller ProfilePageController where
  action GetProfilePageDataAction = do
    renderJson $ toJSON theData

theData :: PageData
theData = PageData
  { title = "Profile Page"
  , nav = navData ActiveProfilePage
  , body = BodyData
    { register = Nothing
    , login = Nothing
    , home = Nothing
    , profile = Just $ ProfileBodyData
      { text1 = "foo foo foo"
      , text2 = "bar bar"
      }
    }
  }


