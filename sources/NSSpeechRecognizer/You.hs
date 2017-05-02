{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module NSSpeechRecognizer.You where
import NSSpeechRecognizer
import Workflow.OSX.C -- qualified .Bindings as C

import Data.Foldable
import System.Environment
import Control.Monad (forever)
import Control.Exception (throwIO,AsyncException(..))
import Control.Concurrent(threadDelay)

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
  printHelp
  recognizeVoiceMap yourCommands

printHelp = do
  putStrLn "Listening for:"
  traverse_ putStrLn (fmap fst yourCommands)

pause t = threadDelay (t*1000) -- milliseconds

{-

The expression:

@
[ "phrase" -: action
]
@

means that when a "phrase" is heard, its `action` is executed.

(-:) is just the pair constructor (,)

-}
yourCommands = self
  where
  vocab = fmap fst self
  self =
    [ "test"-: putStrLn "listening test succeeds"
    , "stop listening"-: throwIO UserInterrupt
    , "help"-: printHelp
    , "switch"-: do
      pressKey (NX_COMMANDMASK) VK_Tab
      pause 10
      pressKey 0 VK_Return
    , "" -: return ()
    ]
