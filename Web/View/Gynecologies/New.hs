module Web.View.Gynecologies.New where
import Web.View.Prelude

data NewView = NewView { gynecology :: Gynecology }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Gynecology</h1>
        {renderForm gynecology}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Gynecologies" GynecologiesAction
                , breadcrumbText "New Gynecology"
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