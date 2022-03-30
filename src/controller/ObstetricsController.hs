{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controller.ObstetricsController where

import Domain
import Views
import Db.Obstetrics
import Db.Db

import Web.Scotty
import Web.Scotty.Internal.Types (ActionT)


import Control.Monad.IO.Class
import Database.PostgreSQL.Simple
import Data.Pool(Pool, createPool, withResource)
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as TL
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Text as T

import GHC.Int
import GHC.Generics (Generic)

import Network.Wai.Middleware.Static
import Network.Wai.Middleware.RequestLogger (logStdout)
import Network.HTTP.Types.Status

import Data.Aeson

---CREATE
createObstetric pool =  do
                        b <- body
                        obtetric <- return $ (decode b :: Maybe Obstetric)
                        case obtetric of
                            Nothing -> status status401
                            Just _ -> controllerInsertResponse pool obtetric


--- GET & LIST
listObstetric pool =  do
                        obtetrics <- liftIO $ (list pool :: IO [Obstetric])
                        jsonResponse obtetrics