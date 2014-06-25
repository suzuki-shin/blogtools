import Web.Blog.Type
-- import Network.URI

main = do
  let a = URI "http" (Just $ URIAuth "" "d.hatena.ne.jp" "") "/hoge" "" ""
  let b = (HatenaDiary, a)
  let a2 = parseURI "http://d.hatena.ne.jp/suzuki-shin/"
  print b
  print a2


