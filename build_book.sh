#!/bin/bash
#set -x

VERSION=0.05

SHOW_FILENAME=0

WORK_DIR='.'

output_file="output.txt"

TEX=0

read -r -d '' HELP << 'END'
build_book.sh -- работа с записями.txt как с единым целым.
END

read -r -d '' VERSION_DESC << END
build_book.sh $VERSION
END

while getopts ":hvsd:o:t" opt; do
  case $opt in
    h)
      echo $HELP
      exit
      ;;
    v)
      echo $VERSION_DESC
      exit
      ;;
    s)
      SHOW_FILENAME=1
      ;;
    d)
      WORK_DIR=$OPTARG
      ;;
    o)
      output_file=$OPTARG
      ;;
    t)
      TEX=1
      ;;
    \?)
      echo "Ошибка: неизвестный ключ -$OPTARG"
      exit 1
      ;;
  esac
done

check_work_dir() {
    if [[ -z $WORK_DIR ]]; then
        WORK_DIR='.'
    fi

    if [[ ! -d $WORK_DIR ]]; then
        echo "'$WORK_DIR' не путь к записям!"
        exit
    fi

    if [[ "${WORK_DIR: -1}" == '/' ]]; then
        result="${WORK_DIR:: -1}"
    fi
}

check_work_dir

input_file="0_содержание.txt"

input_file="$WORK_DIR/$input_file"
output_file="$WORK_DIR/$output_file"

if [[ ! -e "$input_file" ]]; then
    echo "Описание содержания '$input_file' не найдено!"
    exit 1
fi

> "$output_file"

function add_chapter() {
    echo "======================" >> "$output_file"
    echo "Глава" >> "$output_file"
    echo "======================" >> "$output_file"
}

if [[ $TEX -eq 1 ]]; then
    TEX_DIR="$WORK_DIR/tex"

    if [[ ! -d $TEX_DIR ]]; then
        mkdir -p "$TEX_DIR/sections"
    fi
fi

while IFS= read -r filename; do

    if [[ -z "$filename" ]]; then
        add_chapter
        continue
    fi

    file_path="$WORK_DIR/$filename.txt"

    TEX_FILE_PATH="$WORK_DIR/tex/sections/$filename.tex"

    if [[ -f "$file_path" ]]; then
        if [[ $SHOW_FILENAME -eq 1 ]]; then
            echo -e "[$filename]:\n" >> "$output_file"
        fi


        cat "$file_path" >> "$output_file"

        if [[ $TEX -eq 1 ]]; then
            cp $file_path $TEX_FILE_PATH
        fi

        # СДЕЛАТЬ: для последней записи не добавлять пустую строку
        echo "" >> "$output_file"
    else
        echo "Файл не найден: $file_path" >&2
    fi
done < "$input_file"

echo "Содержимое записей сохранено в $output_file"

char_count=$(cut -d' ' -f1 - <<< $(wc -m $output_file))
echo "Всего знаков: $char_count"

exit
