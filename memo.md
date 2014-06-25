#### API ####

```haskell
-- | blog (BlogType, Url)を受け取り、そのblogのエントリのurlのリストを返す
-- >>> entryUrlsOf "http://d.hatena.ne.jp/suzuki-shin/"
-- ["http://d.hatena.ne.jp/suzuki-shin/2014/06/02/hogehoge", "http://d.hatena.ne.jp/suzuki-shin/2014/06/01/fugafuga",,,]
entryURIsOf :: Blog -> [URI]

-- | エントリのurlのリストを受け取り、そのエントリの内容をreadabilityを通して取得し、DBに保存する
saveEntry :: URI -> IO ()
```

