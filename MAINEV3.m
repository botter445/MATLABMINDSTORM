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
            brick.MoveMotorAngleRel('A', 100, 10, 'Coast');
            brick.MoveMotorAngleRel('B', 100, 10, 'Coast'); 
        case 's'
            brick.MoveMotor('A',-100);
            brick.MoveMotor('B',-100);
        case '1'
            brick.StopAllMotors();
        case 't'
            milestonetwo(brick);
        case 'a'
            brick.MoveMotorAngleRel('A', 100, -10, 'Brake');
            brick.MoveMotorAngleRel('B', 100, 10, 'Brake');
            
        case 'd'
            brick.MoveMotorAngleRel('A', 100, 10, 'Brake');
            brick.MoveMotorAngleRel('B', 100, -10, 'Brake');
        case 'z'
            brick.MoveMotorAngleRel('C', 5, 5, 'Coast');
        case 'x'
            brick.MoveMotorAngleRel('C', -5,  5, 'Coast');
        case '2'
            brick.MoveMotor('C', 0);  % Stop motor C
            brick.MoveMotor('A', 0);
            brick.MoveMotor('B', 0);
        case 'n' 
            brick.GyroCalibrate(4);
            Destination = input("Input color destination (Green,Blue,Yellow): ","s");

            exhaustiveSearch(brick,Destination);
        case 'u'
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            stopMove(brick);
            turnRight(brick);
            moveForward(brick);
            pause(3);
            stopMove(brick);
            

        case '3'
            color = senseColor(brick);
            fprintf('Current color sensed: %s\n', color);

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
    brick.MoveMotor('A',-20);
    brick.MoveMotor('B',-20);
    switch funcolor
        case 'Red'
            stopMove(brick);
            pause(1);
            brick.MoveMotor('A',-10); 
            brick.MoveMotor('B',-10);        
        case 'Blue'
            stopMove(brick);
            brick.playTone(412,0.5,50);
            pause(0.1);
            brick.playTone(412,0.5,50);
            pause(1);
            brick.MoveMotor('A',-10); 
            brick.MoveMotor('B',-10);        
        case 'Green'
            stopMove(brick);
            brick.playTone(412,0.5,50);
            pause(0.1);
            brick.playTone(412,0.5,50);
            pause(0.1);
            brick.playTone(412,0.5,50);
            pause(1);
            brick.MoveMotor('A',-10); 
            brick.MoveMotor('B',-10);
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
        color = brick.ColorRGB(2);
        while (not(color(1) > color(2) && color(1) > color(3)))
           pause(0.01);
           color = brick.ColorRGB(2);
        end
        stopMove(brick);
        pause(0.5);
        moveForward(brick);
        pause(2.5);
        stopMove(brick);
        turnLeft(brick);
        
        moveForward(brick);
        while brick.TouchPressed(3) == 0
            pause(0.1);
        end
        turnRight(brick);
        moveForward(brick);
        color = brick.ColorRGB(2);

        while (not(color(1) > color(2) && color(1) > color(3)))
           pause(0.01);
           color = brick.ColorRGB(2);
        end
        stopMove(brick);
        pause(0.5);
        moveForward(brick);
        if destination == "Blue" || destination == "B"
            pause(1.2);
            stopMove(brick);
            pause(0.1);
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            stopMove(brick); 
            pause(0.1);
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end            
            stopMove(brick);
        else 
            color = brick.ColorRGB(2);
            while (not(color(1) > color(2) && color(1) > color(3)))
                pause(0.01);
                color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            stopMove(brick);
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);
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
            pause(0.1);
        end
        stopMove(brick);
        turnLeft(brick);
        moveForward(brick);
        while brick.TouchPressed(3) == 0
            pause(0.1);
        end
        stopMove(brick)
        if destination == "Yellow" || destination == "Y"
            turnRight(brick);
            moveForward(brick);
            color = brick.ColorRGB(2);
            while (not(color(1) > color(2) && color(1) > color(3)))
                 pause(0.01);
                 color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                  pause(0.1);
            end
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                              pause(0.1);
            end
            stopMove(brick);
        else 
            turnLeft(brick);
            
            moveForward(brick);
            color = brick.ColorRGB(2);

            while (not(color(1) > color(2) && color(1) > color(3)))
                pause(0.01);
               color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            turnLeft(brick);

            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            turnRight(brick);

            moveForward(brick);
            color = brick.ColorRGB(2);

            while (not(color(1) > color(2) && color(1) > color(3)))
               pause(0.01);
               color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
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
           color = brick.ColorRGB(2);
            while (not(color(1) > color(2) && color(1) > color(3)))
               pause(0.01);
               color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
        moveForward(brick);
        pause(1.2); 
        stopMove(brick);
        if destination == "Blue" || destination == "B"
            turnLeft(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
             pause(0.1);
            end
            stopMove(brick);
            turnRight(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
                pause(0.1);
            end
            stopMove(brick);
        else 
            moveForward(brick);
                    color = brick.ColorRGB(2);
            while (not(color(1) > color(2) && color(1) > color(3)))
               pause(0.01);
               color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
            
            while brick.TouchPressed(3) == 0
            end
            turnLeft(brick);

            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);
            moveForward(brick);
                    color = brick.ColorRGB(2);
            while (not(color(1) > color(2) && color(1) > color(3)))
               pause(0.01);
               color = brick.ColorRGB(2);
            end
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            turnRight(brick);
            stopMove(brick);
            moveForward(brick);
            while brick.TouchPressed(3) == 0
            end
            stopMove(brick);
        end
        A = 0;
end 
function A = exhaustiveSearch(brick,wheretago)
        moveForward(brick);
        dist = brick.UltrasonicDist(1);
        while 1
            dist = brick.UltrasonicDist(1);
            display(dist);
            if (brick.TouchPressed(3) == 1) % Wall in front
                stopMove(brick);
                pause(0.5);
                dist = brick.UltrasonicDist(1);
                if (dist>45)
                    turnRight(brick);
                    moveForward(brick);
                    pauseForRed(4.3,brick);
                else
                    turnLeft(brick);
                    moveForward(brick);
                    pauseForRed(4.3,brick);
                end
            elseif(dist>45)
                pause(0.9);
                turnRight(brick);
                moveForward(brick);
                pauseForRed(4.3,brick);
            end
            color = senseColor(brick);

            if strcmp(color,wheretago)
                    brick.playTone(412,0.5,50);
                    stopMove(brick);
                    break;
                    
            end
            bcolor = brick.ColorRGB(2);
            display(bcolor);
            if (bcolor(1) > bcolor(2) && bcolor(1) > bcolor(3))
                stopMove(brick);
                pause(0.5);
                moveForward(brick);
            else
            moveForward(brick);
            end

        end
        stopMove(brick);
end
function A = pauseForRed(secs,brick)
    b = secs;
    bcolor = brick.ColorRGB(2);
    while (b>0)
        bcolor = brick.ColorRGB(2);
        if (bcolor(1) > bcolor(2) && bcolor(1) > bcolor(3))
            stopMove(brick);
            pause(0.5);
            moveForward(brick);
        end
        b = b-0.1;
    end
end
function A = turnRight(brick)
        brick.MoveMotorAngleRel('A', 100, 360, 'Coast');
        brick.MoveMotorAngleRel('B', 100, 360, 'Coast'); 
        pause(2);


        brick.StopAllMotors();
        pause(0.1);
        brick.GyroAngle(4)
        angle = brick.GyroAngle(4);


        brick.MoveMotor('A',50);
        brick.MoveMotor('B',-50);

        %%brick.MoveMotorAngleRel('D', 100, -90, 'Coast'); 

        pause(0.1);
        disp(brick.GyroAngle(4));


        while abs(angle - brick.GyroAngle(4)) < 90 || isnan(brick.GyroAngle(4))
            pause(0.01);
        end

        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        %%brick.MoveMotorAngleRel('D', 100, 90, 'Coast');
        %%brick.WaitForMotor('D');

        A = 0;
end
function A = turnLeft(brick)
       brick.MoveMotorAngleRel('A', 100, 360, 'Coast');
        brick.MoveMotorAngleRel('B', 100, 360, 'Coast'); 
        pause(2);

        brick.StopAllMotors();
        pause(0.1);
        brick.GyroCalibrate(4); 
        pause(2);
        brick.GyroAngle(4)
        angle = brick.GyroAngle(4);


        brick.MoveMotor('A',-50);
        brick.MoveMotor('B',50);

        %%brick.MoveMotorAngleRel('D', 90, 100, 'Coast'); 
        pause(0.1);


        while abs(angle - brick.GyroAngle(4)) < 87  || isnan(brick.GyroAngle(4))
            pause(0.01);
        end

        brick.MoveMotor('A',0);
        brick.MoveMotor('B',0);
        %%brick.MoveMotorAngleRel('D', 100, -90, 'Coast'); 
         %%brick.WaitForMotor('D');

        disp("D");

        A = 0;
end
function A = moveForward(brick)

        brick.MoveMotor('A',-40);
        brick.MoveMotor('B',-40);
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
