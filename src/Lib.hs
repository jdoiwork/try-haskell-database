{-# LANGUAGE OverloadedStrings  #-}

module Lib
    ( readSql
    ) where

import Database.Sqlite
import Data.Text (Text)
import Database.Persist (PersistValue)


readSql :: IO ()
readSql = do
    conn <- open "./hoge.db"

    stmt <- prepare  conn "select * from users"
    rows <- readRows conn stmt
    print rows

    finalize stmt
    close conn

    return ()


readRows :: Connection -> Statement -> IO [[PersistValue]]
readRows conn stmt = loop []
    where
        loop xs = do
            res <- stepConn conn stmt
            case res of
                Done -> do
                    putStrLn "read done"
                    return $ reverse xs
                Row -> do
                    putStrLn "read row"
                    row <- columns stmt
                    loop (row : xs)

