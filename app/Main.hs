module Main where

import qualified Lib
import qualified Lib2

main :: IO ()
main = do
    Lib.readSql
    Lib2.readSql
