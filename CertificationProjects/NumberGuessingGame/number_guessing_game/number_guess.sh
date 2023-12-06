#!/bin/bash

RANDOM_NUMBER=$((RANDOM%1000 + 1))

echo "Enter your username:"
read USER_PROVIDED_NAME

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USER_PROVIDED_NAME'")

if [[ -z $USER_ID ]]
then
  echo "Welcome, $USER_PROVIDED_NAME! It looks like this is your first time here."
  INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO users(username) VALUES ('$USER_PROVIDED_NAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USER_PROVIDED_NAME'")
  FIRST_GAME=1
else
  # USER_INFO=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'")
  # echo $USER_INFO | while read GAMES_PLAYED BAR BEST_GAME
  USERNAME=$($PSQL "SELECT username FROM Users WHERE user_id='$USER_ID'")
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM Users WHERE user_id='$USER_ID'")
  BEST_GAME=$($PSQL "SELECT best_game FROM Users WHERE user_id='$USER_ID'")
  # do
  echo -e "\nWelcome back, $(echo $USERNAME | sed -E "s/^ *| *$//g")! You have played $(echo $GAMES_PLAYED | sed -E "s/^ *| *$//g") games, and your best game took $(echo $BEST_GAME | sed -E "s/^ *| *$//g") guesses.\n"
  # done
  FIRST_GAME=0
fi

echo -e "\nGuess the secret number between 1 and 1000:"

CORRECT=0
TRIES=0
while [[ $CORRECT = 0 ]];
do
  ((TRIES++))
  read GUESS
  if [[ $GUESS =~  ^[0-9]+$ ]]
  then
    if [[ $GUESS -lt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
    elif [[ $GUESS -gt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    else
      CORRECT=1
    fi
  else
    echo "That is not an integer, guess again:"
  fi
done

echo -e "\nYou guessed it in $TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"

if [[ $FIRST_GAME = 1 ]]
then
  INSERT_GAME_RESULT=$($PSQL "UPDATE Users SET games_played=1, best_game=$TRIES WHERE user_id='$USER_ID'")
else
  UPDATE_GAMES_PLAYED=$(($GAMES_PLAYED + 1))
  if [[ $TRIES -lt $BEST_GAME ]]
  then
    INSERT_GAME_RESULT=$($PSQL "UPDATE Users SET games_played=$UPDATE_GAMES_PLAYED, best_game=$TRIES WHERE user_id='$USER_ID'")
  else
    INSERT_GAME_RESULT=$($PSQL "UPDATE Users SET games_played=$UPDATE_GAMES_PLAYED WHERE user_id='$USER_ID'")
  fi
fi
