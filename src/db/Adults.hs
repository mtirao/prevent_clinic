{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Db.Adults where

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

executeAdult :: Pool Connection -> Adult -> Query -> IO [(Integer, Bool, Integer, Maybe LocalTime, Integer, Integer, Bool,
                        Maybe Integer, Integer, Integer, Bool, Bool, Bool, Integer, Integer, Integer)]
executeAdult pool a query = do
                        fetch pool ((bloodPressureDiastolic a), (bloodPressureMonitoring a), (bloodPressureSystolic a), 
                            (adultDate a), (diabetes a), (diabetesTreatment a), (glucoseMonitoring a), 
                            (immunization a), (lipidDisorder a), (lipidDisorderMonitoring a), 
                            (lipidDisorderTreatment a), (nutritionalMonitoring a), 
                            (nutritionalValue a), (adultPatientid a), (smokingCessation a)) query :: IO [(Integer, Bool, Integer, Maybe LocalTime, Integer, Integer, Bool,Maybe Integer, Integer, Integer, Bool, Bool, Bool, Integer, Integer, Integer)]



buildAdult :: (Integer, Bool, Integer, Maybe LocalTime, Integer, Integer, Bool,
    Maybe Integer, Integer, Integer, Bool, Bool, Bool, Integer, Integer, Integer) -> Adult
buildAdult (blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date,
            diabetes, diabetes_treatment, glucose_monitoring, adultId, 
            immunization, lipid_disorder, lipid_disorder_monitoring, 
            lipid_disorder_treatment, nutritional_monitoring, nutritional_value, 
            patient_id, smoking_cessation) = Adult blood_pressure_diastolic blood_pressure_monitoring blood_pressure_systolic date diabetes diabetes_treatment glucose_monitoring adultId immunization lipid_disorder lipid_disorder_monitoring lipid_disorder_treatment nutritional_monitoring nutritional_value patient_id smoking_cessation


instance DbOperation Adult where
    insert pool (Just a) = do
                res <- executeAdult pool a "INSERT INTO adults(blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) RETURNING blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation"
                return $ oneAdult res
                    where   oneAdult ( adult: _) = Just $ buildAdult adult
                            oneAdult _ = Nothing
    
    list  pool = do
                    res <- fetchSimple pool "SELECT blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation FROM adults" :: IO [(Integer, Bool, Integer, Maybe LocalTime, Integer, Integer, Bool,Maybe Integer, Integer, Integer, Bool, Bool, Bool, Integer, Integer, Integer)]
                    return $ map (\a -> buildAdult a) res
