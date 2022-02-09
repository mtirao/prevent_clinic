module Web.Controller.Pediatrics where

import Web.Controller.Prelude
import Web.View.Pediatrics.Index
import Web.View.Pediatrics.New
import Web.View.Pediatrics.Edit
import Web.View.Pediatrics.Show


instance ToJSON Pediatric where
    toJSON pediatric = object
        [ "id" .= get #id pediatric
        ]

instance Controller PediatricsController where
    action PediatricsAction = do
        pediatrics <- query @Pediatric |> fetch
        render IndexView { .. }

    action NewPediatricAction = do
        let pediatric = newRecord
        render NewView { .. }

    action ShowPediatricAction { pediatricId } = do
        pediatric <- fetch pediatricId
        render ShowView { .. }

    action EditPediatricAction { pediatricId } = do
        pediatric <- fetch pediatricId
        render EditView { .. }

    action UpdatePediatricAction { pediatricId } = do
        pediatric <- fetch pediatricId
        pediatric
            |> buildPediatric
            |> ifValid \case
                Left pediatric -> render EditView { .. }
                Right pediatric -> do
                    pediatric <- pediatric |> updateRecord
                    setSuccessMessage "Pediatric updated"
                    redirectTo EditPediatricAction { .. }

    action CreatePediatricAction = do
        let pediatric = newRecord @Pediatric
        pediatric
            |> buildPediatric
            |> ifValid \case
                Left pediatric -> render NewView { .. } 
                Right pediatric -> do
                    pediatric <- pediatric |> createRecord
                    setSuccessMessage "Pediatric created"
                    redirectTo PediatricsAction

    action DeletePediatricAction { pediatricId } = do
        pediatric <- fetch pediatricId
        deleteRecord pediatric
        setSuccessMessage "Pediatric deleted"
        redirectTo PediatricsAction

buildPediatric pediatric = pediatric
    |> fill @["immunization","breastfeeding","patient","breastfeedingPromotion","nutritionalPromotion","nutritionalStatus","accidentPreventionPromotion","oralHealth","oralHealthPromotion","trackOphthalmologicalProblems","trackHearingProblems","trackMetabolicProblems","mentalHealth"]
