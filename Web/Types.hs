module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data AdultsController
    = AdultsAction
    | NewAdultAction
    | ShowAdultAction { adultId :: !(Id Adult) }
    | CreateAdultAction
    | EditAdultAction { adultId :: !(Id Adult) }
    | UpdateAdultAction { adultId :: !(Id Adult) }
    | DeleteAdultAction { adultId :: !(Id Adult) }
    deriving (Eq, Show, Data)

data GynecologiesController
    = GynecologiesAction
    | NewGynecologyAction
    | ShowGynecologyAction { gynecologyId :: !(Id Gynecology) }
    | CreateGynecologyAction
    | EditGynecologyAction { gynecologyId :: !(Id Gynecology) }
    | UpdateGynecologyAction { gynecologyId :: !(Id Gynecology) }
    | DeleteGynecologyAction { gynecologyId :: !(Id Gynecology) }
    deriving (Eq, Show, Data)

data PediatricsController
    = PediatricsAction
    | NewPediatricAction
    | ShowPediatricAction { pediatricId :: !(Id Pediatric) }
    | CreatePediatricAction
    | EditPediatricAction { pediatricId :: !(Id Pediatric) }
    | UpdatePediatricAction { pediatricId :: !(Id Pediatric) }
    | DeletePediatricAction { pediatricId :: !(Id Pediatric) }
    deriving (Eq, Show, Data)

data ObstetricsController
    = ObstetricsAction
    | NewObstetricAction
    | ShowObstetricAction { obstetricId :: !(Id Obstetric) }
    | CreateObstetricAction
    | EditObstetricAction { obstetricId :: !(Id Obstetric) }
    | UpdateObstetricAction { obstetricId :: !(Id Obstetric) }
    | DeleteObstetricAction { obstetricId :: !(Id Obstetric) }
    deriving (Eq, Show, Data)
