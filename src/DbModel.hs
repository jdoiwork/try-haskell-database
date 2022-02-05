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

module DbModel where

import Database.Persist.TH
import Database.Persist.Sql
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





getUsers :: MonadIO m =>  SqlPersistT m [Entity User]
getUsers = selectList [] []

getUsersRaw :: MonadIO m => SqlPersistT m [Entity User]
getUsersRaw = rawSql "select ?? from users where name = ?" [PersistText "jdoi"]

printUsers :: MonadIO m => SqlPersistT m ()
printUsers = do
    users <- getUsers
    liftIO $ print users

    users <- getUsersRaw
    liftIO $ print users

