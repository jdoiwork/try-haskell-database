{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE UndecidableInstances       #-}
{-# LANGUAGE ScopedTypeVariables        #-}



module Lib3 where

import Database.Persist.Postgresql
    ( runSqlPersistMPool, withPostgresqlPool )
import Control.Monad.Logger (runStderrLoggingT, logInfo)
import Control.Monad.IO.Class (MonadIO, liftIO)
import DbModel ( printUsers )



readSql :: IO ()
readSql = do
    runStderrLoggingT $ withPostgresqlPool cs 3 $ \pool -> liftIO $ do
        flip runSqlPersistMPool pool $ do
            printUsers
    return ()
    where
        cs = "host=db port=5432 user=postgres dbname=hoge password=example"

