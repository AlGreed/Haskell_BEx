Aufgabe 6
=========

Thema: Rekursive Funktionen, Testen mit HUnit

> module Uebung6 where

> -- Prelude importieren und dabei die Funktionen
> -- take, (!!), concat und elem verstecken (für Aufgabenteil I)
> import Prelude hiding (take, (!!), concat, elem)

> -- Prelude "eingeschränkt" importieren, um etwa mit "Prelude.take"
> -- oder "Prelude.!!" die entsprechenden Funktionen doch nutzen zu können.
> import qualified Prelude

> -- Testing framework für Haskell importieren (für Aufgabenteil II):
> -- http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide
> import Test.HUnit


I: Rekursive Funktionen
-----------------------

1) Definiert die folgenden Funktionen rekursiv.
   Geht dabei nach dem in der Vorlesung behandelten "Rezept" vor, wobei die
   einzelnen Schritte alle anzugeben sind (Schritte 2-4 als Kommentar, da diese
   ja noch nicht vollständig sind und Schritt 5 als Codeabschnitt).
   Die Funktionen sollen sich genauso verhalten, wie die aus der Prelude.
   Probiert ggf. mit diesen ein wenig herum um zu sehen, wie sie sich in
   Sonderfällen (wie etwa der leeren Liste oder negativen Indizes) verhalten.

a) take :: Int -> [a] -> [a]
-------------------------

(1) Definition des Typs

> take :: Int -> [a] -> [a]


(2) Aufzählen der Fallunterscheidungen
1. n <= 0 ->> leere Menge
2. n >= length von [a] ->>> [a]
3. a ist leer ->>> leere Menge
4. n < length ->>> n first elements 

(3) Definition der einfachen Fälle
take n l | null l = []
         | n <= 0 = []
         | (length l) <= n = l


(4) Definition der rekursiven Fälle
take n (x:xs) = x ++ (take (n-1) xs ) 


(5) Zusammenfassen und verallgemeinern

> take n l
>	 | ((null l) || (n <= 0)) = []
>	 | n >= (length l) = l
>	 | otherwise = [head l] ++ (take (n-1) (tail l))


b) concat :: [[a]] -> [a]
-------------------------

(1) Definition des Typs

> concat :: [[a]] -> [a]


(2) Aufzählen der Fallunterscheidungen
1. concat []
2. concat [[a], ...]


(3) Definition der einfachen Fälle
concat [] = []

(4) Definition der rekursiven Fälle
concat x = [head x] ++ concat (tail x) 


(5) Zusammenfassen und verallgemeinern

> concat l 
>        | null l = []
>        | otherwise = head l ++ concat (tail l)



c) elem :: Eq a => a -> [a] -> Bool
-----------------------------------

(1) Definition des Typs

> elem :: Eq a => a -> [a] -> Bool 


(2) Aufzählen der Fallunterscheidungen
True oder False


(3) Definition der einfachen Fälle
elem x [] = False
elem x [x] = True

(4) Definition der rekursiven Fälle
elem x l = elem x (tail l)


(5) Zusammenfassen und verallgemeinern

> elem x l
>        | null l = False 
>        | x == (head l) = True
>        | otherwise = elem x (tail l)   




d) (!!) :: [a] -> Int -> a
--------------------------

(1) Definition des Typs

> (!!) :: [a] -> Int -> a

(2) Aufzählen der Fallunterscheidungen
Error oder Element

(3) Definition der einfachen Fälle
(!!) l x | x < 0 = error "negative index"
(!!) l x | ((null l) || (x >= length l)) = error "index too large"
(!!) l x | x == 0 = head l


(4) Definition der rekursiven Fälle
(!!) l x = (!!) (tail l) (x-1)


(5) Zusammenfassen und verallgemeinern

> (!!) l x 
>        | x < 0 = error "negative index"
>        | ((null l) || (x >= length l)) = error "index too large"
>        | x == 0 = head l
>        | otherwise = (!!) (tail l) (x-1)



2) Die folgende Funktion "reduce" reduziert eine natürliche Zahl n nach den
   Regeln:
     - Wenn n gerade ist, so wird n halbiert und
     - wenn n ungerade ist, so wird n verdreifacht und um 1 erhöht.

