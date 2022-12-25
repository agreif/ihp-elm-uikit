module Web.Routes where

import IHP.RouterPrelude
import Generated.Types
import Web.Types

instance AutoRoute HomePageController
instance AutoRoute ProfilePageController

-- Generator Marker
instance AutoRoute StaticController
