module Web.Blog.Type (
    BlogType(..)
  , Url
) where

data BlogType = HatenaDiary | HatenaBlog | Jugem deriving Show
type Url = String
