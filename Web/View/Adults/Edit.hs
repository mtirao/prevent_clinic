module Web.View.Adults.Edit where
import Web.View.Prelude

data EditView = EditView { adult :: Adult }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Adult</h1>
        {renderForm adult}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Adults" AdultsAction
                , breadcrumbText "Edit Adult"
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