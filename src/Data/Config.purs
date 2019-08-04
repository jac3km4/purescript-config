module Data.Config
  ( loadConfig
  , loadConfigSync
  , module Toml
  ) where

import Prelude

import Data.Bifunctor (lmap)
import Data.Either (Either)
import Data.Toml (ParseError(..))
import Data.Toml (ParseError(..), parse) as Toml
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Uncurried (runEffectFn1)
import Node.Encoding (Encoding(..))
import Node.FS.Aff as Fs
import Node.FS.Sync as FsSync
import Node.Path (FilePath)
import Simple.JSON (class ReadForeign)
import Simple.JSON as SimpleJson
import System.Envsub as Envsub

loadConfig :: ∀ a. ReadForeign a => FilePath -> Aff (Either ParseError a)
loadConfig = liftEffect <<< parseConfig <=< Fs.readTextFile UTF8

loadConfigSync :: ∀ a. ReadForeign a => FilePath -> Effect (Either ParseError a)
loadConfigSync = parseConfig <=< FsSync.readTextFile UTF8

parseConfig :: ∀ a. ReadForeign a => String -> Effect (Either ParseError a)
parseConfig input = do
  contents' <- runEffectFn1 Envsub.populate input
  pure $ lmap (ParseError <<< show) <<< SimpleJson.read =<< Toml.parse contents'
