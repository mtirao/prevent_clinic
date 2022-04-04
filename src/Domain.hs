{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE RecordWildCards       #-}


module Domain where

import Data.Text.Lazy
import Data.Text.Lazy.Encoding
import Data.Aeson
import Control.Applicative
import GHC.Generics
import Data.Time.LocalTime



--- Adult
data Adult = Adult 
    {bloodPressureDiastolic :: Maybe Integer
    , bloodPressureMonitoring :: Maybe Bool
    , bloodPressureSystolic :: Maybe Integer
    , adultDate :: Maybe LocalTime
    , diabetes :: Maybe Integer
    , diabetesTreatment :: Maybe Integer
    , glucoseMonitoring :: Maybe Bool
    , adultId :: Maybe Integer
    , immunization :: Maybe Integer
    , lipidDisorder ::Maybe  Integer
    , lipidDisorderMonitoring :: Maybe Bool
    , lipidDisorderTreatment :: Maybe Integer
    , nutritionalMonitoring ::  Maybe Bool
    , nutritionalValue :: Maybe Integer
    , adultPatientid :: Integer
    , smokingCessation :: Maybe Integer
    }

instance ToJSON Adult where
    toJSON Adult {..} = object [
        "bloodpressurediastolic" .= bloodPressureDiastolic,
        "bloodpressuremonitoring" .= bloodPressureMonitoring,
        "bloodpressuresystolic" .= bloodPressureSystolic,
        "date" .= adultDate,
        "diabetes" .= diabetes,
        "diabetestreatment" .= diabetesTreatment,
        "glocusemonitoring" .= glucoseMonitoring,
        "adultid" .= adultId,
        "immunization" .= immunization,
        "lipiddisorder" .= lipidDisorder,
        "lipiddisordermonitoring" .= lipidDisorderMonitoring,
        "lipisdisordertreatment" .= lipidDisorderTreatment,
        "nutritionalmonitoring" .= nutritionalMonitoring,
        "nutritionalvalue" .= nutritionalValue,
        "patientid" .= adultPatientid,
        "smokingcessation" .= smokingCessation
        ]


instance FromJSON Adult where
    parseJSON (Object v) = Adult <$>
        v .:? "bloodpressurediastolic" <*>
        v .:? "bloodpressuremonitoring" <*>
        v .:? "bloodpressuresystolic" <*>
        v .:? "date" <*>
        v .:? "diabetes" <*>
        v .:? "diabetestreatment" <*>
        v .:? "glocusemonitoring" <*>
        v .:? "adultid" <*>
        v .:? "immunization" <*>
        v .:? "lipiddisorder" <*>
        v .:? "lipiddisordermonitoring" <*>
        v .:? "lipisdisordertreatment" <*>
        v .:? "nutritionalmonitoring" <*>
        v .:? "nutritionalvalue" <*>
        v .: "patientid" <*>
       v .:?  "smokingcessation"

-- Gynecology
data Gynecology = Gynecology
    {cevicouterinoTracking :: Integer
    , contraception :: Integer
    , gynecologyDate :: LocalTime
    , hpvImmunization :: Integer
    , gynecologyId :: Maybe Integer
    , lastPapResult :: Integer
    , gynecologyPatiendId :: Integer
    , teenBoarding :: Bool
    , trackingIts :: Integer
    }

instance ToJSON Gynecology where
     toJSON Gynecology {..} = object [
        "cevicouterinotracking" .= cevicouterinoTracking,
        "contraception" .= contraception,
        "date" .= gynecologyDate,
        "hpvimmunization" .= hpvImmunization,
        "id" .= gynecologyId,
        "lastpapresult" .= lastPapResult,
        "patientid" .= gynecologyPatiendId,
        "teenboarding" .= teenBoarding,
        "trackingits" .= trackingIts
        ]

instance FromJSON Gynecology where
    parseJSON (Object v) = Gynecology <$>
        v .: "cevicouterinotracking" <*>
        v .: "contraception" <*>
        v .: "date" <*>
        v .: "hpvimmunization" <*>
        v .:? "id" <*>
        v .: "lastpapresult" <*>
        v .: "patientid" <*>
        v .: "teenboarding" <*>
        v .: "trackingits"

-- Obstetric
data Obstetric = Obstetric
    {breastfeeding :: Integer
    , obstetricDate :: LocalTime
    , obstetricId :: Maybe Integer
    , obstetricImmunization :: Integer
    , itsPromotion :: Bool
    , nutritionalStatus :: Integer
    , nutritionalStatusTreatment :: Bool
    , obstetricPatientId :: Integer
    , perinatalInvestigations :: Integer
    , physiscalActivityPrescription :: Integer
    , problmeticConsuption :: Integer
    , psychoprophylaxis :: Integer
    }

instance ToJSON Obstetric where
     toJSON Obstetric {..} = object [
         "breastfeeding" .= breastfeeding,
         "date" .= obstetricDate,
         "id" .= obstetricId,
         "immunization" .= obstetricImmunization,
         "itspromotion" .= itsPromotion,
         "nutritionalstatus" .= nutritionalStatus,
         "nutritionalstatustreatment" .= nutritionalStatusTreatment,
         "patientid" .= obstetricPatientId,
         "perinatalinvestigation" .= perinatalInvestigations,
         "physicalactivityprescription" .= physiscalActivityPrescription,
         "problematicconsuption" .= problmeticConsuption,
         "psychoprophylaxis" .= psychoprophylaxis
        ]

instance FromJSON Obstetric where
    parseJSON (Object v) = Obstetric <$>
        v .: "breastfeeding" <*>
        v .: "date" <*>
        v .:? "id" <*>
        v .: "immunization" <*>
        v .: "itspromotion" <*>
        v .: "nutritionalstatus" <*>
        v .: "nutritionalstatustreatment" <*>
        v .: "patientid" <*>
        v .: "perinatalinvestigation" <*>
         v .: "physicalactivityprescription" <*>
         v .: "problematicconsuption" <*>
         v .: "psychoprophylaxis"

-- Pediatric
data Pediatric = Pediatric
    {accidentPreventionPromo :: Integer
    , breastfeedingPed :: Integer
    , breastfeedingPromotion :: Bool
    , date :: LocalTime
    , pediatricId :: Maybe Integer
    , immunizationPed :: Integer
    , mentalHealth :: Integer
    , nutritionalPromotion :: Bool
    , nutritionalStatusPed :: Integer
    , oralHealth :: Integer
    , oralHealthPromotion :: Bool
    , pediatricPatientid :: Integer
    , trackHearingProblems :: Integer
    , trackMetabolicProblems :: Integer
    , trackOphthalmologicalProblems :: Integer
    }

instance ToJSON Pediatric where
     toJSON Pediatric {..} = object [
         "accidentpreventionpromo" .= accidentPreventionPromo,
         "breastfeeding" .= breastfeedingPed,
         "breastfeedingpromotion" .= breastfeedingPromotion,
         "date" .= date,
         "id" .= pediatricId,
         "immunization" .= immunizationPed,
         "mentalhealth" .= mentalHealth,
         "nutritionalpromotion" .= nutritionalPromotion,
         "nutritionalstatus" .= nutritionalStatusPed,
         "oralhealth" .= oralHealth,
         "oralhealthpromotion" .= oralHealthPromotion,
         "patientid" .= pediatricPatientid,
         "trackhearingproblems" .= trackHearingProblems,
         "trackmetabolicproblems" .= trackMetabolicProblems,
         "trackophthalmologicalproblems" .= trackOphthalmologicalProblems
        ]

instance FromJSON Pediatric where
    parseJSON (Object v) = Pediatric <$>
         v .: "accidentpreventionpromo" <*>
         v .: "breastfeeding" <*>
         v .: "breastfeedingpromotion" <*>
         v .: "date" <*>
         v .:? "id" <*>
         v .: "immunization" <*>
         v .: "mentalhealth" <*>
         v .: "nutritionalpromotion" <*>
         v .: "nutritionalstatus" <*>
         v .: "oralhealth" <*>
         v .: "oralhealthpromotion" <*>
         v .: "patientid" <*>
         v .: "trackhearingproblems" <*>
         v .: "trackmetabolicproblems" <*>
         v .: "trackophthalmologicalproblems"

--- Patient and Clinic
data Patient = Patient {
    patientid :: Integer
    ,profileid :: Integer
}

instance ToJSON Patient where
     toJSON Patient {..} = object [
         "patientid" .= patientid,
         "profileid" .= profileid
        ]
