{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Controller.AdultsController where

import Domain
import Views
import Db.Adults
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
createAdult pool =  do
                        b <- body
                        adult <- return $ (decode b :: Maybe Adult)
                        case adult of
                            Nothing -> status status401
                            Just _ -> controllerInsertResponse pool adult


--- GET & LIST
listAdultsForPatient pool id =  do
                                    adults <- liftIO $ (listAdults pool id :: IO [Adult]) --(listAdults pool id :: IO [Adult])
                                    jsonResponse adults

findNewer pool =  do
                        adults <- liftIO $ (findLast pool :: IO (Maybe Adult))
                        jsonResponse adults


getAdult pool id = do
                        adults <- liftIO $ (find pool id :: IO (Maybe Adult))
                        jsonResponse adults
