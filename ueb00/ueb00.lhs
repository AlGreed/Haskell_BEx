Übung: Grundlagen der Funktionalen Programmierung
Autor: Malte Heins
Datum: 2015-10-22
Thema: ein paar Beispielfunktionen


> two = 1 + 1

> add x y = x + y

> double x = 2 * x

> multiply a b = a * b

> divide a 0 = error "div by zero"
> divide a b = a / b 


Eine einfache Definition der Fakultätsfunktion, die
mit Hilfe der "product"-Funktion implementiert ist:

> factorial n = product [1..n]


Der Quicksort-Algorithmus:

> qsort [] = []
> qsort (x:xs) = qsort lt ++ [x] ++ qsort ge
>       where lt = [y | y <- xs, y < x]
>             ge = [y | y <- xs, y >= x]
