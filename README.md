# Пиши (Pishi)

**Пиши** -- набор решений для написания статей, отчётов, книг и т.п.

- **Латехнарь (latexnar)** -- заготовщик латех (.tex) образцов для последующего
  использования оных при написании статей, книг и т.п.
- **Сшиватель (build\_book)** -- объединитель нескольких .txt в один итоговый .txt.

## Установка и настройка

1. Скачать в нужное тебе расположение:

```bash
/mesto$ git clone https://github.com/kozachkov/pishi.git`
```

2. Создать слабую ссылку на latexnar.sh:

```bash
ln -s /mesto/latexnar.sh /usr/local/bin/latexnar
ln -s /mesto/build_book.sh /usr/local/bin/build_book
```

## Использование

### Сборка .txt записей в единый .txt

Предварительно нужно создать `0_содержание.txt` с построчным описанием названий
.txt для включения (без .txt на конце). Пустая строка -- новая главая. Например:

```
$ ls
Запись_1.txt Запись_2.txt Запись_3.txt Запись_4.txt Запись_5.txt

$ cat 0_содержание.txt
Запись_1
Запись_3

Запись_5
Запись_4
```

И запустить:

```
build_book
build_book [путь-к-рукописи]
```

Если передать ключ -t для build_book, то будет создан tex/sections/ с .tex
записями, соответствующими тем .txt, которые указаны в 0_содержание.

### Создание Латех образцов

В нужном расположении запустить `latexnar`, который создат готовые образцы в
нём.

Для сборки .pdf и просмотра оного выполнить:

```
# Выполнить несколько раз для построениея содержания.
$ pdflatex -shell-escape Main.tex

# Открыть полученный .pdf любым просмотрщиком для них.
$ evince Main.pdf
```

## Разработка

Запуск проверок:

```
make test
```

**Данный README.md собран с помощью build_book.sh и записей из doc/. Вручную не
править!**

