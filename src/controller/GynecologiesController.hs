{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controller.GynecologiesController where

import Domain
import Views
import Db.Gynecology
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
createGynecology pool =  do
                        b <- body
                        gynecology <- return $ (decode b :: Maybe Gynecology)
                        case gynecology of
                            Nothing -> status status401
                            Just _ -> gynecologyResponse pool gynecology

gynecologyResponse pool gynecology = do 
                                dbGynecology <- liftIO $ insert pool gynecology
                                case dbGynecology of
                                        Nothing -> status status400
                                        Just a -> dbGynecologyResponse 
                                                where dbGynecologyResponse   = do
                                                                        jsonResponse a
                                                                        status status201

--- GET & LIST
listGynecology pool =  do
                        gynecologies <- liftIO $ (list pool :: IO [Gynecology])
                        jsonResponse gynecologies