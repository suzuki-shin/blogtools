module Web.Blog.Tools (
  entryURIsOf
) where

import Web.Blog.Type
import qualified Web.Blog.Hatena.Diary as HD (entryURIsOf)

entryURIsOf :: (BlogType, URI) -> [URI]
entryURIsOf (HatenaDiary, uri) = HD.entryURIsOf uri
