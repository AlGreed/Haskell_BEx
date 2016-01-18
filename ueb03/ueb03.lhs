Aufgabe 3
=========

Thema: Funktionen, Guards, Muster


Benennung des Moduls für diese Aufgabe:

> module Ueb03 where

Das Standard Modul Prelude importieren und dabei die bereits vordefinierte
Funktion splitAt verstecken, um sie selbst implementieren zu können:

> import Prelude hiding (splitAt, (||), curry)


I. Definition einfacher Funktionen
----------------------------------

1) a) Was macht die Funktion "splitAt"?

> splitAt :: Int -> [a] -> ([a], [a])
> splitAt n xs  = (take n xs, drop n xs)

Sie nimmt einen int und eine Liste und gibt ein Paar von listen zurück. 
Im ersten Element des Paares sind alle Elemente der ursprünglichen Liste, deren index kleiner gleich dem int ist
Im zweiten Teil der Liste sind alle elemente, der index größer ist


   b) Definiert eine Funktion "splitHalf", die eine Liste
      mit einer geraden Länge in ein Paar mit zwei gleichlangen Listen aufteilt.
      Bei einer Liste mit ungerader Länger soll die erste Ergebnisliste um ein
      Element kürzer sein als die zweite (siehe Beispiel).
      Nutzt für die Definition die Funktion "splitAt" und weitere passende
      Funktionen aus dem Prelude-Modul.
      Beispiele:
        splitHalf [1,2,3,4]   ergibt   ([1,2], [3,4])
        splitHalf [1,2,3]     ergibt   ([1],   [2,3])

> splitHalf :: [a] -> ([a],[a])
> splitHalf xs = splitAt ((length xs) `div` 2) xs



2) Gesucht ist eine Funktion "evenLength", die entscheiden soll ob die Länge
   einer Liste (mit beliebigem Elementtyp) gerade ist oder nicht.
   Beispiele:
     evenLength [1,2,3]   ergibt   False
     evenLength [True, False]   ergibt   True

   a) Überlegt euch zunächst einen Typ für diese Funktion
   
> evenLength :: [a] -> Bool


   b) Definiert nun die Funktion "evenLength" unter Verwendung der Funktionen
      "length", "mod" und "(==)".
      Diese sind bereits im Standard Modul "Prelude" definiert und können daher
      einfach verwendet werden.
      (siehe auch https://hackage.haskell.org/package/base-4.8.1.0/docs/Prelude.html)
Warum so kompliziert? es gibt doch even^^ also ich finde meine erste Lösung schöner
 evenLength = \ x -> even $ length x

> evenLength = \ x -> mod (length x) 2 == 0

3) a) Schreibt eine Funktion "sndSnd :: (a, (b, c)) -> c", die aus zwei
      geschachtelten Paaren die zweite Komponente der zweiten Komponente
      zurückgibt. Nutzt hierfür nur Funktionen aus der Prelude.
      Beispiele:
        sndSnd (1, (2, 3))   ergibt   3
        sndSnd ((3,4.5,6), ('x', [True]))   ergibt   [True]

> sndSnd :: (a, (b, c)) -> c
> sndSnd tup = snd (snd tup)

   b) Ist diese Funktion total oder partiell?
      Begründet eure Antwort.

-- Totale Funktion. Totale Funktion is nicht mit dem Wertebereich beschränkt.

4) Entwickelt eine Funktion "firstIndex", die das erste Element einer Liste
   nimmt und damit das n-te Element (bei 0 angefangen zu zählen) der selben
   Liste auswählt.
   Fehlerhafte Aufrufe (leere Listen) müssen (noch) nicht abgefangen werden.
   Beispiele:
     firstIndex [2,3,4,5,6]   ergibt   4
     firstIndex [0,3,4,5,6]   ergibt   0

   a) Welchen Elementtyp darf die Liste nur besitzen?
--  Int.

   b) Definiert nun die Funktion firstIndex.
      Verwendet auch hier nur Funktionen aus der Prelude.

> firstIndex ::  [Int] -> Int
> firstIndex [] = 0
> firstIndex [x] = x 
> firstIndex (x:xs) = (x:xs) !! x 


   c) Was passiert, wenn firstIndex mit einer leeren Liste aufgerufen wird?
      (Solltet ihr diesen Fall in eurer Implementierung schon berücksichtigt
      haben, beschreibt was passiert, wenn ihr dies nicht getan hättet.)

-- Klar. Exception tritt auf, wenn der Pattern, der nicht definiert ist, aufgerufen wird. 
-- Im unseren Fall werden wir aber 0 bekommen.

   d) Was passiert, wenn firstIndex mit der Liste [1] aufgerufen wird?

-- Wieder, wenn der Pattern nicht definiert ist -> Exception. 
-- Im unseren Fall werden wir aber der erste Element '1' bekommen.

II. Guards (Wächter)
--------------------

