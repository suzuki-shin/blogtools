{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Blog.Type
import Network.URI
import Text.XML.HXT.Core
import Text.HandsomeSoup
import Network.HTTP.Conduit
import Data.ByteString.Lazy.Char8 as BL8 (pack, unpack)
import Control.Applicative

main = do
  let a = URI "http" (Just $ URIAuth "" "d.hatena.ne.jp" "") "/hoge" "" ""
  let b = (HatenaDiary, a)
  let a2 = parseURI "http://d.hatena.ne.jp/suzuki-shin/"
  print b
  print a2

hss = do
--   c <- simpleHttp "http://d.hatena.ne.jp/suzuki-shin/archive"
  c <- simpleHttp "http://d.hatena.ne.jp/kazu-yamamoto/archive"
  let doc = readString [withParseHTML yes, withWarnings no] $ BL8.unpack c
  links <- runX $ doc //> css "div" >>> hasAttrValue "id" (== "pager-top") >>> css "a" ! "href"
  mapM_ putStrLn links
