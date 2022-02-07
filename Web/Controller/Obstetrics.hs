module Web.Controller.Obstetrics where

import Web.Controller.Prelude
import Web.View.Obstetrics.Index
import Web.View.Obstetrics.New
import Web.View.Obstetrics.Edit
import Web.View.Obstetrics.Show

instance Controller ObstetricsController where
    action ObstetricsAction = do
        obstetrics <- query @Obstetric |> fetch
        render IndexView { .. }

    action NewObstetricAction = do
        let obstetric = newRecord
        render NewView { .. }

    action ShowObstetricAction { obstetricId } = do
        obstetric <- fetch obstetricId
        render ShowView { .. }

    action EditObstetricAction { obstetricId } = do
        obstetric <- fetch obstetricId
        render EditView { .. }

    action UpdateObstetricAction { obstetricId } = do
        obstetric <- fetch obstetricId
        obstetric
            |> buildObstetric
            |> ifValid \case
                Left obstetric -> render EditView { .. }
                Right obstetric -> do
                    obstetric <- obstetric |> updateRecord
                    setSuccessMessage "Obstetric updated"
                    redirectTo EditObstetricAction { .. }

    action CreateObstetricAction = do
        let obstetric = newRecord @Obstetric
        obstetric
            |> buildObstetric
            |> ifValid \case
                Left obstetric -> render NewView { .. } 
                Right obstetric -> do
                    obstetric <- obstetric |> createRecord
                    setSuccessMessage "Obstetric created"
                    redirectTo ObstetricsAction

    action DeleteObstetricAction { obstetricId } = do
        obstetric <- fetch obstetricId
        deleteRecord obstetric
        setSuccessMessage "Obstetric deleted"
        redirectTo ObstetricsAction

buildObstetric obstetric = obstetric
    |> fill @["patient","psychoprophylaxis","nutritionalStatus","nutritionalStatusTreatment","physicalActivityPrescription","immunization","perinatalInvestigations","breastfeeding","itsPromotion","problematicConsumption"]
