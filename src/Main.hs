{-
 -  bitmap - A TUI bitmap editor
 -  Copyright (C) 2023  Carter "pyrotelekinetic" Ison <carter@isons.org>
 -
 -  This program is free software: you can redistribute it and/or modify
 -  it under the terms of the GNU Affero General Public License as published by
 -  the Free Software Foundation, either version 3 of the License, or
 -  (at your option) any later version.
 -
 -  This program is distributed in the hope that it will be useful,
 -  but WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 -  GNU Affero General Public License for more details.
 -
 -  You should have received a copy of the GNU Affero General Public License
 -  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 -}

import Data.Array.Unboxed

type Bitmap = Array (Int, Int) Bool

testBM :: Bitmap
testBM = listArray ((0, 0), (8, 8)) (True : False : False : True : repeat False)

main = do
  mapM (putStrLn . draw . uncurry zip) . thing $ getRows testBM

getRows :: Bitmap -> [[Bool]]
getRows fa = [[fa ! (i, j) | i <- [0..xb]] | j <- [0..yb]]
  where (_, (xb, yb)) = bounds fa

thing :: [[a]] -> [([a], [a])]
thing [] = [([], [])]
thing [a] = [(a, [])]
thing [a, b] = [(a, b)]
thing (a : b : xs) = (a, b) : thing xs

draw :: [(Bool, Bool)] -> String
draw [] = ""
draw ((False, False) : xs) = ' ' : draw xs
draw ((False, True) : xs) = '\x2584' : draw xs
draw ((True, False) : xs) = '\x2580' : draw xs
draw ((True, True) : xs) = '\x2588' : draw xs
