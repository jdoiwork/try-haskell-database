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



module Lib3 where

import Database.Persist.TH
import Database.Persist.Postgresql
import Control.Monad.Trans.Resource (runResourceT)
import Control.Monad.Logger (runStderrLoggingT, logInfo)
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
    runStderrLoggingT $ withPostgresqlPool cs 3 $ \pool -> liftIO $ do
        flip runSqlPersistMPool pool $ do
            users <- getUsers
            users <- getUsersRaw
            liftIO $ print users
    return ()
    where
        cs = "host=db port=5432 user=postgres dbname=hoge password=example"

getUsers :: MonadIO m =>  SqlPersistT m [Entity User]
getUsers = selectList [] []

getUsersRaw :: MonadIO m => SqlPersistT m [Entity User]
getUsersRaw = rawSql "select ?? from users where name = ?" [PersistText "jdoi"]
