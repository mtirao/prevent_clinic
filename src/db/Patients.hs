{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Patients where

import Db
import Domain

import Web.Scotty.Internal.Types (ActionT)
import GHC.Generics (Generic)
import Control.Monad.IO.Class
import Database.PostgreSQL.Simple
import Data.Pool(Pool, createPool, withResource)
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as TL
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Text as T
import GHC.Int
import Data.Time.LocalTime


buildPatient :: (Integer, Integer) -> Patient
buildPatient (patientid, profileid) = Patient patientid profileid 

listPatientsWithoutClinic pool = do
                                    res <- fetchSimple pool "select id as patient_id, profile_id from patient_without_clinic" :: IO [(Integer,Integer)]
                                    return $ map (\a -> buildPatient a) res
