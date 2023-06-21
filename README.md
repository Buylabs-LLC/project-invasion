# Project invasion info 
## Info
To install or update the computer/turtle's files set the label to one of the following, using `label set [NAME]` and then run `wget run https://raw.githubusercontent.com/Buylabs-LLC/project-invasion/main/turtle/installer.lua`
- Turtle
- Master
- Router

## Web-Server side
- Built using NextJS
- Handles interacting with the Routing turtle and receiving data from the master turtles
- Maybe the mast turtles use a Post or Put request
- Has a web socket between it and the routing turtle
- Prisma database
## Turtle side
- Reserve up to 2-9 for Master turtles
- Reserve 1 for Router turtle
- Router Turtle’s Jobs
 - Scan for servers
 - Select the best primary server and have automatic fail-over features
- Master Server’s Jobs
 - Tell the Turtles what to do
 - Send the Turtle’s data to the Web-API
- Turtle’s Jobs
 - Reproduce
 - Gather materials
 - infiltrate servers!
## Front-end side
- Built using NextJS
- Uses DaisyUI Plugin
- Control over the Turtles
 - Make them move
 - Make the mine
 - Make them place
 - Make them craft
 - Make them reproduce
- Overview of Turtles
 - Turtle status
 - Turtle cords
 - Turtle inventory
 - Turtle running version
- Overview of Masters
 - Master status?
 - Amount of requests
 - Uptime
 - Running version
## Payload Requests
### Web-API to Routing turtle
{TurtleID: number, ActionType: string, Action: number}
### Master turtle to Web-API
{TurtleID: number, MasterID: number, BaseID: number, DataType: string, Data: string or array}
### Routing turtle to Master turtle
{TurtleID: number, DataType: string, Data: string or array}
### Turtle to Routing turtle
{TurtleID: number, DataType, string, Data: string or array}
### Web-API to front-end
{TurtleID: number, DataType: string, Data: string or array}
### Front-end to Web-API
{TurtleID: number, ActionType: string, Action: string}
## Talking order
- Front-End —> Web-API
- Web-API —> Router computer
- Router Computer —> Turtles
- Router Computer —> Mini-Router
- Mini-Router —> Master Computers
- Mini-Router —> Router Computer
- Master Computers —> Mini-Switch
- Turtles —> Router Computer
