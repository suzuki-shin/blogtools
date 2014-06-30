module Web.Blog.Hatena.Diary (
  entryURIsOf
) where

import Network.URI
import Data.Maybe (fromJust)

-- | entryURIsOf
-- >>> entryURIsOf (HatenaDiary, fromJust $ parseURI "http://d.hatena.ne.jp/suzuki-shin/")
-- [http://d.hatena.ne.jp/suzuki-shin/2014/06/02/hogehoge,http://d.hatena.ne.jp/suzuki-shin/2014/06/01/fugafuga]
entryURIsOf :: URI -> IO [URI]
entryURIsOf baseUri = return [(fromJust $ parseURI "http://d.hatena.ne.jp/suzuki-shin/2014/06/02/hogehoge"),
                               (fromJust $ parseURI "http://d.hatena.ne.jp/suzuki-shin/2014/06/01/fugafuga")]

-- archivePageOf :: UserName -> Int -> IO String
-- archivePageOf user fromNum = openURL $ baseUrl ++ user ++ "/archive?of=" ++ show fromNum
