{-# LANGUAGE OverloadedStrings  #-}

module Lib
    ( readSql
    ) where

import Database.Sqlite
import Data.Text
import Database.Persist (PersistValue)


readSql :: IO ()
readSql = do
    conn <- open "./hoge.db"
    smt <- prepare conn "select * from users"
    rows <- readRows conn smt
    print rows
    finalize smt
    close conn
    return ()

readRows :: Connection -> Statement -> IO [[PersistValue]]
readRows conn smt = do
    res <- stepConn conn smt
    case res of
        Row -> do
            putStrLn "read row"
            row <- columns smt
            (row :) <$> readRows conn smt
        Done -> do
            putStrLn "read done"
            return []
