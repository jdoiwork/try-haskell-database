{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE UndecidableInstances       #-}
{-# LANGUAGE ScopedTypeVariables        #-}



module Lib2 where

import Database.Persist.TH
import Database.Persist.Sqlite
import Data.Text
import Control.Monad.IO.Class (MonadIO, liftIO)


-- , mkMigrate "migrateAll"
-- mkPersist sqlSettings

share [mkPersist sqlSettings ] [persistLowerCase|
User sql=users
    name  Text
    email Text

    deriving Show
|] 

readSql :: IO ()
readSql = do
    runSqlite "hoge.db" $ do
        users <- getUsersRaw
        liftIO $ print users
    return ()

getUsers :: MonadIO m =>  SqlPersistT m [Entity User]
getUsers = selectList [] []

getUsersRaw :: MonadIO m => SqlPersistT m [Entity User]
getUsersRaw = rawSql "select ?? from users where name = ?" [PersistText "jdoi"]
