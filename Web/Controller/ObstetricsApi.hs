{-# LANGUAGE OverloadedStrings #-}

module Web.Controller.ObstetricsApi where

import Web.Controller.Prelude
import Data.Attoparsec.Char8
import Control.Applicative
import Web.Controller.Obstetrics 


instance CanRoute ObstetricApiController where
    parseRoute' = string "/api/v1/obstetrics/" <* endOfInput >> pure ObstetricApiAction

instance HasPath ObstetricApiController where
    pathTo ObstetricApiAction  = "/api/v1/obstetrics/"

instance Controller ObstetricApiController  where
    action  ObstetricApiAction = do
        obstertricsApi <-query @Obstetric |> fetch
        renderJson (toJSON obstertricsApi)