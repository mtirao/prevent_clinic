module Web.View.Gynecologies.Show where
import Web.View.Prelude

data ShowView = ShowView { gynecology :: Gynecology }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Gynecology</h1>
        <p>{gynecology}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Gynecologies" GynecologiesAction
                            , breadcrumbText "Show Gynecology"
                            ]