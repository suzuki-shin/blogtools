module Web.Blog.Type (
    BlogType(..)
  , module X
) where

import Network.URI as X

data BlogType = HatenaDiary | HatenaBlog | Jugem deriving Show
