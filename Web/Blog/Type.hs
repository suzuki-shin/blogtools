module Web.Blog.Type (
    BlogType(..)
  , Blog
  , module X
) where

import Network.URI as X

data BlogType = HatenaDiary | HatenaBlog | Jugem deriving Show
type Blog = (BlogType, URI)
