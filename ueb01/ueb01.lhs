Aufgabe 1
=========

Thema: Ausdrücke und Typen

Aufgabenstellung
----------------

In dieser ersten Aufgabe wollen wir uns mit einfachen Ausdrücken und deren Typen
beschäftigen.
Hierfür sind ein paar Werte vorgegeben, für die ihr die Typen bestimmen sollt.


I. Einfache Ausdrücke
---------------------

Überlegt euch für die folgenden 14 Ausdrücke, welchen Typ sie jeweils besitzen.

Tipp: Zwei der Ausdrücke sind ungültig.
Welche sind das und wieso sind sie ungültig?

Beispiel:

   -  '7' :: Char

Aufgaben:

   1. True                       :: Bool
   2. "True"                     :: [Char]
   3. [False, False, True]       :: [Bool] -- vorher [Char]
   4. ['5', '6', '7']            :: [Char]
   5. ["55", "66", "77"]         :: [[Char]]
   6. ("False", [False])         :: ([Char], [Bool])
   7. [('a', "b"), ('A', "B")]   :: [(Char, [Char])]
   8. [5, 6, 7]                  :: Num t => [t] or just [Int]
   9. [0, '0', 'O']              :: ungültig, listen dürfen nur homogene Elemente enthalten
  10. [[], ['a'], ['b', 'c']]    :: [[Char]]
  11. [['f', 'o', 'o'], "bar"]   :: [[Char]]
  12. (length, "length")         :: ([a] -> Int, [Char]) -- vorher (Int, [Char])
  13. [length, head]             :: [[Int] -> Int] -- length [a]-> Int  && head [a]-> a  && "All elements in array have the same type"
  14. blub                       :: ungültig, so ein Datentyp ist nicht deklariert.

Kontrolliert anschließend eure Ergebnisse mit dem ghci.
Dies ist mit dem Befehl :type möglich.


II. Funktionen
--------------

Analog zur vorherigen Aufgabe sind nun die Typen einiger Funktionen zu
bestimmen.

Beispiel:

    head :: [a] -> a
    head (x:xs) = x

Funktionsdefinitionen:

> copyMe :: [a] -> [a]
> copyMe xs       = xs ++ xs

> boxIt :: (a, b) -> ([a],[b])
> boxIt (x, y)    = ([x], [y])
    
> isSmall :: Int -> Bool
> isSmall n       = n < 10

> pair :: a -> b -> (a,b) 
> pair x y        = (x, y)

> toList :: (a,a) -> [a] 
> toList (x, y)   = [x, y]

> blp :: Bool -> [Bool]
> blp x           = toList (pair x True)

> apply :: (a -> b) -> a -> b
> apply f x       = f x

> plus1 :: Num a => a -> a  
> plus1 n         = 1 + n

> splitAtPos :: Int -> [a] -> ([a],[a])
> splitAtPos n xs = (take n xs, drop n xs)


III. Beweise
------------

Die Funktionen sum und prod seien wie folgt definiert:

    sum []     = 0
    sum (x:xs) = x + sum xs

    prod []     = 1
    prod (x:xs) = x * prod xs


mithilfe von Äquivalenzumformungen kann man beispielsweise zeigen,
dass prod [6,7] = 42 gilt:

        prod [6,7]
    <=> prod (6:7:[])     Liste nur anders aufgeschrieben
    <=> 6 * prod (7:[])   Definition von 'prod' angewendet
    <=> 6 * 7 * prod []   Definition von 'prod' angewendet
    <=> 42 * prod []      Definition von '*' angewendet
    <=> 42 * 1            Definition von 'prod' angewendet
    <=> 42                Definition von '*' angewendet

Zeigt nun mithilfe von Äquivalenzumformungen, dass folgende Aussagen gelten:

  1. sum [3,4,5] = 12
    <=> sum (3:4:5:[])     Liste nur anders aufgeschrieben
    <=> 3 + sum (4:5:[])   Definition von 'sum' angewendet
    <=> 3 + 4 + sum (5:[]) Definition von 'sum' angewendet
    <=> 3 + 4 + 5 + sum [] Definition von 'sum' angewendet
    <=> 12 + sum []        Definition von '+' angewendet
    <=> 12 + 0             Definition von 'sum' angewendet
    <=> 12                 Definition von '+' angewendet


  2. prod [x] = x   -- für alle Zahlen x
    <=> prod (x:[])     Liste nur anders aufgeschrieben
    <=> x * prod []      Definition von '*' angewendet
    <=> x * 1            Definition von 'prod' angewendet
    <=> x                Definition von '*' angewendet

gilt.


IV. freiwillige Zusatzaufgabe: Syntaxfehler
-------------------------------------------

Der folgende Ausschnitt enthält drei syntaktische Fehler.
Findet heraus welche dies sind und behebt sie.


> n = a `div` (length xs)
>    where
>       a = 10
>       xs = [1..5]

--vorher
N = a "div" length xs
    where
       a = 10
      xs = [1..5]
