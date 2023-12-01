#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~ Geo's Salon ~~~~\n"
echo -e "Welcome to Geo's Salon, how may I help you?\n"

SERVICE_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICES=$($PSQL "SELECT service_id,name FROM Services ORDER BY service_id")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  read SERVICE_ID_SELECTED

  SERVICE_NAME=$($PSQL "SELECT name FROM Services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_NAME ]]
  then
    SERVICE_MENU "I could not find that service. What would you like today?"
  else
    APPOINTMENT_MENU $SERVICE_NAME
  fi
}

APPOINTMENT_MENU() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  PHONE_NUMBER_RESULT=$($PSQL "SELECT customer_id FROM Customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $PHONE_NUMBER_RESULT ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO Customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  CUSTOMER_NAME=$($PSQL "SELECT name FROM Customers WHERE phone='$CUSTOMER_PHONE'")

  echo -e "\nWhat time would you like your $1, $(echo $CUSTOMER_NAME | sed -E "s/^ *| *$//g")?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM Customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_ID=$($PSQL "SELECT service_id FROM Services WHERE name='$1'")
  NEW_APPOINTMENT_RESULT=$($PSQL "INSERT INTO Appointments(time, customer_id, service_id) VALUES ('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID)")
  if [[ $NEW_APPOINTMENT_RESULT = 'INSERT 0 1' ]]
  then
    echo -e "\nI have put you down for a $1 at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E "s/^ *| *$//g")."
  fi
}

SERVICE_MENU
