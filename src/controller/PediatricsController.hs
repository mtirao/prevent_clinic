{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controller.PediatricsController where

import Domain
import Views
import Db.Pediatrics
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
createPediatric pool =  do
                        b <- body
                        pediatric <- return $ (decode b :: Maybe Pediatric)
                        case pediatric of
                            Nothing -> status status401
                            Just _ -> controllerInsertResponse pool pediatric


--- GET & LIST
listPediatric pool =  do
                        pediatrics <- liftIO $ (list pool :: IO [Pediatric])
                        jsonResponse pediatrics