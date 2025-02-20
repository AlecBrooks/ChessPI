# ChessPI ♟️
A Chess.com API interaction tool 🎮

This tool is designed to interact with the Chess.com API to download saved games. Chess.com records data for every game you play, and this tool can be used to download a user's records for analysis. There are two primary functions: `archive` and `pull`.

### Features ✨
1. **Archives** 📅
   - Retrieves a list of available months for a user's game history.
   - Useful for identifying specific ranges of games to download.

2. **Pull** ⬇️
   - Downloads the game records associated with a username.
   - Accepts two inputs:
     - **Username**: Specify the Chess.com username.
     - **Range**: Define the range of months to download. If left blank, all games associated with the username will be downloaded (this may take time).
   - If the username input is left blank, it defaults to "Finshed_Milk" for testing purposes.

### Installation 🛠️
Install ChessPI via the following steps:

```R
install.packages("remotes")
remotes::install_github("AlecBrooks/ChessPI/current")
```

### Usage Example 🧰
```R
# Load the library
library(ChessPI)

# Retrieve available months
months <- chessPI.archives(username = "example_user")
print(months)

# Download all games for a user
all_games <- chessPI.pull(username = "example_user")

# Download games for a specific range
range_games <- chessPI.pull(username = "example_user", range = "year/month")

# Test with default username
default_games <- chessPI.pull()
```
