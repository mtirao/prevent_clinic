{-# LANGUAGE OverloadedStrings #-}

module Web.Controller.GynecologiesApi where

import Web.Controller.Prelude
import Data.Attoparsec.Char8
import Control.Applicative
import Web.Controller.Gynecologies


instance CanRoute GynecologiesApiController where
    parseRoute' = string "/api/v1/gynecologies/" <* endOfInput >> pure GynecologiesApiAction

instance HasPath GynecologiesApiController where
    pathTo GynecologiesApiAction  = "/api/v1/gynecologies/"

instance Controller GynecologiesApiController  where
    action  GynecologiesApiAction = do
        gynecologiesApi <-query @Gynecology |> fetch
        renderJson (toJSON gynecologiesApi)