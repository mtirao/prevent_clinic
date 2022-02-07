module Web.View.Adults.New where
import Web.View.Prelude

data NewView = NewView { adult :: Adult }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Adult</h1>
        {renderForm adult}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Adults" AdultsAction
                , breadcrumbText "New Adult"
                ]

renderForm :: Adult -> Html
renderForm adult = formFor adult [hsx|
    {(textField #nutritionalValue)}
    {(textField #nutritionalMonitoring)}
    {(textField #bloodPressureSystolic)}
    {(textField #bloodPressureDiastolic)}
    {(textField #bloodPressureMonitoring)}
    {(textField #diabetes)}
    {(textField #glucoseMonitoring)}
    {(textField #diabetesTreatment)}
    {(textField #lipidDisorder)}
    {(textField #lipidDisorderMonitoring)}
    {(textField #lipidDisorderTreatment)}
    {(textField #immunization)}
    {(textField #smokingCessation)}
    {(textField #patient)}
    {submitButton}

|]