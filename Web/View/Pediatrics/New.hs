module Web.View.Pediatrics.New where
import Web.View.Prelude

data NewView = NewView { pediatric :: Pediatric }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Pediatric</h1>
        {renderForm pediatric}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Pediatrics" PediatricsAction
                , breadcrumbText "New Pediatric"
                ]

renderForm :: Pediatric -> Html
renderForm pediatric = formFor pediatric [hsx|
    {(textField #immunization)}
    {(textField #breastfeeding)}
    {(textField #patient)}
    {(textField #breastfeedingPromotion)}
    {(textField #nutritionalPromotion)}
    {(textField #nutritionalStatus)}
    {(textField #accidentPreventionPromotion)}
    {(textField #oralHealth)}
    {(textField #oralHealthPromotion)}
    {(textField #trackOphthalmologicalProblems)}
    {(textField #trackHearingProblems)}
    {(textField #trackMetabolicProblems)}
    {(textField #mentalHealth)}
    {submitButton}

|]