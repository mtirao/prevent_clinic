module Web.View.Obstetrics.Edit where
import Web.View.Prelude

data EditView = EditView { obstetric :: Obstetric }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Obstetric</h1>
        {renderForm obstetric}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Obstetrics" ObstetricsAction
                , breadcrumbText "Edit Obstetric"
                ]

renderForm :: Obstetric -> Html
renderForm obstetric = formFor obstetric [hsx|
    {(textField #patient)}
    {(textField #psychoprophylaxis)}
    {(textField #nutritionalStatus)}
    {(textField #nutritionalStatusTreatment)}
    {(textField #physicalActivityPrescription)}
    {(textField #immunization)}
    {(textField #perinatalInvestigations)}
    {(textField #breastfeeding)}
    {(textField #itsPromotion)}
    {(textField #problematicConsumption)}
    {submitButton}

|]