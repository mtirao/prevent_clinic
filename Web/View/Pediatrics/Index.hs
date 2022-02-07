module Web.View.Pediatrics.Index where
import Web.View.Prelude

data IndexView = IndexView { pediatrics :: [Pediatric]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewPediatricAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Pediatric</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach pediatrics renderPediatric}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Pediatrics" PediatricsAction
                ]

renderPediatric :: Pediatric -> Html
renderPediatric pediatric = [hsx|
    <tr>
        <td>{pediatric}</td>
        <td><a href={ShowPediatricAction (get #id pediatric)}>Show</a></td>
        <td><a href={EditPediatricAction (get #id pediatric)} class="text-muted">Edit</a></td>
        <td><a href={DeletePediatricAction (get #id pediatric)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]