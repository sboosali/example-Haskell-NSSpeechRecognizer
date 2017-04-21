{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module NSSpeechRecognizer.You where
import NSSpeechRecognizer

import System.Environment
import Control.Monad (forever) 
import Control.Exception (throwIO,AsyncException(..))
import qualified Data.Map as Map
import Data.Map (Map)

{-|
@
stack build && stack exec -- example-Haskell-NSSpeechRecognizer
@
-}
main :: IO ()
main = do
 arguments <- getArgs
 mainWith arguments

mainWith args = do
 putStrLn "Listening for:"
 traverse_ putStrLn (Map.keys yourCommands)
 
 recognizeVoiceMap yourCommands

{-

The expression:

@
[ "phrase" -: action
]
@

means that when a "phrase" is heard, its `action` is executed.

(-:) is just the pair constructor (,)

-}
yourCommands =
   [ "test"-: putStrLn "listening test succeeds" 
   , "stop listening"-: throwIO UserInterrupt
   ]

