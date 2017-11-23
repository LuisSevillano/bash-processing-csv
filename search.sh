#!/bin/bash

# $1 Folder name  $2 Search-text $3 Search-column $4 File $5 Separator

DIR="$1-$2";
SEARCH=$2;
COLUMN=$3;
FILE=$4;

if [ $# -eq 4 ]; then
  # -d check if folder exist
  if [ ! -d "$DIR" ]; then
    mkdir $DIR # creates the folder
    mkdir $DIR/temp
    # awk lets us make complex searches
    awk -v pat1="$COLUMN" -v pat2="$SEARCH" -F ',' 'BEGIN{IGNORECASE=1} $pat1 ~ pat2' $FILE > $DIR/temp/temp.csv
    head -n 1 $FILE > $DIR/temp/headers
    
    # save first row of csv filtered to check if needs the original csv headers
    head -n 1 $DIR/temp/temp.csv > $DIR/temp/first_row
    # compare first rows
    DIFF=`diff $DIR/temp/first_row $DIR/temp/headers`
    if [ -z "$DIFF" ]; then
      cp $DIR/temp/temp.csv $DIR/$DIR".csv"
    else
      # add headers if the filtered csv doens't have them
      cat $DIR/temp/headers $DIR/temp/temp.csv > $DIR/$DIR".csv"
    fi
    # if the script have been successful and it removes temp folder
    if [ -s $DIR/temp/temp.csv ]; then
      rm -rf $DIR/temp
      echo "Data from $FILE and $SEARCH term created"
    else
      # if the search haven't been successful it removes all folders
      echo "Field not found"
      rm -rf $DIR
    fi
  
  else
    echo "You have already processed this files"
  fi
else
  echo "At least one argument is missing:"
  echo
  echo "1. A folder name"
  echo "2. Search-text"
  echo "3. Search-column"
  echo "4. File"
  echo
fi
