module System.Envsub where

import Effect.Uncurried (EffectFn1)

foreign import populate :: EffectFn1 String String