> reduce :: Integer -> Integer
> reduce n | even n    = n `div` 2
>          | otherwise = n * 3 + 1

   Wendet man nun die Funktion wiederholt auf ihr Resultat an, erhält man bei
   einem Startwert von beispielsweise 5 die Folge:
     5, 16, 8, 4, 2, 1, 4, 2, 1, 4, 2, 1, ...

   a) Definiert nun eine rekursive Funktion "collatz :: Integer -> Integer", die
      zählt wieviele Schritte benötigt werden, um eine Zahl n mit der gegebenen
      Funktion "reduce" zum ersten Mal auf 1 zu reduzieren.
      Beispiele:
        collatz  5  =  5
        collatz 16  =  4
        collatz  8  =  3
        collatz  4  =  2

> collatz :: Integer -> Integer
> collatz n = collatz' n 0
>             where 
>               collatz' n z
>                   | n == 1 = z
>                   | otherwise = collatz' (reduce n) (z+1) 

   b) Ist eure collatz-Funktion linearrekursiv? Und woran erkennt man dies?
Ja,  Bei jedem Schritt kommt nur ein rekursiver Aufruf vor.


3) Gegeben sind zwei Funktionen zur Berechnung der Fibonacci-Zahlen:

> fib   :: Integer -> Integer
> fib 0 = 0
> fib 1 = 1
> fib n = fib (n-1) + fib (n-2)

> fib2 :: Integer -> Integer
> fib2 x = fst (fib2' x)
>          where fib2' 0 = (0, 0)
>                fib2' 1 = (1, 0)
>                fib2' n = (l + p, l)
>                          where (l, p) = fib2' (n-1)

   a) Was für Arten von Rekursion verwenden die beiden Funktionen?
      (mehrfache Rekursion, wechselseitige Rekursion, Linearrekursion, ...)
      Und woran erkennt man dies?
	1. Kaskadenförmige Rekursion (mehrere rekursive Aufrufe nebeneinander stehen)
        2. Wechselseitige Rekursion


   b) Welche Funktion ist effizienter? Und wieso?
Die zweite Variante is effizienter. Im ersten Fall werden die gleichen Fibonachi-Werte mehrfach berechnet. 


   c) Wie oft wird die Funktion fib rekursiv aufgerufen, wenn "fib 4" berechnet
      werden soll?
fib 4 = fib 3 + fib 2 = (fib 2 + fib 1) + (fib 1 + fib 0) = fib 1 + fib 0 + fib 1 + fib 1 + fib 0 ->>> 8 times



   d) Wie sieht der genaue Funktionstyp der rekursiven Hilfsfunktion fib2' aus?
      Überlegt Euch dies anhand des Aufrufs in fib2 und des gegebenen Typs.
fib2' :: Int -> (Int, Int) 


   e) Wie funktioniert fib2 und wozu dient hierbei die Hilfsfunktion fib2'?
      (Welche Bedeutung haben die beiden Komponenten des Tupels?)
(aktueller Wert, Zwischenspeicher) -> Inzwischen wird jedes Mal zweites Element weggeschmiessen  fst(fib2' x)



II: Testen mit HUnit
--------------------

1) Mit der Testumgebung HUnit können leicht Tests erstellt werden um
   automatisiert prüfen zu können, ob sich bestimmte Funktionen wie geplant
   verhalten.

   Die folgenden Zeilen definieren eine Liste mit Testfällen, die bei einem
   Aufruf von "runTest" alle ausgeführt werden.
   Ein Testfall besteht dabei jeweils aus einer kurzen Beschreibung sowie zwei
   Ausdrücken, die erst ausgewertet und dann miteinander verglichen werden:
     testbeschreibung  ~:  zu_testender_ausdruck  ~?=  erwarteter_ausdruck

   Die Operatoren ~: und ~?= sind in HUnit definiert und dienen der einfacheren
   Erzeugung von Testfällen. Es gibt auch noch weitere Möglichkeiten, schaut
   hierfür ggf. auch mal in die Dokumentation von HUnit:
     http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide

