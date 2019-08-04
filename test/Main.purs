module Test.Main where

import Prelude

import Data.Config (ParseError)
import Data.Config as Config
import Data.Either (Either(..))
import Effect (Effect)
import Test.Assert (assertEqual)

type Config =
  { title :: String
  , owner :: { name :: String, organization :: String }
  , database :: { server :: String, ports :: Array Int, enabled :: Boolean, password :: String }
  }

main :: Effect Unit
main = do
  actual <- readConfig
  assertEqual
    { actual
    , expected: Right
        { title: "TOML Example"
        , owner: { name: "Tom Preston-Werner", organization: "GitHub" }
        , database:
            { server: "192.168.1.1"
            , ports: [ 8001, 8001, 8002 ]
            , enabled: true
            , password: "dummy"
            }
        }
    }
  where
    readConfig :: Effect (Either ParseError Config)
    readConfig = Config.loadConfigSync "test/config.toml"
