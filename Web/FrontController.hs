module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.ObstetricsApi
import Web.Controller.Obstetrics
import Web.Controller.PediatricsApi
import Web.Controller.Pediatrics
import Web.Controller.GynecologiesApi
import Web.Controller.Gynecologies
import Web.Controller.AdultsApi
import Web.Controller.Adults
import Web.Controller.Static

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @ObstetricApiController
        , parseRoute @ObstetricsController
        , parseRoute @PediatricsController
        , parseRoute @GynecologiesController
        , parseRoute @AdultsController
        , parseRoute @AdultsApiController
        , parseRoute @GynecologiesApiController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
