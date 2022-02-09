module Web.Controller.Adults where

import Web.Controller.Prelude
import Web.View.Adults.Index
import Web.View.Adults.New
import Web.View.Adults.Edit
import Web.View.Adults.Show

instance ToJSON Adult where
    toJSON adult = object
        [ "id" .= get #id adult
        ]

instance Controller AdultsController where
    action AdultsAction = do
        adults <- query @Adult |> fetch
        render IndexView { .. }

    action NewAdultAction = do
        let adult = newRecord
        render NewView { .. }

    action ShowAdultAction { adultId } = do
        adult <- fetch adultId
        render ShowView { .. }

    action EditAdultAction { adultId } = do
        adult <- fetch adultId
        render EditView { .. }

    action UpdateAdultAction { adultId } = do
        adult <- fetch adultId
        adult
            |> buildAdult
            |> ifValid \case
                Left adult -> render EditView { .. }
                Right adult -> do
                    adult <- adult |> updateRecord
                    setSuccessMessage "Adult updated"
                    redirectTo EditAdultAction { .. }

    action CreateAdultAction = do
        let adult = newRecord @Adult
        adult
            |> buildAdult
            |> ifValid \case
                Left adult -> render NewView { .. } 
                Right adult -> do
                    adult <- adult |> createRecord
                    setSuccessMessage "Adult created"
                    redirectTo AdultsAction

    action DeleteAdultAction { adultId } = do
        adult <- fetch adultId
        deleteRecord adult
        setSuccessMessage "Adult deleted"
        redirectTo AdultsAction

buildAdult adult = adult
    |> fill @["nutritionalValue","nutritionalMonitoring","bloodPressureSystolic","bloodPressureDiastolic","bloodPressureMonitoring","diabetes","glucoseMonitoring","diabetesTreatment","lipidDisorder","lipidDisorderMonitoring","lipidDisorderTreatment","immunization","smokingCessation","patient"]
