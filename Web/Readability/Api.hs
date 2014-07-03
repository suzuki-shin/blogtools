{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE EmptyDataDecls    #-}

module Web.Readability.Api (
  saveEntry
) where

import Data.Text (Text)
import Data.Maybe (fromJust)
import Control.Monad (mzero)
import Data.Aeson
import Network.HTTP.Conduit (simpleHttp)
import Control.Monad.IO.Class (liftIO)
import Control.Applicative ((<$>),(<*>))
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import System.Environment (getEnv)

baseUrl :: String
baseUrl = "https://readability.com/api/content/v1/parser"
dbname :: Text
dbname = "entry.sqlite3"

getToken :: IO String
getToken = getEnv "READABILITY_API_TOKEN"

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
ReaderApiResponse
    content Text
    domain String
    author Text Maybe
    url String
    shortUrl String
    title Text
    excerpt Text
    direction String
    wordCount Int
    totalPages Int
    datePublished String Maybe
    dek Text Maybe
    leadImageUrl String Maybe
    nextPageId Int Maybe
    renderedPages Int
    UniqueReaderApiResponse url
    deriving Show
|]

instance FromJSON ReaderApiResponse where
  parseJSON (Object v) = ReaderApiResponse <$>
                         v .: "content" <*>
                         v .: "domain" <*>
                         v .:? "author" <*>
                         v .: "url" <*>
                         v .: "short_url" <*>
                         v .: "title" <*>
                         v .: "excerpt" <*>
                         v .: "direction" <*>
                         v .: "word_count" <*>
                         v .: "total_pages" <*>
                         v .:? "date_published" <*>
                         v .:? "dek" <*>
                         v .:? "lead_image_url" <*>
                         v .:? "next_page_id" <*>
                         v .: "rendered_pages"
  parseJSON _          = mzero

saveEntry :: String -> IO ()
saveEntry entry_url = 
--   a <- simpleHttp $ baseUrl ++ "?url=" ++ entry_url ++ "&token=" ++ token
--   let b = fromJust $ decode a :: ReaderApiResponse
  runSqlite dbname $ do
    runMigration migrateAll
    entries <- selectList ([ReaderApiResponseUrl ==. entry_url]::[Filter ReaderApiResponse]) [LimitTo 1]
    if null entries
      then do
        b <- liftIO $ httpGetAndJson entry_url
        insert b
        liftIO $ print $ readerApiResponseUrl b
      else error "already saved."
    return ()
--     liftIO $ print $ map (readerApiResponseTitle . entityVal) entries

httpGetAndJson :: String -> IO ReaderApiResponse
httpGetAndJson entry_url = do
  token <- getToken
  a <- simpleHttp $ baseUrl ++ "?url=" ++ entry_url ++ "&token=" ++ token
  let b = fromJust $ decode a :: ReaderApiResponse
  return b