Die Funktion "splitHalf" aus der ersten Aufgabe produziert bei Listen mit einer
ungerader Länge zwei unterschiedlich lange Teillisten.
Es kann es hilfreich sein diesen Fall abzufangen:

> splitHalf'    :: [a] -> ([a], [a])
> splitHalf' xs = if even (length xs)
>                    then splitHalf xs
>                    else error "Listenlaenge ist ungerade!"

1) a) Schreibt die Funktion splitHalf' so um, dass sie mit Wächtern/Guards
      arbeitet und nicht mit einer Verzweigung (if ... then ... else)
      Ihr könnt diese neue Funktion splitHalf'' nennen.

> splitHalf'' :: [a] -> ([a],[a])
> splitHalf'' xs
>              | even $ length xs =  splitHalf xs
>              | otherwise = error "Listenlaenge ist ungerade!"

   b) Entwickelt eine weitere Funktion splitHalf2, die bei Listen mit ungerader
      Länge das mittlere Element in beide Teillisten packt.
      Ihr könnt diese Funktion entweder mit einer Verzweigung oder mit Guards
      implementieren.
      Beispiele:
        splitHalf2 [1,2,3,4]  ergibt  ([1,2],[3,4])
        splitHalf2 [1,2,3]    ergibt  ([1,2],[2,3])
        splitHalf2 "hallo"    ergibt  ("hal","llo")
        
> splitHalf2 :: [a] -> ([a],[a])
> splitHalf2 xs
>        | even $ length xs =  splitHalf xs
>        | otherwise = (take (n+1) xs, drop n  xs)
>         where n = ((length xs) `div` 2)


III. Verzweigungen und Muster
-----------------------------

1) a) Disjunktion:
      Schreibt (analog zur Funktion (&&) aus der Vorlesung) mindestens 2
      Definitionen der Funktion für die Disjunktion:
      "(||) :: Bool -> Bool -> Bool"
      Nutzt hierfür bei einer Definition eine Verzweigung
      (if ... then ... else ...) und bei mindestens einer weiteren den
      Mustervergleich (Pattern matching).

      Da die Funktion (||) bereits im Prelude-Modul definiert ist, solltet Ihr
      diese nicht mit importieren. Fügt hierzu einfach den Funktionsnamen oben
      beim Import von Prelude im "hiding"-Bereich mit an:
      > import Prelude hiding (splitAt, (||))

      Um keinen Namenskonflikt zu bekommen, wenn Ihr die Funktion selbst
      mehrmals definieren wollt, könnt Ihr die Funktionen einfach (||), (|||),
      usw. nennen.
      
> (||) :: Bool -> Bool -> Bool
> (||) a b = if a then a else b

> (|||) :: Bool -> Bool -> Bool
> (|||) a b
>		| a = a
>		| otherwise = b
    



   b) Definiert (ebenfalls mit Hilfe eines Mustervergleichs) eine Funktion
      "lst3", die nur 3-elementige Listen (mit beliebigem Elementtyp)
      verarbeiten kann und diese in ein Tupel mit den gleichen Elementen
      konvertiert.
      Beispiele:
        lst3 [1,2,3]   ergibt   (1,2,3)
        lst3 "abc"   ergibt   ('a','b','c')

      Überlegt Euch hierfür zunächst den Typ dieser Funktion.

      Für Listen mit mehr oder weniger als drei Elementen muss die Funktion
      nicht definiert sein, sie ist also partiell.

> lst3 :: [a] -> (a,a,a)
> lst3 (a:b:c)
>       | length (a:b:c) == 3 = (a,b, head c) 
>       | otherwise = error "diese Funktion ist partiell, nur 3 elementige Listen"


   c) Schreibt eine Funktion "sndLst :: [a] -> a", die mit Hilfe eines
      Mustervergleichs (analog zur Funktion "snd") das zweite Element einer
      beliebig langen Liste ausgibt.
      Beispiel:
        sndLst [1,2,3,4]   ergibt   2

      Für Listen mit weniger als zwei Elementen muss die Funktion nicht
      definiert sein.

> sndLst2 :: [a] -> a
> sndLst2 (x:y:xs) 
>	| length (x:y:xs) >= 2 = y
>	| otherwise = error "not allowed"

IV. freiwillige Zusatzaufgabe: curry-Funktion
---------------------------------------------

Aus der Vorlesung sollte bereits bekannt sein:

> add :: (Int, Int) -> Int
> add (x, y) = x + y

> add' :: Int -> Int -> Int
> add' x y   = x + y

1) Wie muss die funktionsverarbeitende Funktion "curry" definiert werden,
   damit sie aus der Funktion "add" die Funktion "add'" macht?
   Es muss also "add' = curry add" gelten.
   --> Denkt auch hier daran, die Funktion "curry" beim import der Prelude im
       "hiding"-Bereich mit anzugeben, um einen Namenskonflikt zu vermeiden.

> curry :: ((x,y) -> c) -> (x -> y -> c)
> curry f x y = f (x, y)
