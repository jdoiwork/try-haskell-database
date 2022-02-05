module Main where

import qualified Lib
import qualified Lib2
import qualified Lib3

main :: IO ()
main = do
    Lib.readSql
    Lib2.readSql
    Lib3.readSql 
