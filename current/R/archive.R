#' Get Archive List
#'
#' Chess.com organizes its archive of your games by date.
#' This function returns the dates that can be used in the range field of the pull
#' function to narrow down your records.
#' Leaving the input blank will pull my games.
#'
#' @param username The Chess.com username.
#' @return An array of available archive dates.
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' chessPI.archives("Finished_Milk")
#' chessPI.archives()
#'
chessPI.archives <- function(username = "Finished_Milk") {
  username <- gsub(' ', '', username)
  message(paste("Pulling archive list for", username, ". . ."))
  api_url <- paste0("https://api.chess.com/pub/player/", username, "/games/archives")
  df <- jsonlite::fromJSON(api_url) # Explicit namespace usage
  print(substring(df[["archives"]], nchar(df[["archives"]]) - 6))
}
