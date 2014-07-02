module Web.Blog.Hatena.Diary (
   entryURIsOf
 , archiveURLs
 , entryURLsFromArchiveURL
) where

import Network.URI
import Data.Maybe (fromJust)
import Text.XML.HXT.Core
import Text.HandsomeSoup
import Network.HTTP.Conduit (simpleHttp)
import Data.ByteString.Lazy.Char8 as BL8 (unpack)
import System.FilePath.Posix ((</>))
import Control.Applicative ((<$>))
import Data.List (nub, sort)
import Control.Monad (forM_, mapM_)
import Control.Monad.IO.Class (liftIO)

-- | entryURIsOf
-- >>> entryURIsOf $ fromJust $ parseURI "http://d.hatena.ne.jp/suzuki-shin/"
-- [http://d.hatena.ne.jp/suzuki-shin/2014/06/02/hogehoge,http://d.hatena.ne.jp/suzuki-shin/2014/06/01/fugafuga]
entryURIsOf :: String -> IO [String]
entryURIsOf baseUri = do
  aURLs <- archiveURLs baseUri
  concat <$> mapM (liftIO . entryURLsFromArchiveURL) aURLs

-- | archiveURLs
-- >>> archiveURLs "http://d.hatena.ne.jp/hogehoge"
-- ["http://d.hatena.ne.jp/hogehoge/archive?word=&of=50","http://d.hatena.ne.jp/hogehoge/archive?word=&of=100","http://d.hatena.ne.jp/hogehoge/archive?word=&of=150","http://d.hatena.ne.jp/hogehoge/archive?word=&of=200","http://d.hatena.ne.jp/hogehoge/archive?word=&of=250","http://d.hatena.ne.jp/hogehoge/archive?word=&of=300"]
archiveURLs :: String -> IO [String]
archiveURLs baseUrl = do
  c <- simpleHttp $ baseUrl </> "archive"
  let doc = readString [withParseHTML yes, withWarnings no] $ BL8.unpack c
  links <- runX $ doc //> css "div" >>> hasAttrValue "id" (== "pager-top") >>> css "a" ! "href"
  return $ sort $ nub links

entryURLsFromArchiveURL :: String -> IO [String]
entryURLsFromArchiveURL archiveURL = do
  c <- simpleHttp archiveURL
  let doc = readString [withParseHTML yes, withWarnings no] $ BL8.unpack c
  links <- runX $ doc //> css "li" >>> hasAttrValue "class" (== "archive archive-section") >>> css "a" ! "href"
  return $ sort $ nub links
