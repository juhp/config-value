{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE DeriveDataTypeable #-}

-- | This module provides the types used in this package for configuration.
-- Visit "ConfigFile.Parser" to parse values of this type in a convenient
-- layout based notation.
module Config.Value
  ( Section(..)
  , Value(..)
  , Atom(..)
  ) where

import Data.Text    (Text)
import Data.Data    (Data, Typeable)
import Data.String  (IsString(..))
import GHC.Generics (Generic)

-- | A single section of a 'Value'
data Section = Section
  { sectionName  :: Text
  , sectionValue :: Value
  }
  deriving (Eq, Read, Show, Typeable, Data, Generic)

-- | Wrapper to distinguish 'Atom' from 'Text' by
-- type in a configuration.
newtype Atom = MkAtom { atomName :: Text }
  deriving (Eq, Ord, Show, Read, Typeable, Data, Generic)

instance IsString Atom where
  fromString = MkAtom . fromString

-- | Sum type of the values supported by this language.
data Value
  = Sections [Section]
  | Number   Int Integer -- ^ base number
  | Text     Text
  | Atom     Atom
  | List     [Value]
  deriving (Eq, Read, Show, Typeable, Data, Generic)
