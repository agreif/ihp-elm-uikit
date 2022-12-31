module Application.Helper.Controller where

import IHP.ControllerPrelude

-- Here you can add functions which are available in all your controllers

-- NAV

data ActiveNavItem
  = ActiveRegisterPage
  | ActiveLoginPage
  | ActiveHomePage
  | ActiveProfilePage
  deriving Eq

navData :: ActiveNavItem -> [NavItemData]
navData activeNavItem =
  [ NavItemData
    { label = "Register"
    , url = "/register"
    , active = activeNavItem == ActiveRegisterPage
    }
  , NavItemData
    { label = "Login"
    , url = "/login"
    , active = activeNavItem == ActiveLoginPage
    }
  , NavItemData
    { label = "Home"
    , url = "/home"
    , active = activeNavItem == ActiveHomePage
    }
  , NavItemData
    { label = "Profile"
    , url = "/profile"
    , active = activeNavItem == ActiveProfilePage
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
  { register :: Maybe RegisterBodyData
  , login :: Maybe LoginBodyData
  , home :: Maybe HomeBodyData
  , profile :: Maybe ProfileBodyData
  }

instance ToJSON BodyData where
  toJSON BodyData{..} =
    object [ "register" .= register
           , "login" .= login
           , "home" .= home
           , "profile" .= profile
           ]

-- REGISTER DATA

data RegisterBodyData = RegisterBodyData
  { login :: Text
  , email :: Text
  , password :: Text
  }

instance ToJSON RegisterBodyData where
  toJSON RegisterBodyData{..} =
    object [ "login" .= login
           , "email" .= email
           , "password" .= password
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
