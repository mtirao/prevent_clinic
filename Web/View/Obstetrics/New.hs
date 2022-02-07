module Web.View.Obstetrics.New where
import Web.View.Prelude

data NewView = NewView { obstetric :: Obstetric }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Obstetric</h1>
        {renderForm obstetric}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Obstetrics" ObstetricsAction
                , breadcrumbText "New Obstetric"
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