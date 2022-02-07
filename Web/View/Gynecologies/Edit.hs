module Web.View.Gynecologies.Edit where
import Web.View.Prelude

data EditView = EditView { gynecology :: Gynecology }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Gynecology</h1>
        {renderForm gynecology}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Gynecologies" GynecologiesAction
                , breadcrumbText "Edit Gynecology"
                ]

renderForm :: Gynecology -> Html
renderForm gynecology = formFor gynecology [hsx|
    {(textField #cevicouterinoTracking)}
    {(textField #lastPapResult)}
    {(textField #contraception)}
    {(textField #trackingIts)}
    {(textField #teenBoarding)}
    {(textField #hpvImmunization)}
    {(textField #patient)}
    {submitButton}

|]