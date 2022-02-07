module Web.View.Adults.Index where
import Web.View.Prelude

data IndexView = IndexView { adults :: [Adult]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewAdultAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Adult</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach adults renderAdult}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Adults" AdultsAction
                ]

renderAdult :: Adult -> Html
renderAdult adult = [hsx|
    <tr>
        <td>{adult}</td>
        <td><a href={ShowAdultAction (get #id adult)}>Show</a></td>
        <td><a href={EditAdultAction (get #id adult)} class="text-muted">Edit</a></td>
        <td><a href={DeleteAdultAction (get #id adult)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]