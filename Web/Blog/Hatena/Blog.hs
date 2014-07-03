module Web.Blog.Hatena.Blog (
   entryURLsOf
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

-- | entryURLsOf
entryURLsOf :: String -> IO [String]
entryURLsOf = undefined
-- entryURLsOf baseUri = do
--   aURLs <- archiveURLs baseUri
--   concat <$> mapM (liftIO . entryURLsFromArchiveURL) aURLs

-- | archiveURLs
-- archiveURLs :: String -> IO [String]
archiveURLs baseUrl = do
  c <- simpleHttp baseUrl
  let doc = readString [withParseHTML yes, withWarnings no] $ BL8.unpack c
  runX $ doc >>> css "a" ! "href"
--   links <- runX $ doc //> css "a" >>> hasAttrValue "class" (== "archive-module-year-title") 
--   return $ sort $ nub links

entryURLsFromArchiveURL :: String -> IO [String]
entryURLsFromArchiveURL archiveURL = do
  c <- simpleHttp archiveURL
  let doc = readString [withParseHTML yes, withWarnings no] $ BL8.unpack c
  links <- runX $ doc //> css "li" >>> hasAttrValue "class" (== "archive archive-section") >>> css "a" ! "href"
  return $ sort $ nub links
