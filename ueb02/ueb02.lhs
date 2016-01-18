Aufgabe 2
=========

> import Data.Foldable (Foldable)

Thema: Polymorphie und Typklassen

Aufgabenstellung
----------------

In dieser Aufgabe wollen wir uns mit polymorphen Typen, also Typen die
Typvariablen enthalten, und dem Überladen von Typen beschäftigen.


I.

Guckt euch die Haskell-Typhierarchie unter [1] an. In welchen Fällen
sollte man Typen (z.B. Int oder Char) nutzen und wo sollte man lieber
auf Typklassen (Eq, Ord etc.) zurückgreifen?

[1] https://www.haskell.org/onlinereport/basic.html#standard-classes

Geht es um Generalisierung und Spezialisierung, bzw. Einschränkung oder Verallgemeinerung der Übergabeparameter? 


II.

Gegeben sind die beiden folgenden Funktionsdefinitionen (inkl. Typsignatur):

> longList :: [Int] -> Bool
> longList l = length l > 10

> smaller :: Int -> (Int -> Int)
> smaller x y = if x <= y then x else y

> isEq :: Double -> Double -> Double -> Bool
> isEq x y z = (x == y) && (y == z)

1) a) Was macht die Funktion "longList"?
	Prüft, ob die Länge der Int l größer 10 ist.

   b) Wie müsste der Typ definiert
      werden, damit sie dies nicht mehr ausschließlich für Listen mit Elementen vom
      Typ Int, sondern mit beliebigen Listen (also z.B. auch String) berechnen kann?
      --> Probiert eure Lösung auch aus. Entfernt hierzu z.B. einfach oben die
          '> ' vor der Definition und definiert die Funktion hier neu.

> longListTest3 :: [a] -> Bool
> longListTest3 l = length l > 10 

  Actually for me the later one is working ;) longListTest3 and the import was missing i added it at the beginning.

2) Wie muss der Typ der Funktion "smaller" aussehen, damit sie nicht nur mit
   Int, sondern mit allen Typen funktioniert, auf denen eine Ordnung definiert
   ist?
   --> Probiert eure Lösung mit Zahlen und mit Zeichenketten aus (auf beiden
       Typen ist eine Ordnung definiert.

> smaller2 :: Ord a => a -> (a -> a)
> smaller2 x y = if x <= y then x else y

3) Wie muss der Typ der Funktion "isEq" aussehen, damit sie nicht nur mit
   Double, sondern mit allen Typen funktioniert, auf denen ein Vergleich möglich
   ist?

> isEq1 :: Eq a => a -> a -> a -> Bool
> isEq1 a b c = (a == b) && (b == c)

III.

Analog zu letzter Woche sind nun die Typen einiger Ausdrücke und Funktionen
zu bestimmen.

1.

[(+), (-), (*)] :: Num a => [a -> a -> a]


2.

[(+), (-), (*), mod] :: Integral a => [a -> a -> a]


3.

present :: (Show a, Show b) => a -> b -> [Char]

> present a b = show a ++ ", " ++ show b


4.

showAdd :: Num a => a -> a -> [a]

> showAdd x y = [x, y] ++ [x + y]


IV.

Gegeben ist folgende Additionsfunktion:

addUnit :: (Double, String) -> (Double, String) -> (Double, String)

Der Aufruf
addUnit (2, "kg") (4, "kg")
ergibt (6, "kg").

In welchen Fällen kann eine solche Definition Sinn machen?
Antwort: Konvertierung von verschiedenen Units zu einem Einheitlichen.
Problematisch, wenn mann hier typen nicht beachtet z.B. KG vs Tonnen kann es zu Problemen (z.B. Rakete stürzt ab) führen, deswegen legt man exakte tpyen an und schafft Übergangsfunktionen.
Wenn man das jedoch noch nicht kann machen solche Funktionen "Sinn" allerdings hebelt man die strenge Typisierung sozusagen aus.

