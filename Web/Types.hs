module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data LoginPageController = GetLoginPageDataAction deriving (Eq, Show, Data)
data HomePageController = GetHomePageDataAction deriving (Eq, Show, Data)
data ProfilePageController = GetProfilePageDataAction deriving (Eq, Show, Data)
