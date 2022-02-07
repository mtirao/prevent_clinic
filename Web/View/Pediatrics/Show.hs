module Web.View.Pediatrics.Show where
import Web.View.Prelude

data ShowView = ShowView { pediatric :: Pediatric }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Pediatric</h1>
        <p>{pediatric}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Pediatrics" PediatricsAction
                            , breadcrumbText "Show Pediatric"
                            ]