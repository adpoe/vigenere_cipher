-- A Vigenere Cipher
module Cipher where
import Data.Char
import Data.List

baseUnicode = ord 'A'
endUnicode  = ord 'z'
modValue    = endUnicode - baseUnicode

-- Functions to encode
matchKeyWord :: [Char] -> [Char] -> [(Char, Int)]
matchKeyWord key text =  zip text infiniKey
  where infiniKey = keyWordMapping key

keyWordMapping :: [Char] -> [Int]
keyWordMapping xs = cycle (map ord xs)

cipherLetter :: [(Char, Int)] -> [Char]
cipherLetter []            = []
cipherLetter ((c,n):xs) =  (singleShift c n) : cipherLetter xs

singleShift :: Char -> Int -> Char
singleShift c n = shiftedChar
  where charAsInt   = ord c
        shiftedInt  = ((charAsInt + n) `mod` (baseUnicode + modValue))
        shiftedChar = chr shiftedInt

vigenere :: [Char] -> [Char]-> [Char] -- Pipeline matchKeyWord into cipherLetter...
vigenere key txt =  cipherLetter (matchKeyWord  key txt)


-- Functions to decode
unMatchKeyWord :: [Char] -> [Char] -> [(Char, Int)]
unMatchKeyWord key txt  =  zip txt inifiKey
  where inifiKey = keyWordMapping key

unShift :: Char -> Int -> Char
unShift c n = shiftedChar
  where charAsInt   = ord c
        shiftedInt  = ((charAsInt - n) `mod` (baseUnicode + modValue))
        shiftedChar = chr shiftedInt

unCipherLetter :: [(Char, Int)] -> [Char]
unCipherLetter []            = []
unCipherLetter ((c,n):xs) =  (unShift c n) : unCipherLetter xs

unVigenere :: [Char] -> [Char] -> [Char]
unVigenere key txt =  unCipherLetter (unMatchKeyWord  key txt)
