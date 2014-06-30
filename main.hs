import Web.Blog.Type
import Network.URI
import Text.XML.HXT.Core
import Text.HandsomeSoup
import Network.HTTP.Conduit
import Data.ByteString.Lazy.Char8 as BL8
import Control.Applicative

main = do
  let a = URI "http" (Just $ URIAuth "" "d.hatena.ne.jp" "") "/hoge" "" ""
  let b = (HatenaDiary, a)
  let a2 = parseURI "http://d.hatena.ne.jp/suzuki-shin/"
  print b
  print a2

  c <- simpleHttp "http://d.hatena.ne.jp/kazu-yamamoto/archive"
  let doc = readString [withParseHTML yes, withWarnings no] $ BL8.pack c
  print doc
