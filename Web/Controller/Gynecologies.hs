module Web.Controller.Gynecologies where

import Web.Controller.Prelude
import Web.View.Gynecologies.Index
import Web.View.Gynecologies.New
import Web.View.Gynecologies.Edit
import Web.View.Gynecologies.Show

instance ToJSON Gynecology where
    toJSON gynecology = object
        [ "id" .= get #id gynecology
        ]

instance Controller GynecologiesController where
    action GynecologiesAction = do
        gynecologies <- query @Gynecology |> fetch
        render IndexView { .. }

    action NewGynecologyAction = do
        let gynecology = newRecord
        render NewView { .. }

    action ShowGynecologyAction { gynecologyId } = do
        gynecology <- fetch gynecologyId
        render ShowView { .. }

    action EditGynecologyAction { gynecologyId } = do
        gynecology <- fetch gynecologyId
        render EditView { .. }

    action UpdateGynecologyAction { gynecologyId } = do
        gynecology <- fetch gynecologyId
        gynecology
            |> buildGynecology
            |> ifValid \case
                Left gynecology -> render EditView { .. }
                Right gynecology -> do
                    gynecology <- gynecology |> updateRecord
                    setSuccessMessage "Gynecology updated"
                    redirectTo EditGynecologyAction { .. }

    action CreateGynecologyAction = do
        let gynecology = newRecord @Gynecology
        gynecology
            |> buildGynecology
            |> ifValid \case
                Left gynecology -> render NewView { .. } 
                Right gynecology -> do
                    gynecology <- gynecology |> createRecord
                    setSuccessMessage "Gynecology created"
                    redirectTo GynecologiesAction

    action DeleteGynecologyAction { gynecologyId } = do
        gynecology <- fetch gynecologyId
        deleteRecord gynecology
        setSuccessMessage "Gynecology deleted"
        redirectTo GynecologiesAction

buildGynecology gynecology = gynecology
    |> fill @["cevicouterinoTracking","lastPapResult","contraception","trackingIts","teenBoarding","hpvImmunization","patient"]
