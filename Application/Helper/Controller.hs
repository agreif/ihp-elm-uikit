module Application.Helper.Controller where

import IHP.ControllerPrelude

-- Here you can add functions which are available in all your controllers

-- NAV

data ActiveNavItem
  = ActiveHomePage
  | ActiveProfilePage
  | ActiveLoginPage
  deriving Eq

navData :: ActiveNavItem -> [NavItemData]
navData activeNavItem =
  [ NavItemData
    { label = "Home"
    , url = "/home"
    , active = activeNavItem == ActiveHomePage
    }
  , NavItemData
    { label = "Profile"
    , url = "/profile"
    , active = activeNavItem == ActiveProfilePage
    }
  , NavItemData
    { label = "Login"
    , url = "/login"
    , active = activeNavItem == ActiveLoginPage
    }
  ]

-- PAGE DATA

data PageData = PageData
  { title :: Text
  , nav :: [NavItemData]
  , body :: BodyData
  }

instance ToJSON PageData where
  toJSON PageData{..} =
    object [ "title" .= title
           , "nav" .= nav
           , "body" .= body
           ]

data NavItemData = NavItemData
  { label :: Text
  , url :: Text
  , active :: Bool
  }

instance ToJSON NavItemData where
  toJSON NavItemData{..} =
    object [ "label" .= label
           , "url" .= url
           , "active" .= active
           ]

data BodyData = BodyData
  { home :: Maybe HomeBodyData
  , profile :: Maybe ProfileBodyData
  , login :: Maybe LoginBodyData
  }

instance ToJSON BodyData where
  toJSON BodyData{..} =
    object [ "home" .= home
           , "profile" .= profile
           , "login" .= login
           ]

-- LOGIN DATA

data LoginBodyData = LoginBodyData
  { login :: Text
  , password :: Text
  }

instance ToJSON LoginBodyData where
  toJSON LoginBodyData{..} =
    object [ "login" .= login
           , "password" .= password
           ]

-- HOME DATA

data HomeBodyData = HomeBodyData
  { text :: Text
  }

instance ToJSON HomeBodyData where
  toJSON HomeBodyData{..} =
    object ["text" .= text
           ]

-- PROFILE DATA

data ProfileBodyData = ProfileBodyData
  { text1 :: Text
  , text2 :: Text
  }

instance ToJSON ProfileBodyData where
  toJSON ProfileBodyData{..} =
    object [ "text1" .= text1
           , "text2" .= text2
           ]
