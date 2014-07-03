module Web.Blog.Tools (
  entryURLsOf
) where

import Web.Blog.Type
import Web.Readability.Api
import Network.URI
import qualified Web.Blog.Hatena.Diary as HD (entryURLsOf)
import qualified Web.Blog.Hatena.Blog as HB (entryURLsOf)
import Data.Maybe (fromJust)

-- | entryURIsOf
-- > entryURIsOf (HatenaDiary, "http://d.hatena.ne.jp/suzuki-shin/")
-- [http://d.hatena.ne.jp/suzuki-shin/2014/06/02/hogehoge,http://d.hatena.ne.jp/suzuki-shin/2014/06/01/fugafuga]
entryURLsOf :: (BlogType, String) -> IO [String]
entryURLsOf (HatenaDiary, url) = HD.entryURLsOf url

