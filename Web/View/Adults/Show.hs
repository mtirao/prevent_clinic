module Web.View.Adults.Show where
import Web.View.Prelude

data ShowView = ShowView { adult :: Adult }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Adult</h1>
        <p>{adult}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Adults" AdultsAction
                            , breadcrumbText "Show Adult"
                            ]