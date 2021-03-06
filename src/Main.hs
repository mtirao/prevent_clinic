module Main where

import Db as Db

import Domain
import Views

import AdultsController
import GynecologiesController
import ObstetricsController
import PediatricsController
import PatientsController

import qualified Data.Configurator as C
import qualified Data.Configurator.Types as C
import qualified Data.Text.Lazy as TL
import Data.Pool(createPool)
import Data.Aeson

import Web.Scotty
import Web.Scotty.Internal.Types (ActionT)

import Database.PostgreSQL.Simple


import Network.Wai.Middleware.Static
import Network.Wai.Middleware.RequestLogger (logStdout)
import Network.HTTP.Types.Status

-- Parse file "application.conf" and get the DB connection info
makeDbConfig :: C.Config -> IO (Maybe DbConfig)
makeDbConfig conf = do
    dbConfname <- C.lookup conf "database.name" :: IO (Maybe String)
    dbConfUser <- C.lookup conf "database.user" :: IO (Maybe String)
    dbConfPassword <- C.lookup conf "database.password" :: IO (Maybe String)
    dbConfHost <- C.lookup conf "database.host" :: IO (Maybe String)
    return $ DbConfig <$> dbConfname
                    <*> dbConfUser
                    <*> dbConfPassword
                    <*> dbConfHost


main :: IO ()
main = do
    loadedConf <- C.load [C.Required "application.conf"]
    dbConf <- makeDbConfig loadedConf
    
    case dbConf of
        Nothing -> putStrLn "No database configuration found, terminating..."
        Just conf -> do      
            pool <- createPool (newConn conf) close 1 40 10
            scotty 3200 $ do
                middleware $ staticPolicy (noDots >-> addBase "static") -- serve static files
                middleware $ logStdout    
                
                -- ADULTS
                post "/api/prevent/adult" $ createAdult pool
                get "/api/prevent/adults/:id" $ do
                                                    idd <- param "id" :: ActionM TL.Text
                                                    listAdultsForPatient pool idd
                get "/api/prevent/adult/last" $ findNewer pool
                get "/api/prevent/adult/:id" $ do 
                                                idd <- param "id" :: ActionM TL.Text
                                                getAdult pool idd

                -- GYNECOLOGIES
                post "/api/prevent/gynecology" $ createGynecology pool
                get "/api/prevent/gynecoloies" $ listGynecology pool

                -- OBSTETRICS
                post "/api/prevent/obstetric" $ createObstetric pool
                get "/api/prevent/obstetrics" $ listObstetric pool

                -- PEDIATRICS
                post "/api/prevent/pediatric" $ createPediatric pool
                get "/api/prevent/pediatrics" $ listPediatric pool

                -- PATIENTS
                get "/api/prevent/new/patients" $ listPatients pool