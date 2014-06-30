module Web.Blog.Tools (
  entryURIsOf
) where

import Web.Blog.Type
import Network.URI
import qualified Web.Blog.Hatena.Diary as HD (entryURIsOf)
import Data.Maybe (fromJust)

-- | entryURIsOf
-- >>> entryURIsOf (HatenaDiary, fromJust $ parseURI "http://d.hatena.ne.jp/suzuki-shin/")
-- [http://d.hatena.ne.jp/suzuki-shin/2014/06/02/hogehoge,http://d.hatena.ne.jp/suzuki-shin/2014/06/01/fugafuga]
entryURIsOf :: (BlogType, URI) -> IO [URI]
entryURIsOf (HatenaDiary, uri) = HD.entryURIsOf uri

