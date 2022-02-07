module Web.View.Pediatrics.Edit where
import Web.View.Prelude

data EditView = EditView { pediatric :: Pediatric }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Pediatric</h1>
        {renderForm pediatric}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Pediatrics" PediatricsAction
                , breadcrumbText "Edit Pediatric"
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