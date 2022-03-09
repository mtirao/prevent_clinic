{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Db.Obstetrics where

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


obstetricTuple :: Obstetric -> (Integer, LocalTime, Maybe Integer, Integer, Bool,  Integer, Bool,Integer, Integer, Integer, Integer, Integer)
obstetricTuple a = ((breastfeeding a), (obstetricDate a), (obstetricId a), 
                            (obstetricImmunization a), (itsPromotion a), (nutritionalStatus a), (nutritionalStatusTreatment a), 
                            (obstetricPatientId a), (perinatalInvestigations a), (physiscalActivityPrescription a), 
                            (problmeticConsuption a), (psychoprophylaxis a))

executeObstertric :: Pool Connection -> Obstetric -> Query -> IO [(Integer, LocalTime, Maybe Integer, Integer, Bool,  Integer, Bool,
                            Integer, Integer, Integer, Integer, Integer)]
executeObstertric pool a query = do fetch pool (obstetricTuple a) query :: IO [(Integer, LocalTime, Maybe Integer, Integer, Bool,  Integer, Bool, Integer, Integer, Integer, Integer, Integer)]

buildObstetric :: (Integer, LocalTime, Maybe Integer, Integer, Bool,  Integer, Bool,
                            Integer, Integer, Integer, Integer, Integer) -> Obstetric
buildObstetric (breast_feeding, obstetric_date, obstetric_id, obstetric_immunization,
            its_promotion, nutritional_status, nutritional_status_treatment, obstetric_patient_id, 
            perinatal_investigation, physiscal_activity_prescription, problematic_consuption, psychoprophylaxis) = Obstetric breast_feeding obstetric_date obstetric_id obstetric_immunization its_promotion nutritional_status nutritional_status_treatment obstetric_patient_id perinatal_investigation physiscal_activity_prescription problematic_consuption psychoprophylaxis

instance DbOperation Obstetric where
    insert pool (Just a) = do
                res <- executeObstertric pool a "INSERT INTO obstetrics(breast_feeding, obstetric_date, obstetric_id, obstetric_immunization, its_promotion, nutritional_status, nutritional_status_treatment, obstetric_patient_id, perinatal_investigation, problematic_consuption, psychoprophylaxis) VALUES(?,?,?,?,?,?,?,?,?,?,?) RETURNING breast_feeding, obstetric_date, obstetric_id, obstetric_immunization, its_promotion, nutritional_status, nutritional_status_treatment, obstetric_patient_id, perinatal_investigation, problematic_consuption, psychoprophylaxis"
                return $ oneObstetric res
                    where   oneObstetric (obstetric: _) = Just $ buildObstetric obstetric
                            oneObstetric _ = Nothing
    
    list  pool = do
                    res <- fetchSimple pool "SELECT breast_feeding, obstetric_date, obstetric_id, obstetric_immunization, its_promotion, nutritional_status, nutritional_status_treatment, obstetric_patient_id, perinatal_investigation, problematic_consuption, psychoprophylaxis FROM obstetrics" :: [(Integer, LocalTime, Maybe Integer, Integer, Bool,  Integer, Bool, Integer, Integer, Integer, Integer, Integer)]
                    return $ map (\a -> buildObstetric a) res


