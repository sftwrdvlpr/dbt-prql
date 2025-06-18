#!/bin/bash

prql_common_functions_path="/prql/common_functions"
result_path="common_libraries"
existed_dialects=$(find "$(pwd)$prql_common_functions_path" -mindepth 1 -maxdepth 1 -type d ! -name "generic" | sort | xargs -n1 basename)
mkdir "./$result_path"

for dialect in $existed_dialects; do
  dialect_name=$(echo "$dialect" | cut -d'_' -f1)
  files=$(find "$(pwd)$prql_common_functions_path" -type f -name '*.prql' | grep -E "generic|$dialect_name" | sort)

  rm "$(pwd)/$result_path/$dialect_name.prql"

  for file in $files; do
    if [[ "$file" == *"generic"* ]]; then
      echo "# ===== GENERIC $(basename "$file") =====" >> "$(pwd)/$result_path/$dialect_name.prql"
    else
      echo "# ===== $(echo $dialect_name | tr '[:lower:]' '[:upper:]') $(basename $file) =====" >> "$(pwd)/$result_path/$dialect_name.prql"
    fi

    cat "$file" >> "$(pwd)/$result_path/$dialect_name.prql"
    echo >> "$(pwd)/$result_path/$dialect_name.prql"
    echo >> "$(pwd)/$result_path/$dialect_name.prql"
  done
done