assert() {
    if [[ $1 == $2 ]]; then
        echo "ok - $3"
    else
        echo "not ok - $3"
        echo "# Ожидал:  $2"
        echo "# Получил: $1"
    fi
}