> runTest = runTestTT (test testListe)
>   where testListe =
>           [
>           -- Tests für die take-Funktion aus der Prelude (zur Demonstration von HUnit)
>             "take mit  0 und leerer Liste"  ~:  Prelude.take 0 ""        ~?=  ""
>           , "take mit  0 und voller Liste"  ~:  Prelude.take 0 "123"     ~?=  ""
>           , "take mit  2 und leerer Liste"  ~:  Prelude.take 2 ""        ~?=  ""
>           , "take mit  2 und voller Liste"  ~:  Prelude.take 2 "123"     ~?=  "12"
>           , "take mit  4 und voller Liste"  ~:  Prelude.take 4 "123"     ~?=  "123"
>           , "take mit -1 und leerer Liste"  ~:  Prelude.take (-1) ""     ~?=  ""
>           , "take mit -1 und voller Liste"  ~:  Prelude.take (-1) "123"  ~?=  ""
>
>           -- ...
>
>           ]
>           where leereIntListe :: [Int]
>                 leereIntListe = []

   a) Überlegt Euch sinvolle Testfälle für die vier Funktionen aus Aufgabe I.1)
      und erweitert den HUnit Test entsprechend. Achtet dabei auch auf
      Sonderfälle, wie leere Listen, negativen Indizes, usw.

> checkFunctions = runTestTT (test testListe)
>   where testListe =
>           [
>           -- Tests für die take-Funktion
>             "take mit  0 und leerer Liste"  ~:  take 0 ""        ~?=  ""
>           , "take mit  0 und voller Liste"  ~:  take 0 "123"     ~?=  ""
>           , "take mit  2 und leerer Liste"  ~:  take 2 ""        ~?=  ""
>           , "take mit  2 und voller Liste"  ~:  take 2 "123"     ~?=  "12"
>           , "take mit  4 und voller Liste"  ~:  take 4 "123"     ~?=  "123"
>           , "take mit -1 und leerer Liste"  ~:  take (-1) ""     ~?=  ""
>           , "take mit -1 und voller Liste"  ~:  take (-1) "123"  ~?=  ""
>
>           -- concat
>           , "concat mit 2 lists"  ~:  concat [[1],[0]]  ~?=  Prelude.concat [[1],[0]]
>           , "concat mit 1 und  leerer Liste"  ~:  concat [[1],[]]  ~?=  Prelude.concat [[1],[]]
>           , "concat mit leerer Liste und not leeren"  ~:  concat ["", "abc"]  ~?=  "abc"
>           , "concat leere Listen"  ~: (null (concat [[]]))  ~?=  True         
> 
>           -- elem
>           , "elem 1"  ~:  elem 'a' "bac"  ~?=  Prelude.elem 'a' "bac"
>           , "elem 2"  ~:  elem 'a' ""  ~?=  Prelude.elem 'a' ""
>           , "elem 3"  ~:  elem (-5) [4,5,-5]  ~?=  Prelude.elem (-5) [4,5,-5]
>           , "elem 5"  ~:  elem (-5) [4,5]  ~?=  Prelude.elem (-5) [4,5]
>           , "elem 6"  ~:  elem 'a' "zzz"  ~?=  Prelude.elem 'a' "zzz"
>
>           -- (!!)
>           , "(!!) Positive case 1"  ~:  (!!) "abc" 2  ~?=  'c'
>           , "(!!) Positive case 2"  ~:  (!!) "abc" 0  ~?=  'a'


		Klappt nicht, errors abzufangen... 
		 , "(!!) 1"  ~:   do
 			 handleJust errorCalls (\_ -> return ()) performCall
			 where
   				 performCall = do
     				 evaluate ((!!) "abc" 0 )
     				 assertFailure "index too large"
                       
>
>           ]
>           where leereIntListe :: [Int]
>                 leereIntListe = []


   b) Korrigiert eure Implementierungen, falls sich diese nicht immer wie
      erwartet verhalten.

   c) Optional:
      Versucht (beispielsweise mit Hilfe von Listkomprehensions) kombinatorisch
      Testfälle für eine Funktion zu generieren.
