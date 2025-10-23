global key;
%brick = ConnectBrick('EVX'); or 'SUN'   
%Things to do
%1. Actually make the turn functions work and tune them
%2. Actually test any of my code
%3. Have fun
InitKeyboard();
while 1
    pause(0.1);
    switch key
        case 'q'  % Quit the loop
            break;
        case 'j'
            turnRight(brick);
        case 'k'
            turnLeft(brick);
        case 'm'
            moveForward(brick);
        case 'w'
            brick.MoveMotorAngleRel('A', 100, 50, 'Coast');
            brick.MoveMotorAngleRel('B', 100, 50, 'Coast'); 
        case 's'
            brick.MoveMotor('A',-100);
            brick.MoveMotor('B',-100);
            
        case 'a'
            
            brick.MoveMotor('A',-100);
            brick.MoveMotor('B',100);
            
        case 'd'
            brick.MoveMotor('A',100);
            brick.MoveMotor('B',-100);
        case 'z'
            brick.MoveMotorAngleRel('C', 100, 20, 'Coast');
        case 'x'
            brick.MoveMotorAngleRel('C', -100,  20, 'Coast');
        case 'e'
            brick.MoveMotor('C', 0);  % Stop motor C
            brick.MoveMotor('A', 0);
            brick.MoveMotor('B', 0);
        case 'l'
            brick.GyroCalibrate(4);
            color = senseColor(brick);
            Destination = input("Input color destination (G,B,Y): ","s");
            fprintf('Current color sensed: %s\n', color);
            fprintf('Destination color set to: %s\n', Destination); 
            switch color
                case "Green"
                    driveFromGreen(Destination,brick);
                    disp("It was Green")
                case "Yellow"
                    driveFromYellow(Destination,brick);
                    disp("It was Yellow")
                case "Blue"
                    driveFromBlue(Destination, brick);
                    disp("It was Blue")
                case "Red"
                    disp("It was Red")
            end
            
    end
end 
function A = senseColor(brick)
    color = brick.ColorRGB(2);
    if (color(1)>color(3) && color(2)>color(3))
        A = 'Yellow';
    elseif (color(1) > color(2) && color(1) > color(3))
        A = 'Red';
    elseif (color(3) > color(2) && color(3) > color(1))
        A = 'Blue';
    elseif (color(2)>color(3) && color(2)>color(1))
        A = 'Green';
    else 
        A = 'I dont know';
    end
end   
function A = driveFromGreen(destination,brick)%either blue or yellow
        moveForward(brick);
        %drive forward
        while brick.TouchPressed(3) == 0
            pause(0.1);
        end        
        turnLeft(brick);
        %turn right
        pause(0.5);
        moveForward(brick)
        pause(3);
        stopMove(brick);
        turnLeft(brick);
        
        moveForward(brick);
        
        turnRight(brick);
        moveForward(brick);
        while brick.UltrasonicDist(1) > 30
        end
        stopMove(brick);
        if destination == "Blue" || destination == "B"
            turnRight(brick);
            moveForward(brick);
            pause(1);
            turnRight(brick);
            moveForward(brick);
            pause(1);
            stopMove(brick);
        else 
            moveForward(brick);
            while brick.UltrasonicDist(1)>2
            end
            turnLeft(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnLeft(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            stopMove(brick);
        end
        A = 0;
end
function A = driveFromBlue(destination,brick)
        moveForward(brick);
        while brick.TouchPressed(3) == 0
        end
        turnRight(brick);
        moveForward(brick);
        while brick.TouchPressed(3) == 0
        end
        if destination == "Yellow" || destination == "Y"
            turnRight(brick);
            moveForward(brick);
            while brick.UltrasonicDist(1)>2
            end
            turnLeft(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnLeft(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            stopMove(brick);
        else 
            turnLeft(brick);
            
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnLeft(brick);

            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);

            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);
            stopMove(brick);
        end
        A = 0;
end
function A = driveFromYellow(destination,brick)
        moveForward(brick);
        while brick.TouchPressed(3) ==0
            pause(0.1);
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        turnLeft(brick);
        moveForward(brick);
        while brick.TouchPressed(3) ==0
             pause(0.1);
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        turnLeft(brick);
        moveForward(brick);
        pause(2);
        moveStop(brick);
        if destination == "Blue" || destination == "B"
            turnLeft(brick);
            moveForward(brick);
            pause(1);
            turnRight(brick);
            moveForward(brick);
            pause(1);
            stopMove(brick);
        else 
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnLeft(brick);

            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);

            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);
            stopMove(brick);
        end
        A = 0;
end 

function A = turnRight(brick)
        brick.MoveMotorAngleRel('A', 100, 360, 'Coast');
        brick.MoveMotorAngleRel('B', 100, 360, 'Coast'); 
        pause(1);

        angle = brick.GyroAngle(4);
        brick.StopAllMotors();
        brick.MoveMotor('A',100);
        brick.MoveMotor('B',-100);
        while abs(angle - brick.GyroAngle(4)) < 90
            pause(0.1);
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        A = 0;
end
function A = turnLeft(brick)
        brick.MoveMotorAngleRel('A', 100, 360, 'Coast');
        brick.MoveMotorAngleRel('B', 100, 360, 'Coast'); 
        pause(1);
        brick.StopAllMotors();

        angle = brick.GyroAngle(4);

        brick.MoveMotor('A',-100);
        brick.MoveMotor('B',100);
        while abs(angle - brick.GyroAngle(4)) < 90
            pause(0.1);
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        A = 0;
end
function A = moveForward(brick)
        brick.MoveMotor('A',-100);
        brick.MoveMotor('B',-100);
        A = 0;
end
function A = stopMove(brick)
        brick.MoveMotor("A",0);
        brick.MoveMotor("B",0);
        A = 0;
end