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

executeAdult :: Pool Connection -> Adult -> Query -> IO [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                        Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)]
executeAdult pool a query = do
                        fetch pool ((bloodPressureDiastolic a), (bloodPressureMonitoring a), (bloodPressureSystolic a), 
                            (adultDate a), (diabetes a), (diabetesTreatment a), (glucoseMonitoring a), 
                            (immunization a), (lipidDisorder a), (lipidDisorderMonitoring a), 
                            (lipidDisorderTreatment a), (nutritionalMonitoring a), 
                            (nutritionalValue a), (adultPatientid a), (smokingCessation a)) query :: IO [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)]



buildAdult :: (Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                        Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer) -> Adult
buildAdult (blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date,
            diabetes, diabetes_treatment, glucose_monitoring, adultId, 
            immunization, lipid_disorder, lipid_disorder_monitoring, 
            lipid_disorder_treatment, nutritional_monitoring, nutritional_value, 
            patient_id, smoking_cessation) = Adult blood_pressure_diastolic blood_pressure_monitoring blood_pressure_systolic date diabetes diabetes_treatment glucose_monitoring adultId immunization lipid_disorder lipid_disorder_monitoring lipid_disorder_treatment nutritional_monitoring nutritional_value patient_id smoking_cessation


oneAdult :: [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                        Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)] -> Maybe Adult
oneAdult (a : _) = Just $ buildAdult a
oneAdult _ = Nothing

findLast :: Pool Connection -> IO (Maybe Adult)
findLast pool = do
                    res <- fetchSimple pool "SELECT blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation FROM adults ORDER By date desc" :: IO [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                            Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)]
                    return $ oneAdult res

listAdults pool id = do
                        res <- fetch pool (Only id) "SELECT blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation FROM adults where patient_id = ?" :: IO [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                            Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)]
                        return $ map (\a -> buildAdult a) res


instance DbOperation Adult where
    insert pool (Just a) = do
                res <- executeAdult pool a "INSERT INTO adults(blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) RETURNING blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation"
                return $ oneAdult res
    
    list  pool = do
                    res <- fetchSimple pool "SELECT blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation FROM adults" :: IO [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                        Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)]
                    return $ map (\a -> buildAdult a) res

    find  pool id = do 
                        res <- fetch pool (Only id) "SELECT blood_pressure_diastolic, blood_pressure_monitoring, blood_pressure_systolic, date, diabetes, diabetes_treatment, glucose_monitoring, id, immunization, lipid_disorder, lipid_disorder_monitoring, lipid_disorder_treatment, nutritional_monitoring, nutritional_value, patient_id, smoking_cessation FROM adults WHERE id=?" :: IO [(Maybe Integer, Maybe Bool, Maybe Integer, Maybe LocalTime, Maybe Integer, Maybe Integer, Maybe Bool,
                            Maybe Integer, Maybe Integer, Maybe Integer, Maybe Bool, Maybe Integer, Maybe Bool, Maybe Integer, Integer, Maybe Integer)]
                        return $ oneAdult res