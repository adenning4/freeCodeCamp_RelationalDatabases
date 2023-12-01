#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    #echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS

    ###insert all teams
    #get team id, if not found, insert it
    WINNER_ID=$($PSQL "SELECT team_id FROM Teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM Teams WHERE name='$OPPONENT'")

    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO Teams (name) VALUES ('$WINNER')")
      if [[ $INSERT_WINNER_RESULT = 'INSERT 0 1' ]]
      then
        echo Inserted into Teams, $WINNER
      fi
    fi
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO Teams (name) VALUES ('$OPPONENT')")
      if [[ $INSERT_OPPONENT_RESULT = 'INSERT 0 1' ]]
      then
        echo Inserted into Teams, $OPPONENT
      fi
    fi
    WINNER_ID=$($PSQL "SELECT team_id FROM Teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM Teams WHERE name='$OPPONENT'")

    ###insert all games
    GAME_RESULT=$($PSQL "INSERT INTO Games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $GAME_RESULT = 'INSERT 0 1' ]]
    then
      echo Game inserted successfully
    fi
  fi
done
