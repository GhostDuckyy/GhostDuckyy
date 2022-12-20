if (strpos($_SERVER['HTTP_USER_AGENT'], 'Chrome') !== false) {
  // code to be executed if the user is using Chrome
  echo "You are using Chrome!";
} else {
  // code to be executed if the user is not using Chrome
  echo "You are not using Chrome.";
}
