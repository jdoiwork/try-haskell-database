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

import Database.Persist.Sql
    ( runSqlPersistMPool, createPoolConfig )
import Database.Persist.Postgresql
    ( PostgresConf(..) )
import DbModel ( printUsers )


psqlConf :: PostgresConf
psqlConf =  PostgresConf cs stripes timeout poolsize
    where
        cs = "host=db port=5432 user=postgres dbname=hoge password=example"
        stripes  = 1
        timeout  = 120
        poolsize = 4

readSql :: IO ()
readSql = do
    pool <- createPoolConfig psqlConf
    flip runSqlPersistMPool pool $ do
        printUsers
    return ()
