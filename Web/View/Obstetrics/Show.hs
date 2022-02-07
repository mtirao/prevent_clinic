module Web.View.Obstetrics.Show where
import Web.View.Prelude

data ShowView = ShowView { obstetric :: Obstetric }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Obstetric</h1>
        <p>{obstetric}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Obstetrics" ObstetricsAction
                            , breadcrumbText "Show Obstetric"
                            ]