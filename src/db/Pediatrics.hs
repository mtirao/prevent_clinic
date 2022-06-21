{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Pediatrics where

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


pediatricTuple :: Pediatric -> (Integer, Integer, Bool, LocalTime, Maybe Integer, Integer, Integer, Bool,  Integer, Integer, Bool, Integer, Integer, Integer, Integer)
pediatricTuple a = ((accidentPreventionPromo a),(breastfeedingPed a), (breastfeedingPromotion a), (date a), 
                            (pediatricId a), (immunizationPed a), (mentalHealth a), (nutritionalPromotion a), 
                            (nutritionalStatusPed a), (oralHealth a), (oralHealthPromotion a), (pediatricPatientid a), 
                            (trackHearingProblems a), (trackMetabolicProblems a), (trackOphthalmologicalProblems a))

executePediatric :: Pool Connection -> Pediatric -> Query -> IO [(Integer, Integer, Bool, LocalTime, Maybe Integer, Integer, Integer, Bool,  Integer, Integer, Bool, Integer, Integer, Integer, Integer)]
executePediatric pool a query = do fetch pool (pediatricTuple a) query :: IO [(Integer, Integer, Bool, LocalTime, Maybe Integer, Integer, Integer, Bool,  Integer, Integer, Bool, Integer, Integer, Integer, Integer)]

buildPediatric ::(Integer, Integer, Bool, LocalTime, Maybe Integer, Integer, Integer, Bool,  Integer, Integer, Bool, Integer, Integer, Integer, Integer) -> Pediatric
buildPediatric (accident_prevention_promo, breast_feeding_ped, breast_feeding_promotion, date, 
                            pediatric_id, immunization_ped, mental_health, nutritional_promotion, 
                            nutritional_status_ped, oral_health, oral_health_promotion, pediatric_patient_id, 
                            track_hearing_problems, track_metabolic_problems, track_ophthalmological_problems) = Pediatric accident_prevention_promo breast_feeding_ped breast_feeding_promotion date pediatric_id immunization_ped mental_health nutritional_promotion nutritional_status_ped oral_health oral_health_promotion pediatric_patient_id track_hearing_problems track_metabolic_problems track_ophthalmological_problems

instance DbOperation Pediatric where
    insert pool (Just a) = do
                res <- executePediatric pool a "INSERT INTO gynecologies(cevicouterino_tracking, contraception, date, hpv_immmunizatio, last_pap_result, patient_id, teen_boarding, tracking_its) VALUES(?,?,?,?,?,?,?,?,?) RETURNING cevicouterino_tracking, contraception, date, hpv_immmunizatio, last_pap_result, patient_id, teen_boarding, tracking_its"
                return $ onePediatric res
                    where   onePediatric (pediatric: _) = Just $ buildPediatric pediatric
                            onePediatric _ = Nothing
    
    list  pool = do
                    res <- fetchSimple pool "SELECT cevicouterino_tracking, contraception, date, hpv_immmunizatio, last_pap_result, patient_id, teen_boarding, tracking_its FROM gynecologies" :: IO [(Integer, Integer, Bool, LocalTime, Maybe Integer, Integer, Integer, Bool,  Integer, Integer, Bool, Integer, Integer, Integer, Integer)]
                    return $ map (\a -> buildPediatric a) res
