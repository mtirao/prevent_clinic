{-# LANGUAGE OverloadedStrings #-}

module Web.Controller.AdultsApi where

import Web.Controller.Prelude
import Data.Attoparsec.Char8
import Control.Applicative
import Web.Controller.Adults


instance CanRoute AdultsApiController where
    parseRoute' = string "/api/v1/adults/" <* endOfInput >> pure AdultsApiAction

instance HasPath AdultsApiController where
    pathTo AdultsApiAction  = "/api/v1/adults/"

instance Controller AdultsApiController  where
    action  AdultsApiAction = do
        adultsApi <-query @Adult |> fetch
        renderJson (toJSON adultsApi)