local robot = require("robot")
local args = {...}
local width = args[1]
local length = args[2]
local sleepSeconds = args[3]

if(args[1] == nil or tonumber(args[1]) == nil) then
    error("First arg must be the width of the farm.")
end

if(args[2] == nil or tonumber(args[2]) == nil) then
    error("Second arg must be the length of the farm.")
end

if(args[3] == nil or tonumber(args[3]) == nil) then
    error("Third arg must be the time to sleep, in seconds, between cycles.")
end

function harvest()
    robot.swingDown()
    robot.down()
    robot.suckDown()
    robot.up()
end

function harvestRow()
    for i = 1, length do
        robot.forward()
        if robot.detectDown() then
            harvest()
        end
    end
end

function reverseRight()
    robot.forward()
    robot.turnRight()
    robot.forward()
    robot.turnRight()
end
   
function reverseLeft()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.turnLeft()
end

function emptyInventory()
    local run = true
    local i = 1
    while run do
        robot.select(i)
        run = robot.dropDown()
        i = i + 1
    end
    robot.select(1)
end

function moveToChest()
    for i = 1, length + 1 do
        robot.forward()
    end
    robot.turnRight()
    for i = 1, width - 1 do
        robot.forward()
    end
    robot.down()
    emptyInventory()
    robot.up()
end

function main()
    os.execute("clear")
    print("I'm a happy farmer!")
    local turnRight
    while true do
        turnRight = true
        for i = 1, width do
            harvestRow()
            if turnRight then
                reverseRight()
                turnRight = false
            else
                reverseLeft()
                turnRight = true
            end
        end
        moveToChest()
        robot.forward()
        robot.turnRight()
        os.sleep(tonumber(sleepSeconds))
    end
end

main()
