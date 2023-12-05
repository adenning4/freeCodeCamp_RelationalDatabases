#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INPUT=$1
if [[ $INPUT ]]
then
  if [[ $INPUT =~ ^[0-9]+$ ]]
  then
    #look up by atomic number
    ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM Elements WHERE atomic_number=$INPUT")
  elif [[ $INPUT =~ ^[A-Z]{1}[a-z]{0,2}$ ]]
  then
    #look up by symbol
    ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM Elements WHERE symbol='$INPUT'")
  elif [[ $INPUT =~ ^[A-Z]{1}[a-z]{3,}$ ]]
  then
    #look up by name
    ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM Elements WHERE name='$INPUT'")
  fi

  if [[ -z $ELEMENT_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    #get properties, all joined
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM Elements INNER JOIN Properties USING(atomic_number) INNER JOIN Types USING(type_id) WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
    echo $ELEMENT_INFO | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi
