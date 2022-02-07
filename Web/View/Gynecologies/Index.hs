module Web.View.Gynecologies.Index where
import Web.View.Prelude

data IndexView = IndexView { gynecologies :: [Gynecology]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewGynecologyAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Gynecology</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach gynecologies renderGynecology}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Gynecologies" GynecologiesAction
                ]

renderGynecology :: Gynecology -> Html
renderGynecology gynecology = [hsx|
    <tr>
        <td>{gynecology}</td>
        <td><a href={ShowGynecologyAction (get #id gynecology)}>Show</a></td>
        <td><a href={EditGynecologyAction (get #id gynecology)} class="text-muted">Edit</a></td>
        <td><a href={DeleteGynecologyAction (get #id gynecology)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]