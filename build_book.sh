#!/bin/bash
#set -x

version=0.03

SHOW_FILENAME=0

WORK_DIR='.'

read -r -d '' help << 'END'
build_book.sh -- работа с записями.txt как с единым целым.
END

read -r -d '' version_desc << END
build_book.sh $version
END

while getopts ":hvsd:" opt; do
  case $opt in
    h)
      echo $help
      exit
      ;;
    v)
      echo $version_desc
      exit
      ;;
    s)
      SHOW_FILENAME=1
      ;;
    d)
      WORK_DIR=$OPTARG
      ;;
    \?)
      echo "Ошибка: Недопустимая опция -$OPTARG"
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
}

check_work_dir

input_file="0_содержание.txt"

if [[ ! -e "$input_file" ]]; then
    echo "Описание содержания '$input_file' не найдено!"
    exit 1
fi

output_file="output.txt"

> "$output_file"

function add_chapter() {
    echo "======================" >> "$output_file"
    echo "Глава" >> "$output_file"
    echo "======================" >> "$output_file"
}

add_chapter

while IFS= read -r filename; do

    if [[ -z "$filename" ]]; then
        add_chapter
        continue
    fi

    file_path="$filename.txt"

    if [[ -f "$file_path" ]]; then
        if [[ $SHOW_FILENAME -eq 1 ]]; then
            echo -e "[$filename]:\n" >> "$output_file"
        fi

        cat "$file_path" >> "$output_file"
        echo "" >> "$output_file"
    else
        echo "Файл не найден: $file_path" >&2
    fi
done < "$input_file"

echo "Содержимое записей сохранено в $output_file"

char_count=$(cut -d' ' -f1 - <<< $(wc -m $output_file))
echo "Всего знаков: $char_count"

exit
