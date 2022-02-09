{-# LANGUAGE OverloadedStrings #-}

module Web.Controller.PediatricsApi where

import Web.Controller.Prelude
import Data.Attoparsec.Char8
import Control.Applicative
import Web.Controller.Pediatrics


instance CanRoute PediatricsApiController where
    parseRoute' = string "/api/v1/pediatrics/" <* endOfInput >> pure PediatricsApiAction

instance HasPath PediatricsApiController where
    pathTo PediatricsApiAction  = "/api/v1/pediatrics/"

instance Controller PediatricsApiController  where
    action  PediatricsApiAction = do
        pediatricsApi <-query @Pediatric |> fetch
        renderJson (toJSON pediatricsApi)