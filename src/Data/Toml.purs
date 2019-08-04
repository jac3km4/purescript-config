module Data.Toml(parse, ParseError (..)) where

import Prelude

import Data.Either (Either(..))
import Data.Function.Uncurried (Fn3, runFn3)
import Foreign (Foreign)

newtype ParseError = ParseError String
derive newtype instance eqParseError :: Eq ParseError
derive newtype instance showParseError :: Show ParseError

foreign import _parse
    :: Fn3 (ParseError -> Either ParseError Foreign)
           (Foreign -> Either ParseError Foreign)
           String
           (Either ParseError Foreign)

parse :: String -> Either ParseError Foreign
parse = runFn3 _parse Left Right
