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
    ( mkPersist, persistLowerCase, share, sqlSettings )
import Database.Persist.Sql
    ( PersistValue(PersistText),
      selectList,
      rawSql,
      Entity,
      BackendKey(SqlBackendKey),
      SqlPersistT )
import Data.Text ( Text )
import Control.Monad.IO.Class (MonadIO, liftIO)


-- share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
share [mkPersist sqlSettings] [persistLowerCase|
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

