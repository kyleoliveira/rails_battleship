# rails_battleship
A demo that implements the game Battleship in Rails

### Inputs and Outputs

All inputs are strings and outputs are JSON i.e. when running against a local server the following sequence of commands should result in the `PUT` call returning a JSON response that reads `{"result": "hit"}`:

#### Start a game
`curl --data "positions=[[0,3], [4,8], [6,6]]" http://localhost:3000/v1/boards`

#### Fire at a battleship
`curl -X PUT -d x=0 -d y=1 id=BOARD_ID -s http://localhost:3000/v1/battleships`

#### View all boards (useful for finding the BOARD_ID to use)
`curl -s http://localhost:3000/v1/boards`
