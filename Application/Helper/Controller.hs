module Application.Helper.Controller where

import IHP.ControllerPrelude

-- Here you can add functions which are available in all your controllers


-- NAV

data ActiveNavItem =
  ActiveHomePage
  | ActiveProfilePage
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
  ]



-- PAGE DATA

data PageData = PageData
  { title :: Text
  , nav :: [NavItemData]
  , page :: PagesData
  }

instance ToJSON PageData where
  toJSON (PageData title nav page) =
    object ["title" .= title, "nav" .= nav, "page" .= page]

data NavItemData = NavItemData
  { label :: Text
  , url :: Text
  , active :: Bool
  }

instance ToJSON NavItemData where
  toJSON (NavItemData label url active) =
    object ["label" .= label, "url" .= url, "active" .= active]

data PagesData = PagesData
  { home :: Maybe GetHomePageData
  , profile :: Maybe GetProfilePageData
  }

instance ToJSON PagesData where
  toJSON (PagesData home profile) =
    object ["home" .= home, "profile" .= profile]

data GetHomePageData = GetHomePageData
  { body :: Text
  }

instance ToJSON GetHomePageData where
  toJSON (GetHomePageData body) =
    object ["body" .= body]

data GetProfilePageData = GetProfilePageData
  { text1 :: Text
  , text2 :: Text
  }

instance ToJSON GetProfilePageData where
  toJSON (GetProfilePageData text1 text2) =
    object ["text1" .= text1, "text2" .= text2]
