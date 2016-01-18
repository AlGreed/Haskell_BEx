Aufgabe 4
=========

Thema: Lambda-Ausdrücke, Listcomprehension

> module Uebung4 where

I. Lambda-Ausdrücke
-------------------

Gegeben sind zwei Listen pairLst und tripleLst mit Zahlentupeln

> pairLst :: Num a => [(a,a)]
> pairLst = [(3,1), (74,75), (17,4), (08,15)]

> tripleLst :: Num a => [(a,a,a)]
> tripleLst = [(1,2,3), (99,99,0), (79,61,83), (4,8,16)]

und eine Funktion sumLst, die eine Liste von Paaren verarbeitet:

> sumLst    :: Num a => [(a,a)] -> [a]
> sumLst xs = map f xs
>             where f (x,y) = x + y

1) a) Die Funktion sumLst ist auf eine der beiden Listen anwendbar,
      welche ist dies und wie sieht das Resultat aus?
	pairLst, [4,149,21,23], also [a]


   b) Wie funktioniert die Funktion sumLst?
	die funktion f addiert die elemente eines tupels, die funktion sumlst wendet f auf alle elemente der liste an.



2) Welchen Typ besitzt die Funktion f, die auf jedes Element der Liste xs
   angewendet wird?
   f :: Num a => (a, a) -> a





3) In welchem Bereich (im Code) ist f sichtbar?
   Kann f beispielsweise in einer komplett anderen Funktion verwendet werden?
	nur innerhalb von sumLst; nein, nur wenn sumLst verwendet wird.



4) Schreibt die Funktion sumLst so um, dass die Funktion f, die auf jedes
   Listenelement angewendet werden soll nicht extra mit 'where' definiert werden
   muss, sondern direkt als Lambda-Ausdruck an das 'map' übergeben wird.
   (Nennt diese neue Funktion dann z.B. sumLst')


> sumLst'    :: Num a => ((a, a) -> a) -> [(a,a)] -> [a]
> sumLst' f xs = map f xs


   Probiert aus, ob die neue Funktion das selbe Ergebnis liefert, wie sumLst.
	sumLst' (\ (x,y) -> x + y)  pairLst
	[4,149,21,23]
	ja

5) Die folgende Funktion multipliziert ihre drei Argumente miteinander.

> mult       :: Num a => a -> a -> a -> a
> mult x y z = x * y * z

   Wie könnte ein Lambda-Ausdruck aussehen, der dieselbe Berechnung durchführt?

> mult2 = (\ x y z -> x * y * z)

   Es gibt mehrere Möglichkeiten, fallen Euch noch weitere ein?
	ja, man kann das z.b. immer weiter schachteln mit mehreren lambda funktionen die jeweils ein argument annehmen



   Um Eure Funktionen zu testen, könnt Ihr die folgende Funktion mapTriple
   verwenden:

> mapTriple  :: Num a => (a -> a -> a -> a) -> [a]
> mapTriple f = map (\ (x,y,z) -> f x y z ) tripleLst

   Was ergibt ein Aufruf von mapTripel mit mult?
   [6,0,399977,512] jedes tripel der triplelst wird mit mult verarbeitet anschließend als liste zurück gegeben





   Überprüft, ob Eure anderen mult-Funktionen dasselbe Ergebnis berechnen.
	ja, natürlich ist das so


II. Listcomprehension
---------------------

1) a) Definiert mit Hilfe einer Listcomprehension eine Funktion
      pairLstGen :: Int -> [(Int,Int)], die eine Liste mit allen Kombinationen
      der Zahlen 1 bis n erzeugt, wobei n als Argument übergeben wird.
      Beispielresultat für n=5:
        pairLstGen 5 = [(1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),...,(5,5)]

> pairLstGen :: Int -> [(Int,Int)]
> pairLstGen n = [ (a,b) | a <- [1..n], b <- [1..n]]

   b) Erweitert die Listcomprehension nun so, dass nur noch die Zahlenpaare
      generiert werden, bei denen die Summe gerade ist.
      Nennt diese Funktion pairLstGenEven.
      Zur Bestimmung, ob eine Zahl gerade ist, könnt Ihr die Funktion even
      aus dem Prelude Modul verwenden.

> pairLstGenEven :: Int -> [(Int,Int)]
> pairLstGenEven n = [ (a,b) | a <- [1..n], b <- [1..n], even(a + b)]


   c) Wieviele "Generator-Regeln" und wieviele "Wächter"/"Guards" habt Ihr in
      1a und 1b jeweils verwendet?
      1a 2 generatoren
      1b 2 generatoren 1 wächter




