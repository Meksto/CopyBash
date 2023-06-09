#bash
# Путь к исходной директории
source_dir="$HOME/projects/gitProjects/GitCopyes/RepkaServerCopy"
# Путь к целевой директории
target_dir="$HOME/userBash/COPIED"

# Счетчики для количества скопированных и пропущенных файлов
copied_count=0
skipped_count=0

# Переходим в исходную директорию
cd "$source_dir"

# Цикл по всем файлам в исходной директории
for file in *; do
  # Проверяем, является ли текущий элемент файлом
  if [ -f "$file" ]; then
    # Проверяем, существует ли файл с таким же именем в целевой директории
    if [ -e "$target_dir/$file" ]; then
      # Если файл существует, запрашиваем у пользователя действие
      while true; do
        read -p "Файл '$file' уже существует в целевой директории. Хотите перезаписать его? [Y/N]: " choice
        case "$choice" in
          [Yy]* )
            # Если пользователь выбрал 'Y' или 'y', перезаписываем файл и выходим из цикла
            cp "$file" "$target_dir"
            ((copied_count++))
            break;;
          [Nn]* )
            # Если пользователь выбрал 'N' или 'n', пропускаем копирование и выходим из цикла
            ((skipped_count++))
            break;;
          * )
            # Если введенное значение не 'Y', 'y', 'N' или 'n', повторяем запрос
            echo "Некорректный ввод. Введите 'Y' для перезаписи файла или 'N' для пропуска."
            ;;
        esac
      done
    else
      # Если файл не существует, просто копируем его
      cp "$file" "$target_dir"
      ((copied_count++))
    fi
  fi
done

# Выводим результаты
echo "Скопировано файлов: $copied_count"
echo "Пропущено файлов: $skipped_count"
