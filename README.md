# ihp-elm-uikit
Proof-of-Concept project with
- IHP
- Elm
- UIKit

## IHP
- delivers only one HTML site (at the very beginning) that contains the Elm application
- dirreferent manual URL requests return the with the same HTML page but the Elm app then loads the corresponding JSON data
- it is maily an API Server that delivers JSON documents

## Elm
Uses a Browser.application type as a SPA (Single Page Application)
with
- changing pages/navigation
- changing URLs

Each click (either in the navigation or somewhere else) results in a JSON data reload that results in the right DOM manipulation

## UIKit
more infos, see [https://getuikit.com/](https://getuikit.com)
