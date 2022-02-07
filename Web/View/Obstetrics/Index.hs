module Web.View.Obstetrics.Index where
import Web.View.Prelude

data IndexView = IndexView { obstetrics :: [Obstetric]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewObstetricAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Obstetric</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach obstetrics renderObstetric}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Obstetrics" ObstetricsAction
                ]

renderObstetric :: Obstetric -> Html
renderObstetric obstetric = [hsx|
    <tr>
        <td>{obstetric}</td>
        <td><a href={ShowObstetricAction (get #id obstetric)}>Show</a></td>
        <td><a href={EditObstetricAction (get #id obstetric)} class="text-muted">Edit</a></td>
        <td><a href={DeleteObstetricAction (get #id obstetric)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]