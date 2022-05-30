#!/bin/bash

shopt -s globstar
VERSION=$1
CDN_REPLACE="https://joshgrancell.cdn.grancellconsulting.net"
DATE_REPLACE=$(date +'%B %d')
YEAR_REPLACE=$(date +'%Y')

for FILE_PATH in src/content/**; do
  FILE_NAME=$(echo "${FILE_PATH}" | sed 's#src/content/##')
  if [[ -f "src/content/${FILE_NAME}" ]]; then
    {
      cat "src/templates/header.html"
      cat "src/templates/navigation.html"
      cat "src/content/${FILE_NAME}"
      cat "src/templates/footer.html"
    } >> "docs/${FILE_NAME}"

    sed -i "s/YEAR_REPLACE/${YEAR_REPLACE}/g" "docs/${FILE_NAME}"
    sed -i "s/VERS_REPLACE/${VERSION}/g"   "docs/${FILE_NAME}"
    sed -i "s/DATE_REPLACE/${DATE_REPLACE}/g" "docs/${FILE_NAME}"
    sed -i "s#CDN_REPLACE#${CDN_REPLACE}#g" "docs/${FILE_NAME}"

    echo "Generated file ${FILE_NAME}"
  fi
done
