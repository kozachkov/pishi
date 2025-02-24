#!/bin/bash

if [[ $PWD == */t ]]; then
    echo "Запусти на одном уровне с t/"
    exit
fi

echo "1..5"

assert() {
    if [[ $1 == $2 ]]; then
        echo "ok - $3"
    else
        echo "not ok - $3"
        echo "# Ожидал:  $2"
        echo "# Получил: $1"
    fi
}

NOT_CONTENT_RESULT="Описание содержания '0_содержание.txt' не найдено!"

RESULT=$(source build_book.sh -d asdf)
assert "$RESULT" "'asdf' не путь к записям!" "asdf не путь"

RESULT=$(source build_book.sh -d .)
assert "$RESULT" "$NOT_CONTENT_RESULT" "нет 0_содержание.txt (.)"

RESULT=$(source build_book.sh)
assert "$RESULT" "$NOT_CONTENT_RESULT" "нет 0_содержание.txt"

HELP_RESULT="build_book.sh -- работа с записями.txt как с единым целым."

RESULT=$(source build_book.sh -h)
assert "$RESULT" "$HELP_RESULT" "показ справки"

VERSION=0.03
VERSION_RESULT="build_book.sh $VERSION"

RESULT=$(source build_book.sh -v)
assert "$RESULT" "$VERSION_RESULT" "показ выпуска"
