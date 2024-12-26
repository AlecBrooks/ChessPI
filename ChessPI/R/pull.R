#' Download and output games as a dataframe
#'
#' Pull your games from Chess.com
#'
#' @param username The Chess.com username
#' @param range the date provided by the archive function. If left blank, ALL games for the user will be downloaded.
#' @return A dataset containing the games.
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET status_code headers
#' @importFrom dplyr bind_rows
#' @export
#' @examples
#' games <- chessPI.pull("Finished_Milk","2024/01")
#'
chessPI.pull <- function(username = "Finished_Milk", range = "all") {
  if (range == "all") {
    api_url <- paste0("https://api.chess.com/pub/player/", username, "/games/archives")
    archives <- jsonlite::fromJSON(api_url)[["archives"]]
    combined_games <- data.frame()
    for (archive_url in archives) {
      response <- httr::GET(archive_url)
      if (httr::status_code(response) == 200) {
        message(paste("Downloading games from:", archive_url))
        new_data <- as.data.frame(jsonlite::fromJSON(archive_url))
        combined_games <- dplyr::bind_rows(combined_games, new_data)
      } else {
        message(paste("Failed to retrieve data from:", archive_url))
      }
    }
    return(combined_games)
  } else {
    api_url <- paste0("https://api.chess.com/pub/player/", username, "/games/", range)
    response <- httr::GET(api_url)
    content_length <- httr::headers(response)$`content-length`
    if (is.null(content_length) || as.numeric(content_length) == 0) {
      message(paste("Downloading games from:", api_url))
      return(as.data.frame(jsonlite::fromJSON(api_url)))
    } else {
      message(paste("No games found in archive:", api_url, " bad username or range."))
    }
  }
}
