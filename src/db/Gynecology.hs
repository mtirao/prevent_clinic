{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Db.Gynecology where

import Db.Db
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



gynecologyTuple :: Gynecology -> (Integer, Integer, LocalTime, Integer, Maybe Integer, Integer, Integer, Bool,  Integer)
gynecologyTuple a = ((cevicouterinoTracking a),(contraception a), (gynecologyDate a), (hpvImmunization a), 
                            (gynecologyId a), (lastPapResult a), (gynecologyPatiendId a), (teenBoarding a), 
                            (trackingIts a))

executeGynecology :: Pool Connection -> Gynecology -> Query -> IO [(Integer, Integer, LocalTime, Integer, Maybe Integer, Integer, Integer, Bool,  Integer)]
executeGynecology pool a query = do fetch pool (gynecologyTuple a) query :: IO [(Integer, Integer, LocalTime, Integer, Maybe Integer, Integer, Integer, Bool,  Integer)]

buildGynecology ::(Integer, Integer, LocalTime, Integer, Maybe Integer, Integer, Integer, Bool,  Integer) -> Gynecology
buildGynecology (cevicouterino_tracking, contraception, gynecology_date, hpv_immunization,  gynecology_id, last_pap_result,
            patient_id, teen_boarding, tracking_its) = Gynecology cevicouterino_tracking contraception gynecology_date hpv_immunization gynecology_id last_pap_result patient_id teen_boarding tracking_its

instance DbOperation Gynecology where
    insert pool (Just a) = do
                res <- executeGynecology pool a "INSERT INTO gynecologies(cevicouterino_tracking, contraception, date, hpv_immmunizatio, last_pap_result, patient_id, teen_boarding, tracking_its) VALUES(?,?,?,?,?,?,?,?,?) RETURNING cevicouterino_tracking, contraception, date, hpv_immmunizatio, last_pap_result, patient_id, teen_boarding, tracking_its"
                return $ oneGynecology res
                    where   oneGynecology (gynecology: _) = Just $ buildGynecology gynecology
                            oneGynecology _ = Nothing
    
    list  pool = do
                    res <- fetchSimple pool "SELECT cevicouterino_tracking, contraception, date, hpv_immmunizatio, last_pap_result, patient_id, teen_boarding, tracking_its FROM gynecologies" :: IO [(Integer, Integer, LocalTime, Integer, Maybe Integer, Integer, Integer,  Bool,  Integer)]
                    return $ map (\a -> buildGynecology a) res