2) Überprüft Euer Ergebnis aus 1b mit der Funktion sumLst.
   (Kommen hier nur gerade Zahlen raus?)
	klar



   Schreibt hierfür optional noch eine Funktion die das Resultat von sumLst
   auf gerade Zahlen überprüft und als Ergebnis ein Bool ausgibt.
   Ihr könnt diese Funktion beispielsweise wieder mit einer Listcomprehension
   oder mit der Funktion and (aus dem Prelude Modul) umsetzen.
	
> testSumLst :: Integral a => [a] -> Bool
> testSumLst [] = True
> testSumLst (x:xs) = and ([even x] ++ [testSumLst xs])


3) Schreibt die folgende Funktion zur Verarbeitung von Int-Listen so um,
   dass sie nicht mehr mit map, sondern mit einer Listcomprehension arbeitet:

> squareLst    :: [Int] -> [Int]
> squareLst xs = map (\ x -> x*x) xs

   Nennt diese Funktion dann squareLst'.

> squareLst'    :: [Int] -> [Int]
> squareLst' xs = [i*i | i <- xs]





4) Schreibt (ähnlich zu Aufgabe 1a) eine Funktion, die Tripel von Zahlen
   erzeugt, bei denen allerdings das zweite Element nicht kleiner sein darf,
   als das erste Element und das dritte Element darf nicht kleiner sein als das
   zweite Element.
   Verwendet hierfür jedoch _keine_ Wächter-Regeln in der Listcomprehension.
   Beispielresultat für n=5:
     tripleLstGen 5 = [(1,1,1),(1,1,2),(1,1,3),(1,1,4),(1,1,5),(1,2,2),...]

äh... na gut dann eben nen filter draußen, lol

> tripleLstGen ::  Int -> [(Int,Int,Int)]
> tripleLstGen n = filter (\ (a,b,c) -> and ([a <= b] ++ [b <= c])) [(d,e,f) | d <- [1..n], e <- [1..n], f <- [1..n]] 


5) Mit der Funktionen "words :: String -> [String]" kann eine Zeichenkette in
   eine Liste von Wörtern, die durch Leerzeichen getrennt sind, aufgeteilt
   werden. Die Funktion "unwords :: [String] -> String" erzeugt aus einer
   solchen Liste wieder eine einfache Zeichenkette.
   Beispiel: words "Hallo Welt 123"           = ["Hallo", "Welt", "123"]
             unwords ["Hallo", "Welt", "123"] = "Hallo Welt 123"
   Beide Funktionen sind bereits im Modul Prelude definiert.

   a) Entwickelt eine Funktion "yoda :: String -> String", die eine Zeichenkette
      zunächst in eine Liste von Wörtern aufteilt, diese umsortiert und
      anschließend wieder eine Zeichenkette daraus macht.
      Die Umsortierung soll mit Hilfe der Funktion splitHalf (aus der letzten
      Übung) erfolgen, wobei hier die beiden Hälften einfach vertauscht werden

> splitHalf    :: [a] -> ([a], [a])
> splitHalf xs = splitAt (length xs `div` 2) xs

> yoda :: String -> String
> yoda str = (\ (x,y) -> unwords (y++x)) (splitHalf (words str))

      Testet Eure Funktion mit ein paar Sätzen.
      z.B. mit:
        yoda "du hast noch viel zu lernen" 
        ="viel zu lernen du hast noch"
        yoda "ich werde die klausur bestehen"
        ="die klausur bestehen ich werde"
        
        so much wow


   b) Die folgende Aufgabe ist optional:
      Schreibt eine eigene Funktion "myUnwords :: [String] -> String",
      die wie unwords aus einer Liste von Wörtern einen Satz erzeugt.
      Verwendet hierfür jedoch eine Listcomprehension!

> myUnwords :: [String] -> String
> myUnwords [] = ""
> myUnwords [x] = x
> myUnwords (x:xs)  = [i  | i <- x] ++ " " ++ myUnwords(xs)

> myUnwords1 :: [String] -> String
> myUnwords1 [] = ""
> myUnwords1 [x] = x
> myUnwords1 (x:xs)  = x ++ " " ++ myUnwords(xs)

> myUnwords2 :: [String] -> String
> myUnwords2 [] = ""
> myUnwords2 ws = foldr1 (\w s -> w ++ ' ':s) ws

> myUnwords3 :: [String] -> String 
> myUnwords3 words = tail  [x | word <- words, x <- (' ' : word)]
