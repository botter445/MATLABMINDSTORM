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
        case '`'  % Quit the loop
            break;
        case 'q'
            brick.MoveMotorAngleRel('D', 100, 3, 'Coast');
        case 'e'
            brick.MoveMotorAngleRel('D', -100, 3, 'Coast');
        case 'j'
            turnRight(brick);
        case 'y'
            brick.GyroCalibrate(4);
            moveForwardGyro(brick,5);
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
        case 't'
            milestonetwo(brick);
        case 'a'
            
            brick.MoveMotor('A',-100);
            brick.MoveMotor('B',100);
            
        case 'd'
            brick.MoveMotor('A',100);
            brick.MoveMotor('B',-100);
        case 'z'
            brick.MoveMotorAngleRel('C', 10, 5, 'Coast');
        case 'x'
            brick.MoveMotorAngleRel('C', -10,  5, 'Coast');
        case '2'
            brick.MoveMotor('C', 0);  % Stop motor C
            brick.MoveMotor('A', 0);
            brick.MoveMotor('B', 0);
        case 'n' 
            brick.GyroCalibrate(4);

            exhaustiveSearch(brick);
        case 'l'
            brick.GyroCalibrate(4);
            color = senseColor(brick);
            Destination = input("Input color destination (G,B,Y): ","s");
            fprintf('Current color sensed: %s\n', color);
            fprintf('Destination color set to: %s\n', Destination); 
            pause(3);
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
function A = milestonetwo(brick)
    funcolor = senseColor(brick);
    switch funcolor
        case 'Red'
            stopMove(brick);
            pause(1);
            moveForward(brick);
        case 'Blue'
            stopMove(brick);
            brick.playTone(412,0.5,50);
            pause(0.1);
            brick.playTone(412,0.5,50);
            pause(1);
            moveForward(brick);
        case 'Green'
            stopMove(brick);
            brick.playTone(412,0.5,50);
            pause(0.1);
            brick.playTone(412,0.5,50);
            pause(0.1);
            brick.playTone(412,0.5,50);
            pause(1);
            moveForward(brick);
    end
    A=0;

end
function A = driveFromGreen(destination,brick)%either blue or yellow
        moveForward(brick);
        %drive forward
        while brick.TouchPressed(3) == 0
            pause(0.1);
        end
        disp(1);
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
        while brick.TouchPressed(3) == 0
            pause(0.1);
        end
        stopMove(brick);
        pause(0.5);
        turnLeft(brick);
        pause(0.5);
        moveForward(brick);
        while brick.TouchPressed(3) == 0
             pause(0.1);
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        turnLeft(brick);
        moveForward(brick);
        pause(2); 
        stopMove(brick);
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
function A = exhaustiveSearch(brick)
        while 1
            if (brick.UltrasonicDist(1)<40 && brick.TouchPressed(3) == 0)

            
            elseif (brick.UltrasonicDist(1)<40 && brick.TouchPressed(3) == 1)
                turnLeft(brick);

            elseif (brick.UltrasonicDist(1)>40 && brick.TouchPressed(3) == 0)
                turnRight(brick);

            elseif (brick.UltrasonicDist(1)>40 && brick.TouchPressed(3) == 1)
                turnRight(brick);

            end
            brick.MoveMotor('A',-50); 
            brick.MoveMotor('B',-50);

            pause(3);   
            brick.MoveMotor('A',0);
            brick.MoveMotor('B',0);
        end
end
function A = turnRight(brick)
        brick.MoveMotorAngleRel('A', 100, 360, 'Coast');
        brick.MoveMotorAngleRel('B', 100, 360, 'Coast'); 
        brick.WaitForMotor('A');


        angle = brick.GyroAngle(4);
        brick.StopAllMotors();
        brick.MoveMotor('A',50);
        brick.MoveMotor('B',-50);
        brick.MoveMotorAngleRel('D', 100, -100, 'Brake'); 
        while abs(angle - brick.GyroAngle(4)) < 90
            pause(0.1);
            disp(abs(angle - brick.GyroAngle(4)));
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        brick.MoveMotorAngleRel('D', 100, 100, 'Brake'); 
        brick.WaitForMotor('D');

        A = 0;
end
function A = turnLeft(brick)
        brick.MoveMotorAngleRel('A', 100, 360, 'Coast');
        brick.MoveMotorAngleRel('B', 100, 360, 'Coast'); 
        brick.WaitForMotor('A');
        brick.StopAllMotors();

        angle = brick.GyroAngle(4);

        brick.MoveMotor('A',-50);
        brick.MoveMotor('B',50);
        brick.MoveMotorAngleRel('D', 100, 100, 'Brake'); 
        while abs(angle - brick.GyroAngle(4)) < 90
            pause(0.1);
            disp(abs(angle - brick.GyroAngle(4)));

        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        brick.MoveMotorAngleRel('D', 100, -100, 'Brake'); 
        brick.WaitForMotor('D');
        A = 0;
end
function A = moveForward(brick)

        brick.MoveMotor('A',-100);
        brick.MoveMotor('B',-100);
        A = 0;
end
function A = moveForwardGyro(brick,time)
        %t step value is built in time is the length
        angle = brick.GyroAngle(4);
        i = 0;
        err = angle;
        currerr = err;
        kp = 25;            
        brick.MoveMotor('A',-100);
        brick.MoveMotor('B',-100);
        while i < (time/0.1)
            pause(0.1);
            err = brick.GyroAngle(4)-angle;
            
            brick.MoveMotorAngleRel('D', 100, (currerr-err)*kp, 'Coast');
            currerr = err;
            disp(err);
            i= i + 1;
        end
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        A = 0;
end
function A = stopMove(brick)
        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        brick.WaitForMotor('A');

        A = 0;

end
