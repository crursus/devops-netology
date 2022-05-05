## Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

1. Установил golang:
    
    ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-07-terraform-05-golang-01.png)

    * Инструкции: [https://golang.org/](https://golang.org/).
    * Песочница: [https://play.golang.org/](https://play.golang.org/).
---
2. Ознакомился с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  
---
   1. 
       * Написал программу для перевода метров в футы (1 фут = 0.3048 метр):
       ```
       package main
    
       import "fmt"
       import "math"
    
       func main() {
           fmt.Print("Введите длину в метрах: ")
           var input float64
           fmt.Scanf("%f", &input)
    
           output := input / 0.3048
    
           fmt.Println("Искомая длина в футах: ", math.Round(output*100)/100)     
       }
       ```
 
       * Написал программу, которая найдет наименьший и наибольший элемент в любом заданном списке:

        ```
        package main
     
        import "fmt"
     
        func main() {
     
            var x = []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17}
            min, max := findMinAndMax(x)
            fmt.Println("Для последовательности: ", x)
            fmt.Println("Минимальное значение: ", min)
            fmt.Println("Максимальное значение: ", max)
        }
     
        func findMinAndMax(x []int) (min int, max int) {
            min = x[0]
            max = x[0]
            for _, value := range x {
                if value < min {
                min = value
            }
            if value > max {
                max = value
            }
        }
        return min, max
        }
        ```

       * Написал программу, которая выводит числа в диапазоне от 1 до 100, делящиеся на 3:
        ```
        package main

        import "fmt"
        
        func main() {
            i := 3
            for i <= 99 {
                fmt.Print(i," ")
                i = i + 3
            }
        fmt.Print("\n")
        }
        ```

